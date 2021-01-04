# **Airbnb-Causal-Inference**
*Diana Liang, Andrew Pagtakhan*

Airbnb Causal Analysis to measure the impact of direct vs. indirect marketing ad exposure on user bookings

Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/

## Dashboard
https://public.tableau.com/profile/andrew.pagtakhan#!/vizhome/NYU_Causal_Airbnb/Dashboard

## Presentation
https://github.com/ajpag/Airbnb-Causal-Inference/blob/main/presentation/airbnb_causal_inference.pdf

## Directories

```/data```: formatted data for analysis

```/raw```: raw data. Excludes *sessions.csv* due to GitHub file size limits on this plan

```/scripts```: data cleaning script

## Data dictionary

https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/data

Derived columns:

```treat```: derived from *affiliate_channel*. 1 = "direct", 0 = all other values

```is_booked```:  derived from *country_destination*. 0 = "NDF", 1 = all other values

```is_eng```: derived from *language*. 1 = "en", 0 = all other values

```is_mobile```: derived from *signup_app*. 1 = "en", 0 = all other values

```date_first_active```: converts *timestamp_first_active* into a Date object

```days_diff```: # of days between *days_first_active* and *date_account_created*

## Variables used in analysis

Outcome: ```is_booked```

Treatment: ```treat```

Covariates: ```age```, ```gender```, ```is_eng```, ```is_mobile```, ```browser_group```



