## understanding quantile, percentile and quartile of a vector.

# quantile - divide the dataset into intervals with set probability.
# for heights example, quantile determines which value lies in the quantile zone.

# eg quantile(x, 0) returns the min value in the vector.
quantile(heights$height, 0)

# quantile(x, 1) returns the max value in the vecotor
quantile(heights$height, 1)

# quantile(x, 0.5) returns the median value
quantile(heights$height, 0.5)

# percentile - are quantiles that divide the dataset in parts of 100.
percentile <- c(0, 1, 0.01)
quantile(heights$height, percentile)

# quartile - divides the dataset into 4 parts of 25% percentile each.
# use summary() to get max, min and quartile of a vector
summary(heights$height)


