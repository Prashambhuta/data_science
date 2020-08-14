# WHAT HAPPENS IF A EVENTS ALTERATES THE PROBABILITY OF DEFAULTING FOR
# EVERY LOAN

# We have interest r = 0.05, therefore the expected value for 180000 $ loan, 
# with a probability of going default at 4 %.
prob <- 0.04
n <- 100000
loss <- -200000
r <- 0.05

# earning on each loan
loss*prob + (r*180000)*(1-prob)
# we make 640$ on each loan given at 5% interest.

# calculating the SE
sqrt(0.04*0.96)*abs(loss-(0.05*180000))
# 40955

# calculating the number of loans required
ceiling((2.32**2)*(40955**2)/(640**2))
# we need 22041 loans

# let's calculate the total profit for 22041 loans
22041*640 # 14 million $

# let's run the monte carlo simulation for the same
B <- 10000
profit <- 0.05*180000
loss <- -200000
total_profit <- replicate(B, {
    draws <- sample(c(loss, profit), 22041, replace = TRUE, 
                    prob = c(0.04, 0.96))
    sum(draws)
})
mean(total_profit) # 13.9 million $
mean(total_profit < 0) # 0.01

# PROBABILITY OF GOING DEFAULT ARE NOT INDEPENDENT OF EACH OTHER, THERE ARE
# SITUATIONS WHERE THE PROBABILITY CHANGE
p <- 0.04
profit <- 0.05*180000
new_profit <- replicate(B, {
    new_p <- 0.04 + sample(seq(-0.01, 0.01, length = 100), 1)
    draws <- sample(c(loss, profit), 22041, replace = TRUE,
                    prob = c(new_p, (1-new_p)))
    sum(draws)
})
mean(new_profit) # the profit remains the same

# lets calculate the probability of default
mean(new_profit < 0)
# ITS A WHOPPING 30%, lets visualise it.

library(tidyverse)
library(ggplot2)
as.data.frame(new_profit) %>% ggplot(aes(new_profit/1000000)) + 
    geom_histogram(binwidth = 5, col='grey')

# AS WE CAN SEE THE DISTRIBUTION IS NO LONGER A NORMAL DISTRIBUTION, AND THE 
# PROBABILITY OF SEEING LESS THAN 0 PROFITS (GOING DEFAULTS) SUDDENLY 
# INCREASES WITH LITTLE VARIATION IN PROBABILITY.