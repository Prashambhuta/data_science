library(tidyverse)
# normal distribution has mathematically defined in R.
# pnorm(a, avg, s)

x <- heights %>% filter(sex=="Male") %>% pull(height)

# Estimate the probability of male taller than 70.5 inches
1 - pnorm(70.5, mean(x), sd(x))

# probabilitydistribution of exact height in data
plot(prop.table(table(x)), xlab = "height", ylab = "probability")


