library(tidyverse)
employees <- read_csv("employees-seed.csv")
library(babynames)
library(readxl)
lastnames <- read_excel("Top1000-last-names.xls", skip = 1)
lastnames_titlecase <- lastnames %>% mutate(name = str_to_title(name))

set.seed(1)
tbl_size <- 250
firstnames <- babynames %>% 
  filter(year == 2015 & prop > 0.0025) %>% 
  sample_n(tbl_size, replace = TRUE) %>% select(FirstName = name)
lastnames <- lastnames_titlecase %>% sample_n(tbl_size, replace = TRUE) %>% select(LastName = name)
department_and_function <- employees %>% sample_n(tbl_size, replace = TRUE) %>% select(Department, Function)
department <- department_and_function %>% select(Department)
jobfunction <- department_and_function %>% select(Function)
location <- employees %>% sample_n(tbl_size, replace = TRUE) %>% select(Location)
hiredate <- employees %>% sample_n(tbl_size, replace = TRUE) %>% select(HireDate)

new_employees <- cbind(firstnames, lastnames, department, jobfunction, location, hiredate)
write.csv(new_employees, "newco-employees.csv")
new_employees %>% filter(Function == "President")

