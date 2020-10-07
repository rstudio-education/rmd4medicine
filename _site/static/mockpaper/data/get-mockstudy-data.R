# export mockstudy data to an xls file

library(writexl)
library(arsenal)
library(janitor)
library(randomNames)
library(tidyverse)

# load the data
data(mockstudy)

mockstudy <- mockstudy %>% 
  janitor::clean_names()

# add sites in 
mock_sites <- mockstudy %>% 
  mutate(site = c(rep("Portland", 100), rep("Ann Arbor", 100), rep("St. Louis", 100),
                  rep("Rochester", 100), rep("New Haven", 100), rep("Boston", 100),
                  rep("Chapel Hill", 100), rep("Gainesville", 100), rep("Denver", 100),
                  rep("Los Angeles", 100), rep("Seattle", 100), rep("New York", 100),
                  rep("Madrid", 50), rep("Barcelona", 50), rep("Rio de Janeiro", 50),
                  rep("Sao Paulo", 50),
                  rep("Mexico City", 84), rep("Nur-Sultan", 15))
  ) %>% 
  mutate(country = c(rep("USA", 1200), rep("Spain", 100), rep("Brasil", 100),
                     rep("Mexico", 84), rep("Kazakhstan", 15))
  )

# note race is NA for 7 obs
# we'll collapse these into "Other" category
mock_sites %>% 
  count(race)

# to generate random names, need to do some recoding of race variable
mock_names <- mock_sites %>% 
  mutate(race = replace_na(race, "Other")) %>% 
  # note that "Other" gets mapped to "Middle-Eastern, Arabic"
  mutate(ethnicity = case_when(
    race == "Hispanic" ~ "Hispanic",
    race == "African-Am" ~ "Black (not Hispanic)",
    race %in% c("Asian", "Hawaii/Pacific") ~ "Asian or Pacific Islander",
    race == "Caucasian" ~ "White (not Hispanic)",
    race == "Native-Am/Alaska" ~ "American Indian or Native Alaskan",
    race == "Other" ~ "Middle-Eastern, Arabic"
    )) %>% 
  mutate(name = randomNames(
    ethnicity = ethnicity,
    gender = sex,
    name.order = "first.last",
    name.sep=" "),
    first_name = word(name),
    last_name = word(name, start = 2L))

# generate random adverse events
irox_ae <- 0.14
ifl_ae <- 0.07

# adding specific adverse events
mock_adverse <- mock_names %>% 
  mutate(ae_seed = case_when(
    str_detect(arm, "FOLFOX") ~ runif(n = nrow(.), min = 0, max = 1),
    str_detect(arm, "IROX") ~ runif(n = nrow(.), min = 0, max = 1) + irox_ae,
    str_detect(arm, "IFL") ~ runif(n = nrow(.), min = 0, max = 1) + ifl_ae,
  )) %>% 
  mutate(ae_low_wbc = if_else(ae_seed < 0.23, 1, 0)) %>% 
  mutate(ae_neuropathy = if_else(ae_seed > 0.05 & 
                                ae_seed < 0.23, 1, 0)) %>% 
  mutate(ae_diarrhea = if_else(ae_seed > 0.02 & ae_seed < 0.26, 1, 0)) %>%
  mutate(ae_vomiting = if_else(ae_seed > 0.06 & ae_seed < 0.26, 1, 0)) %>%
  mutate(ae_blood_clot = if_else(ae_seed > 0.13 & ae_seed < 0.18, 1, 0)) %>% 
  select(-ae_seed) 

# make it mock_plus in case we add anything else
mock_plus <- mock_adverse 

expected_counts <- mock_plus %>% 
  count(site, name = "n_expected") %>% 
  mutate(n_expected = case_when(
    site == "Nur-Sultan" ~ 50,
    TRUE ~ as.numeric(n_expected)))

write_csv(expected_counts, here::here("static/mockpaper/data/expected_counts.csv"))

write_xlsx(x = mock_plus, 
           path = here::here("static/mockpaper/data/mockdata.xlsx"), 
           col_names = TRUE)

write_csv(x = mock_plus, 
           path = here::here("static/mockpaper/data/mockdata.csv"))

# for 01, use just mock_sites data
set.seed(1984)
write_csv(x = mock_sites %>% 
            filter(site == "Boston") %>% 
            sample_n(50), 
          path = here::here("static/mockpaper/data/mockboston.csv"))

set.seed(1984)
write_csv(x = mock_sites %>% 
            filter(site %in% c("Boston", "Seattle", "Denver")) %>% 
            group_by(site) %>% 
            nest() %>% 
            ungroup() %>% 
            mutate(n_samp = c(50, 62, 78)) %>% 
            mutate(samp = map2(data, n_samp, sample_n)) %>% 
            select(site, samp) %>% 
            unnest(cols = c(samp)),
          path = here::here("static/mockpaper/data/mockbsd.csv"))

# for 02, use mock_adverse, unfiltered
set.seed(1984)
write_csv(x = mock_adverse %>% 
            group_by(site) %>% 
            nest() %>% 
            ungroup() %>% 
            mutate(n_tot = map_int(data, ~nrow(.))) %>% 
            mutate(n_samp = floor(.8*n_tot)) %>% 
            mutate(samp = map2(data, n_samp, sample_n)) %>% 
            select(site, samp) %>% 
            unnest(cols = c(samp)),
          path = here::here("static/mockpaper/data/mockprogress.csv"))
