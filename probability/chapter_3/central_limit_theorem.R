# for a random variable average can be calculated as the sum inside the urn
# and sd as `sqrt(n) * abs(b-a) * sqrt(prob(a)*(1-prob(a)))`

# for example I can score penalty with a probability of 0.7
# for 10 tries each attempt generates a binomial random number (1 & -1)
# the average score after 10 tries will be
(0.7) * 10

# the standard deviation will be
10**0.5 * 0.4 * (0.7*(0.3))**0.5
# 0.57 

# Using pnorm we can find out the probability for less than 5 goals
pnorm(5, 7, 0.57)

# for the casino roulette, mean for 1000 players is
mean <- 1000*2/38
mean # 52.6

# standard error is
se <- (1000**0.5) * 2 * ((10/19)*(9/19))**0.5
se # 31.5

# to calculate the probability of casino losing money
pnorm(0, mean, se) # 4.8 %
