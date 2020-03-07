library(dslabs)
library(dplyr)
data("heights")
options(digits = 3)
mean(heights$height)
ind <- heights$height > 68.3 & heights$sex %in% "Female"
ind2 <- heights$sex == "Female"
min(heights$height)
heights$sex[1032]
x <- min(heights$height):max(heights$height)
ind3 <- !x %in% heights$height # using not in statement
heights2 <- mutate(heights, ht_cm = heights$height * 2.54)
females <- filter(heights2, ht_cm, sex %in% "Female")
mean(females$ht_cm)