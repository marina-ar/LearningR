# Here's an example of conflict.
10

# R basics ----------------------------------------------------------------

weight_kilos <- 100
weight_kilos <- 10

colnames(airquality)
str(airquality)
summary(airquality)

2 + 2

2 + 2


# Packages ----------------------------------------------------------------
library(tidyverse)
library(NHANES)
# This will be used for testing out Git



# looking at data ---------------------------------------------------------

glimpse(NHANES)

# data frame is not changed, we juset select a part of it
select(NHANES, Age, Weight, BMI)

# drop a variable
select(NHANES, -HeadCirc)

# select all variables that start with BP, similar functions: ends_with adn contains
select(NHANES, starts_with("BP"))

select(NHANES, ends_with("Day"))
select(NHANES, contains("Age"))

nhanes_small <- select(
  NHANES,
  Age,
  Gender,
  BMI,
  Diabetes,
  PhysActive,
  BPSysAve,
  BPDiaAve,
  Education
)
nhanes_small


# Fixing variable names ---------------------------------------------------

# change teh camel case to snake format
nhanes_small <- rename_with(
  nhanes_small,
  snakecase::to_snake_case
)
nhanes_small

nhanes_small <- rename(
  nhanes_small,
  sex = gender
)
nhanes_small


# piping ------------------------------------------------------------------

colnames(nhanes_small)
nhanes_small %>%
  colnames()
nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)
