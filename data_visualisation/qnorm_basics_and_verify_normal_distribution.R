# Using qnorm
# qnorm returns the value at the particular quantile.
# eg. qnorm(0.25, mean, sd) returns the value at 25 quantile.

# qnorm() is usd to check if data follows normal distribution or not.
# lets try for "heights" example

summary(heights$height)
percentile <- seq(0.05, 0.95, 0.05)

# convert the vector to standarised units
z <- scale(heights$height)

# qnorm values at the percentile, if not using Standard Units do: `qnorm(percentile, mean, sd)`
theoretical_quantile <- qnorm(percentile)
plot(qnorm)

# quantile of z at percentile, if not using Standard Units do: `quantile(heights$height, percentile)`
observed_quantile <- quantile(z, percentile)

# plot two quantile against one another and use abline(0, 1).
plot(theoretical_quantile, observed_quantile)
abline(0,1)

# Dots, and line match therefore the given dataset follows the normal distribution curve.
