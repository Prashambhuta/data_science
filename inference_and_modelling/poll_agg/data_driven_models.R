# data driven model is explained to minimise pollster bias, first let us
# select the polls with the last end date
library(dslabs)
data("polls_us_election_2016")
one_poll_per_pollster <- polls %>% group_by(pollster) %>%
    filter(enddate == max(enddate)) %>% ungroup()
one_poll_per_pollster
nrow(one_poll_per_pollster)

# plotting histogram for 15 pollster
qplot(spread, data = one_poll_per_pollster, binwidth = 0.01)

# understanding the filtered data
head(one_poll_per_pollster$spread)

# expected value is the spread, and standard deviation can be calculated
# using sd
sd(one_poll_per_pollster$spread)

# create a new confidence interval for spread.
results <- one_poll_per_pollster %>%
    summarise(avg = mean(spread), 
              se = sd(spread)/sqrt(length(spread))) %>% 
    mutate(left = avg - 1.96*se, right = avg+1.96*se)
results
