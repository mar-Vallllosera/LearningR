# Library loading ---------------------------------------------------------

library(tidyverse)
library(NHANES)
# (remember to create a section ctrl+shift+p--> new section)

# Looking at the data -----------------------------------------------------

# Brief glimpse of the data, this will let us know all row columnes and the type of character (dbl is number with
# decimals)
glimpse(NHANES)

# to only select one part of the large data set and then you select the columnes/rows that you want.
# In tidyverse, the data set is the first. In this case is select(dataframe,column). By assigning we do not change
# the data set only what we seee.

select(NHANES, Age)

# To add more info in the screen
select(NHANES, Age, Weight)
select(NHANES, Age, Weight, BMI)

# To exclude something, first data  and then "," and then "-" what you want to exclude for each variable you
# want to exclude

select(NHANES, -HeadCirc)
select(NHANES, -HeadCirc, -ID)

# to select everyting that starts with a letter or word, starts_with("variable"); also based on the ending
# or if you want to see which colomunes have or contains a character or a word

select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("Ag"))


# New object or data set --------------------------------------------------------------
# Create a new data set with a new name with lower colomunes and rows to work with

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

# look the object
nhanes_small

# Look if it is study, CTRL+SHIFT+P --> syle
# Commit the project, CTRL+SHIFT+P --> commit


# Fixing variable names ---------------------------------------------------

# data set is in camel case and we want snake format for that we do rename with and you can
# rename the variables. Using rename wtih and then adding the data set follow but the snake case, we are
# telling R to cahnge the name in all the data set with that style. This is because the snakecase :: is
# already a package that you can use to rename the data set.

nhanes_small <- rename_with(
  nhanes_small,
  snakecase::to_snake_case
)
nhanes_small

# Using view () we can open a new screen with the data set that we select
view(nhanes_small)

# New enhcance to assign only 1 variable, when we use = to rename, the name before the "=" is the new
# name and the name after the "="  is the old name

nhanes_small <- rename(
  nhanes_small,
  sex = gender
)


# Piping ------------------------------------------------------------------
colnames(nhanes_small)

# Piping %>% (ctrl+shift+M, to the short cut of piping)

nhanes_small %>%
  colnames()

# When you use piping, you do not need to add the data name afterwards, since it is already at the star
# of the code you can directly add what you ant to do

nhanes_small %>%
  select(phys_active) %>%
  rename(
    physically_active = phys_active
  )
# run the styler to make sure the code is tidy, and then commit
# examples:
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
view(nhanes_small)

# first ad the data then pipe, then we select the columnes we want, then we need
# to pipe to conitnue fromt hat colmunes selctec for that reason we add the %>%
nhanes_small %>%
  select(
    starts_with("bp_")
  ) %>%
  rename(
    bp_systolic = bp_sys_ave
  )


# Filtering rows ----------------------------------------------------------
# Filtering is depending on the logic that you apply, so it is challanging to apply filtering
# when doing filtering double check with others to assure that is the correct way.
# == translate to it is equal to, in this case we are filtering those that are inactive

nhanes_small %>%
  filter(phys_active == "No")

# Adding the exclamation mark in front fo the =, leads to not eqaul to No
nhanes_small %>%
  filter(phys_active != "No")

# for eaqual to a number

nhanes_small %>%
  filter(bmi == 25)

# for eaqual or above to a number
nhanes_small %>%
  filter(bmi >= 25)
# greater than the number and adding another filtering, for example in this case if they also active
# in this case we use &, but "," is the same.
nhanes_small %>%
  filter(bmi >= 25 &
    phys_active == "No")
# for or  | (ctrl+alt + key with bar in the bottom)
nhanes_small %>%
  filter(bmi == 25 |
    phys_active == "No")

# Arranging rows ----------------------------------------------------------
# You can arrange the data set based by different rows
nhanes_small %>%
  arrange(age)
# if you want decending order addd (desc())
nhanes_small %>%
  arrange(desc(age))
# adding an extra factor to re arrange, in this case bmi, ideally 1 or 2 is the best to sort out

nhanes_small %>%
  arrange(desc(age), bmi)


# Mutating columns --------------------------------------------------------

# The muate works as modifying or creating and it is the same as rename new= old, this is modify
# an exiciting colomune

nhanes_small %>%
  mutate(
    age = age * 12
  )

# to add a new columne you need to rename to something that did not excites before
nhanes_small %>%
  mutate(
    age_month = age * 12
  )
# you can allways add more than 1 columne by using the comma "," at the end of each new colmun that
# you added.
nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4
  )
# previous we can use the age_month for age weeks, buecase the age_month is created before and the
# muate with piping it follows 1 after the other.

# for logic mutatation in the data set, if_else, is a logic command, and we can use that if something is ....
# then do.... In this case old if the age is = or above 30 if not it is young.

nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4,
    old = if_else(
      age >= 30,
      "old",
      "young"
    )
  )

# to safe the data set with the mutation you can do
nhanes_update <- nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4,
    old = if_else(
      age >= 30,
      "old",
      "young"
    )
  )
