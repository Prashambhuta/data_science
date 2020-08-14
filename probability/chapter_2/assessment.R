# Continuous Probability Assessment
# Question 1 and 2
library(tidyverse)
set.seed(16, sample.kind = 'Rounding')

# generate rnorm
act_scores <- rnorm(10000, 20.9, 5.7)

# Q1 mean of act scores
mean(act_scores)

# Q2 sd of act scores
sd(act_scores)

# how many scores are >= 36
sum(act_scores >= 36)

# probability of score greater than 30
sum(act_scores > 30)/length(act_scores)

# less than equal to 10
sum(act_scores <= 10)/10000

# Question 2
x <- seq(1:36)
f_x <- dnorm(x, 20.9, 5.7)
plot(x, f_x)

# Question 3
z_scores <- (act_scores - mean(act_scores))/sd(act_scores)
z_scores

# 1: probability of z score greater than 1
sum(z_scores > 2)/length(z_scores)

# 2: what is the score for z_score > 2
2*sd(act_scores) + mean(act_scores)

# expected value at 95 percentile
qnorm(0.975, 20.9, 5.7)

# expected value at 95 percentile for normally distributed data
qnorm(0.975, mean(act_scores), sd(act_scores))

# Question 4
ceiling(qnorm(0.95, mean(act_scores), sd(act_scores)))

# calculating quantiles
p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)
sample_quantiles
plot(sample_quantiles)

# plotting theoretical quantiles
theoretical <- qnorm(p, 20.9, 5.7)
qqplot(sample_quantiles, theoretical)

