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

# practice ----------------------------------------------------------------

nhanes_small %>%
  select(
    bp_sys_ave,
    education
  )

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

nhanes_small %>%
  select(
    bmi,
    contains("age")
  )


nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)

# filtering rows ----------------------------------------------------------

nhanes_small %>%
  filter(phys_active != "No")

#  instead of & using comma means the same by default
nhanes_small %>%
  filter(bmi >= 25 &
    phys_active == "No")

# | means or. Technically this logic can give you anything from the table just because it offers the option bmi is 25 or phys active is no.
nhanes_small %>%
  filter(bmi == 25 |
    phys_active == "No")

# arranging rows ----------------------------------------------------------


nhanes_small %>%
  arrange(desc(age), bmi, education)

# mutating columns --------------------------------------------------------

nhanes_update <- nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_week = age_month * 4,
    old = if_else(age >= 30,
      "old",
      "young"
    )
  )

# practicing 2 ------------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
  # Format should follow: variable >= number or character
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
  mutate(
    # 2. Calculate mean arterial pressure
    mean_arterial_pressure = ((2 * bp_dia_ave) + bp_sys_ave) / 3,
    # 3. Create young_child variable using a condition
    young_child = if_else(age < 6, "Yes", "No")
  )

nhanes_modified
