# export mockstudy data to an xls file

library(writexl)
library(arsenal)

# load the data
data(mockstudy)

write_xlsx(x = mockstudy, path = "./data/mockstudy.xlsx", col_names = TRUE)
