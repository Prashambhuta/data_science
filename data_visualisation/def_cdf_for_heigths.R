data("heights")
range_of_values <- seq(min(heights$height), max(heights$height), 01)
cdf_function <- function(x) {   # cummulative distribution function
    mean(heights$height <= x)
}
cdf_values <- sapply(range_of_values, cdf_function)
plot(range_of_values, cdf_values)
hist(heights$height[heights$sex == "Male"])