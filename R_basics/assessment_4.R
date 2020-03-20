library(dslabs)
data(heights)

# Write an ifelse() statement that returns 1 if the sex is Female and 2 if the sex is Male.
# What is the sum of the resulting vector
sum(ifelse(heights$sex %in% "Female", 1, 2))
# 1862

# Write an ifelse() statement that takes the height column and returns the height if it is greater than 72 inches and returns 0 otherwise.
# What is the mean of the resulting vector?
mean(ifelse(heights$height > 72, heights$height, 0))
# 9.653

# Write a function inches_to_ft that takes a number of inches x and returns the number of feet. One foot equals 12 inches.
# What is inches_to_ft(144)?
inches_to_ft <- function(x) {
    x/12
}

# How many individuals in the heights dataset have a height less than 5 feet?
height_in_ft <- inches_to_ft(heights$height)
ind <- height_in_ft < 5
sum(ind)
    