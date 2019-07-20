# export mockstudy data to an xls file

library(writexl)
library(arsenal)
library(janitor)

# load the data
data(mockstudy)

# note race is NA for 7 obs
# we'll collapse these into "Other" category
mockstudy %>% 
  count(race)

# to generate random names, need to do some recoding of race variable
mock_names <- mockstudy %>% 
  janitor::clean_names() %>% 
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
  mutate(name = randomNames(ethnicity = ethnicity,
                            gender = sex,
                            name.order = "first.last",
                            name.sep=" "),
         first_name = word(name),
         last_name = word(name, start = 2L))

# generate random adverse events
irox_ae <- 0.14
ifl_ae <- 0.07

mock_adverse <- mock_names %>% 
  mutate(ae_seed = case_when(
    str_detect(arm, "FOLFOX") ~ runif(n = nrow(.), min = 0, max = 1),
    str_detect(arm, "IROX") ~ runif(n = nrow(.), min = 0, max = 1) + irox_ae,
    str_detect(arm, "IFL") ~ runif(n = nrow(.), min = 0, max = 1) + ifl_ae,
  )) %>% 
  mutate(low_wbc = if_else(ae_seed < 0.23, 1, 0)) %>% 
  mutate(neuropathy = if_else(ae_seed > 0.05 & 
                                ae_seed < 0.23, 1, 0)) %>% 
  mutate(diarrhea = if_else(ae_seed > 0.02 & ae_seed < 0.26, 1, 0)) %>%
  mutate(vomiting = if_else(ae_seed > 0.06 & ae_seed < 0.26, 1, 0)) %>%
  mutate(blood_clot = if_else(ae_seed > 0.13 & ae_seed < 0.18, 1, 0)) %>% 
  select(-ae_seed) %>% 
  mutate(fu_stat = as.factor(fu_stat))

write_xlsx(x = mock_adverse, 
           path = here::here("mockpaper/data/mockstudy_adverse.xlsx"), 
           col_names = TRUE)
