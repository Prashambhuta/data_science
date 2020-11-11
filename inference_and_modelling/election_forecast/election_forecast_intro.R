library(tidyverse)
library(dslabs)
head(polls_us_election_2016)

# Selecting only National polls & on the last date.
polls <- polls_us_election_2016 %>% filter(state == 'U.S.' & enddate>='2016-10-31')
head(polls)

# selecting only grade A, B polls
polls <- polls %>% filter(grade %in% c('A+', 'A', 'A-', 'B') | is.na(grade)) %>% mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# selecting only 1 poll per pollster
one_poll_per_pollster <- polls %>% group_by(pollster) %>% filter(enddate == max(enddate)) %>% ungroup()

# adding summary of avg spread, and SE of spread.
results <- one_poll_per_pollster %>% 
    summarise(avg = mean(spread), se =sd(spread)/sqrt(length(spread))) %>% 
    mutate(low = avg - 1.96*se, high = avg + 1.96*se)
results

# calculating values using hierarchical models and historical data of polls, we assume the historical with initial spread 'mu' = 0, and standard deviation 'tau' = 0.035, our sampling distribution of Expected value Y given mu is 'd' = spread of polls, and 'sigma' SE of polls.
mu <- 0
tau <- 0.035
d <- results$avg
sigma <- results$se
B <- sigma^2/(sigma^2 + tau^2) # weighted average of SE

posterior_mean <- B*mu + (1-B)*d
posterior_mean

posterior_se <- sqrt(1/((1/sigma^2) + 1/tau^2))
posterior_se

# The confidence interval is 
posterior_mean + c(-1.96, 1.96)*posterior_se

# The probability of spread being 0, i.e. Pr(d > 0 | posterior_mean)
1 - pnorm(0, posterior_mean, posterior_se)
# There is negligible probability of spread being in favor of either a tie , Y =0 or Trump win, CI < 0..
