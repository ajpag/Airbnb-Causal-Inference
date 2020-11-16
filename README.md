# **Airbnb-Causal-Inference**
*Diana Liang, Andrew Pagtakhan*

Airbnb Causal Analysis to measure the impact of marketing ad exposure on user bookings

Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/

## Directories

```/data```: formatted data for analysis

```/raw```: raw data. Excludes *sessions.csv* due to GitHub file size limits on this plan

```/scripts```: data cleaning script

## Dependencies
```tidyverse```

```here```

## Data dictionary

https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/data

Derived columns:

```is_mkt```: derived from *affiliate_channel*. 0 = "direct", 1 = all other values


```is_booked```:  derived from *country_destination*. 0 = "NDF", 1 = all other values

```is_eng```: derived from *language*. 1 = "en", 0 = all other values

```is_mobile```: derived from *signup_app*. 1 = "en", 0 = all other values

```date_first_active```: converts *timestamp_first_active* into a Date object

```days_diff```: # of days between *days_first_active* and *date_account_created*
