# The theorem states that the probability of (A given B) = Pr(B given A)*Pr(A)/Pr(B)
# Lets take an example of cystic fibrosis disease, which is prevalent in 1 out of 4000 people.
# The test accuracy is 0.99
# Suppose for n= 100000 people, let us use Bayesian statistics to find the the ratio of true positives to false positives.
p <- 1/4000
N <- 100000
outcome <- sample(c("Disease", "Healthy"), N, replace = TRUE, prob = c(p, 1-p))

# people with disease and healthy people
sum(outcome == 'Disease')
sum(outcome == 'Healthy')

# adding the testing accuracy data to this
acc <- 0.99
test <- vector('character', N)
test[outcome == 'Disease'] <- sample(c("+", "-"), sum(outcome == 'Disease'), replace = TRUE, prob = c(acc, 1-acc))
test[outcome == 'Healthy'] <- sample(c("-", "+"), sum(outcome == 'Healthy'), replace = TRUE, prob = c(acc, 1-acc))

table(outcome, test)

# Observation shows that 28 were True positive, while 1045 were False Positive, therefore the ratio/probability of finding a truly positive person is 28/1073 i.e. around 2%

