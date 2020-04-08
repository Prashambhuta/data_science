# understanding 'boxplots'
# boxplots are great for data that doesnt match the normal distribution, i.e. data that is skewed

# Using for murders data
library(dslabs)
data(murders)

rate_per_million <- (murders$total/(murders$population/1000000))
boxplot(rate_per_million, xlab="US states", ylab="Rate per Million Population")

# Comparing male & female heights. Boxplot is useful for such cases.
females <- heights$height[heights$sex =="Female"]
boxplot(females, males, main="Boxplot", names=c("Females", "Males"),xlab = "Height Distribution", ylab = "Height in (in.)", col = c("powderblue", "mistyrose"))