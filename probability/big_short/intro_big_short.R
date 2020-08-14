# introduction to big short
# if bank loses 200000$ at 2% probability for 1000 loans, calculate how much 
# total sum they lose
n <- 1000
loss <- -200000
prob <- 0.02
total <- sample(c(1,0), n, replace = TRUE, prob = c(prob, 1-prob))
sum(total* loss)

# running the Monte Carlo simulation for the same, with 10000 experiments.
B <- 10000
losses <- replicate(B, {
    defaults <- sample(c(1,0), n, replace = TRUE, prob = c(prob, 1-prob))
    sum(defaults * loss)
})
mean(losses)
# total average losses is around 4 million USD ($)

# plotting the same
library(tidyverse)
data.frame(in_millions = losses/10^6) %>% ggplot(aes(in_millions)) +
    geom_histogram(binwidth = 0.4, col = 'grey')

# we can do this using Central Limit Theorem
# mean = n*(a*p + (1-p)*b)
# sd = sqrt(n) * abs(b-a) * sqrt(p*(1-p))
average_loss = 1000*(200000*0.02 + (1-0.02)*0)
average_loss # 4 million$
sd = sqrt(n) * abs(loss-0) * sqrt(prob*(1-prob))
sd # 0.8 million$

# lets calculate the interest rate of break even, ie. average_loss = 0
# 0 = (0.02*-200000) + x*(1-0.02)
# x = (0.02*200000) / 0.98
break_even = (0.02*200000)/0.98
break_even # 4081$

# for a loan of 180000, interest rate is ~2% to break even, i.e. 50/50

# to compute for chance of loss to be 1 in 100, what should be x?
interests <- seq(4100, 7000, 200)
losses <- replicate(B, {
    defaults <- sample(c(1, 0), n, replace = TRUE, 
                       prob = c(prob, 1-prob))
    no_defaults <- sum(defaults)
    total <- (no_defaults*loss + (1000-no_defaults)*4100)
})
mean(losses < 0) # 44 percent of simulation result in loss

# lets try with 6000
losses <- replicate(B, {
    defaults <- sample(c(1, 0), n, replace = TRUE, 
                       prob = c(prob, 1-prob))
    no_defaults <- sum(defaults)
    total <- (no_defaults*loss + (1000-no_defaults)*6000)
})
mean(losses < 0) # 2 percent of simulation result in loss

# lets try with 6200
losses <- replicate(B, {
    defaults <- sample(c(1, 0), n, replace = TRUE, 
                       prob = c(prob, 1-prob))
    no_defaults <- sum(defaults)
    total <- (no_defaults*loss + (1000-no_defaults)*6200)
})
mean(losses < 0) # 1 percent of simulation result in loss
# A GOOD VALUE FOR INTEREST IS
6200/180000 # ~3 %

# EXPECTED VALUE AT 3%
(loss*prob + 6200*(1-prob))*1000
# We make on average 2 million $




