if(!requireNamespace("dplyr"))
  install.packages("dplyr")
if(!requireNamespace("here"))
  install.packages("here")
if(!requireNamespace("readr"))
  install.packages("readr")

library(dplyr)
library(here)
library(readr)

################## Set relative directory ##################
# creates an empty file, .here and uses this location as the root directory
# only needs to be done once
#set_here()

################## Load data ##################
# Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/
  
# load airbnb booking dataset
print("Loading data..")
path_raw <- "raw/"
# bookings file
file_book <- "train_users_2.csv"
# bookings dataset
book_raw <- read_csv(paste0(path_raw, file_book))
# number of rows and columns
records_raw <- nrow(book_raw)
fields_raw <- ncol(book_raw)

################## Filter data ##################
print("Cleaning data...")
print("Remove unknown gender values..")
# remove unknown gender
# include only users ages 18 - 80
print("Filter to ages 18 - 80...")
book <- book_raw %>% filter(between(age, 18, 80) 
                            & gender != "-unknown-")

################## Binarize variables ##################
# direct vs. marketing ads
print("Binarize variables..")
book$is_mkt <- if_else(book$affiliate_channel == "direct", 0, 1)

# group book vs. non-booked
book$is_booked <- if_else(book$country_destination == "NDF", 0, 1) 

# binarize english vs. non-english
# consider one-hot key encoding instead
book$is_eng <- if_else(book$language == "en", 1, 0)
# binarize signup app (mobile vs. desktop)
book$is_mobile <- if_else(book$signup_app %in% c("Android", "iOS"), 1, 0)


################## Clean timestamp column ##################
print("Clean timestamp columns..")
## Number of days between account created and first active ##
# convert to date
book$date_first_active <- as.Date(substr(book$timestamp_first_active, 1, 8), "%Y%m%d")
# number of days between account created and date first active
book$days_diff <- as.numeric(book$date_account_created - book$date_first_active, units = "days")

################## Write to csv ##################
print("Write formatted file to csv.")
# write to csv
file_out <- "bookings.csv"
path_out <- "data/"
write_csv(book, path = paste0(path_out, file_out))
paste0("Data cleaning complete! Data is stored in: ", path_out)

records <- nrow(book)
fields <- ncol(book)

paste0("Original Dataset: ", records_raw, " rows and ", fields_raw, " columns.")
paste0("Final Dataset: ", records, " rows and ", fields, " columns.")
