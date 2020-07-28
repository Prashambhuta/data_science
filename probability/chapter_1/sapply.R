compute_probability <- function(n, B=10000){
    same_day <- replicate(B, {
        bdays <- sample(1:365, n, replace = TRUE)
        any(duplicated(bdays))
    })
    mean(same_day)
}

# Using sapply (compute_probability) to a value of n,
n <- 1:60
prob <- sapply(n, compute_probability)
plot(n, prob)

# calculating exact probabilities
exact_prob <- function(n){
    prob_unique <- seq(365, 365-n+1)/365
    1 - prod(prob_unique)
}
eprob <- sapply(n, exact_prob)

library(ggplot2)
qplot(n, prob) + geom_line(aes(n, eprob), col = 'orange')