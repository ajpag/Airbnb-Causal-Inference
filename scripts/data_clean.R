if(!requireNamespace("dplyr"))
  install.packages("dplyr")
if(!requireNamespace("here"))
  install.packages("here")
if(!requireNamespace("readr"))
  install.packages("readr")

library(dplyr)
library(here)
library(readr)

################## Load data ##################
# Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/
  
# load airbnb booking dataset
print("Loading data..")
path_raw <- "raw"
# bookings file
file_book <- "train_users_2.csv"
# bookings dataset
book_raw <- read_csv(here(path_raw, file_book))
# number of rows and columns
records_raw <- nrow(book_raw)
fields_raw <- ncol(book_raw)

################## Filter data ##################
print("Cleaning data...")
print("Filtering Data..")
# remove unknown gender
# include only users ages 18 - 80
print("Filter to ages 18 - 80...")
book <- book_raw %>% filter(between(age, 18, 80) 
                            & gender != "-unknown-")
                          
################## Group browser types ##################                        
# Keep Top 5 browser types and group remainder into "Other"
top_browsers <- c("Chrome", "IE", "Firefox", "Safari", "Mobile Safari")
book$browser_group <- if_else(!book$first_browser %in% top_browsers, 
                              "Other",
                              book$first_browser)

################## Binarize variables ##################
print("Binarize variables..")
# direct vs. non-direct ads
# direct = 1, all other = 0
book$treat <- if_else(book$affiliate_channel == "direct", 1, 0)

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
print("Writing formatted file to csv..")
# write to csv
file_out <- "bookings.csv"
path_out <- "data"
write_csv(book, here(path_out, file_out))
paste0("Data cleaning complete! Data is stored in: ", path_out)

records <- nrow(book)
fields <- ncol(book)

################## Write to csv ##################
print("Writing formatted file to csv..")
# write to csv
file_out <- "bookings_sample.csv"
path_out <- "data"
sample_size <- 40000
book_sample <- sample_n(book, sample_size, replace = FALSE)
write_csv(book, here(path_out, file_out))
paste0("Data cleaning complete! Data is stored in: ", path_out)

records_sample <- nrow(book_sample)
fields_sample <- ncol(book_sample)

paste0("Original Dataset: ", records_raw, " rows and ", fields_raw, " columns.")
paste0("Final Dataset: ", records, " rows and ", fields, " columns.")
paste0("Final Sampled Dataset: ", records_sample, " rows and ",  fields_sample, " columns.")
