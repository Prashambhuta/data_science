# poll aggregration is about combining the results of many polls to simulate
# a single poll with large sample size which reduces SE

# Let us first simulate a poll
d <- 0.039 # observed spread value
Ns <- c(1298, 533, 1342, 897, 774, 254, 812, 324, 1291, 1056, 2172, 516)
p <- (d+1)/2

# calculating the confidence interval of spread
ci <- sapply(Ns, function(N){
    X <- sample(c(1,0), N, replace = TRUE, prob = c(p, 1-p))
    X_hat <- mean(X)
    SE_hat <- sqrt(X_hat*(1-X_hat)/N)
    2*c(X_hat, X_hat-2*SE_hat, X_hat+2*SE_hat) -1 # spread of mean of spread
})

# generating polls dataframe
polls <- data.frame(poll = 1:ncol(ci), t(ci), sample_size = Ns)
names(polls) <- c('poll', 'estimate', 'low', 'high', 'sample_size')
polls

# calculating the spread of combined polls

library(dplyr)
d_hat <- polls %>% 
    summarise(avg = sum(estimate*sample_size)/sum(sample_size)) %>% 
    .$avg
d_hat
p_hat <- (d_hat+1)/2
p_hat
moe <- 2*1.96*sqrt(p_hat*(1-p_hat)/sum(polls$sample_size))
round(d_hat*100, 1)
round(moe*100, 1)

# poll data
library(dslabs)
data("polls_us_election_2016")
names(polls_us_election_2016)

# keep only national polls from week before election with a good grade
polls <- polls_us_election_2016 %>% 
    filter(state == 'U.S.' & enddate >= "2016-10-31" & 
               (grade %in% c("A+", "A", "A-", "B+") | is.na(grade)))
head(polls)

# add spread column
polls <- polls %>% 
    mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# compute estimated spread for all polls
d_hat <- polls %>% 
    summarise(d_hat = sum(spread * samplesize)/ sum(samplesize)) %>%
    .$d_hat

# compute margin of error
p_hat <- (d_hat+1)/2
p_hat
moe <- 1.96*2*sqrt(p_hat*(1-p_hat)/sum(polls$samplesize))
moe

# hist of the %>%  spread
library(tidyverse)
polls %>% ggplot(aes(spread)) +
    geom_histogram(color='black', binwidth = 0.01)


