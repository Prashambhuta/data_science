# The number of experiments to be run in Monte carlo, can be
# decided by the stability of the responses received.

# For the birthday problem, we try multiple values of B, ranging from
# 10 to 10^n

B <- 10^seq(1, 5, len = 100)

compute_prob <- function(B, n = 10){
    same_day <- replicate(B, {
        bdays <- sample(1:365, n, replace =TRUE)
        any(duplicated(bdays))
    })
    mean(same_day)
}

prob <- sapply(B, compute_prob)
plot(log10(B), prob, type = "l")