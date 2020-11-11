# CLT is used to cross-check the distribution function of sum of draws/poll.
# We know that 'p' is unknown, but assuming 'p' we can cross check the 
# SE and E of sample.
p <- 0.42
N <- 1000 
draws <- sample(c(1,0), N, replace = TRUE, prob=c(p, 1-p))
mean(draws)

# Running Monte-Carlo simulation
B <- 10000
draws <- replicate(B, {
    x <- sample(c(1,0), N, replace = TRUE, prob=c(p,1-p))
    mean(x)
})
mean(draws)
sd(draws)

# Plotting the draws
library(tidyverse)
library(gridExtra)
p1 <- data.frame(draws = draws) %>% ggplot(aes(draws)) +
    geom_histogram(binwidth = 0.005, color = 'grey')
p2 <- data.frame(draws = draws) %>% ggplot(aes(sample = draws)) +
    stat_qq(dparams = list(mean = mean(draws), sd = sd(draws))) + 
    geom_abline() +
    ylab("X Total") + xlab("Theoretical normal")
grid.arrange(p1, p2, nrow = 1)


# How SE changes with larger sample size
N <- 100000
p <- seq(0.35, 0.65, length = 100)
SE <- sapply(p, function(x) 2*sqrt((x*(1-x))/N))
data.frame(p =p, SE = SE) %>% ggplot(aes(p, SE)) +
    geom_line()

# At p=0.5, the SE is 0.3 % 