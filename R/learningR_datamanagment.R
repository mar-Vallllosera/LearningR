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


# New object --------------------------------------------------------------
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

#Look if it is study, CTRL+SHIFT+P --> syle
#Commit the project, CTRL+SHIFT+P --> commit
