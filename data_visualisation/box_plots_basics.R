# understanding 'boxplots'
# boxplots are great for data that doesnt match the normal distribution, i.e. data that is skewed

# Using for murders data
library(dslabs)
data(murders)

rate_per_million <- (murders$total/(murders$population/1000000))
