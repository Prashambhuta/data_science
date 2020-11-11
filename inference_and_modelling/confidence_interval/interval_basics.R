# we know the value of p, and when we run MonteCarlo simulation we can say that 95% of the time 'p' will be 2 SD away from p-hat.
library(tidyverse)
p <- 0.45
N <- 1000
B <- 10000
p_is_inside <- replicate(B, {
    X <- sample(c(1,0), N, replace = TRUE, prob = c(p,1-p))
    p_hat <- mean(X)
    SE_p_hat <- sqrt(p_hat*(1-p_hat)/N)
    between(p, p_hat - 2*SE_p_hat, p_hat + 2*SE_p_hat)
})
mean(p_is_inside)

# 0.95 prob

# EXERCISE
library(dslabs)
data("polls_us_election_2016")

# select national polls ending 1 week before election
polls <- polls_us_election_2016 %>% filter(enddate>='2016-10-31' & state == "U.S.")

# 1. calculate the confidence interval for Clinton of poll '1'.
N <- polls$samplesize[1]
x_hat <- polls$rawpoll_clinton[1]/100
SE_hat <- sqrt(x_hat*(1 - x_hat)/N)
con_int <- c(x_hat - 1.96*SE_hat, x_hat + 1.96*SE_hat)

# 2. add se_hat, lower, upper intervals to poll object
polls <- polls %>% mutate(x_hat = rawpoll_clinton/100, se_hat = sqrt(x_hat*(1-x_hat)/samplesize), lower = x_hat - 1.96*se_hat, upper = x_hat + 1.96*se_hat)
clinton_data <- polls %>% select(pollster, enddate, x_hat, lower, upper)

# 3. add TRUE/FALSE column 'hit' if p=0.482 was in c(lower, upper)
clinton_data <- clinton_data %>% rowwise %>% mutate(hit = between(0.482, lower, upper))

# 4. what proportion of confidence interval included 'p'
mean(clinton_data$hit)

# 6. mutate the polls to include spread
polls <- polls %>% mutate(d_hat = rawpoll_clinton/100 - rawpoll_trump/100)

# 7, 8. recalculate hit for spread, d = 0.021, calculate what proportion of polls include the d.
spread_data <- polls %>% mutate(se_dhat = sqrt(d_hat*(1-d_hat)/samplesize)) %>% replace_na(se_dhat, 0) %>% mutate(lower = d_hat - 1.96*se_dhat, upper = d_hat + 1.96*se_dhat)
spread_data <- spread_data %>% rowwise %>% mutate(hit = between(0.021, lower, upper))
mean(spread_data$hit)
