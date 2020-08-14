# using commutative distribution function to get probability in a continuous 
# dataframe
library(tidyverse)
library(dslabs)
data(heights)

males <- heights %>% filter(sex == 'Male') %>% .$height

# defining the ecdf function
E <- function(a) mean(males<=a)

# what is the probability of person being greater than 70
1 - E(70)

# the probability of student being between height 'a' and 'b' is simply 
# E(b) - E(a)

# the probability of student being between height 72 and 74 is
E(74) - E(70)
# 31 percent

# monte carlo simulations using rnorm()
n <- length(males)
avg <- mean(males)
sd <- sd(males)
standard_heights <- rnorm(n, avg, sd)

ggplot(data.frame(standard_heights), aes(standard_heights)) + geom_histogram(color='black', binwidth = 2)

# running monte carlo simulation
B <- 10000
MC <- replicate(B, {
    standard_heights <- rnorm(800, avg, sd)
    max(standard_heights)
})

# calculating probability of height greater than 7 feet (84 inch)
mean(standard_heights >= 7*12) # 0
