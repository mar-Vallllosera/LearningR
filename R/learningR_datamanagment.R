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
#run the styler to make sure the code is tidy, and then commit
