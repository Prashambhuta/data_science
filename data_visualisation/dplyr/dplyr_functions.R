library(tidyverse)


# summarise 'heights' dataset
data("heights")

# for males
s1 <- heights %>% filter(sex=='Male') %>% 
    summarise(average=mean(height), standard_deviation=sd(height),
              median=median(height), minimum=min(height), maximum=max(height))
s1

# .dot Placeholder
# to access columns we can use .$
# example
print(murders %>% .$rate)
print(s1 %>% .$maximum)

# Useful example
# Calculate the total murders rate of Us in millions
us_total_murder_rate <- murders %>% summarise(rate=sum(total)*1000000/sum(population))

# check class of `us_total_murders_rate`
class(us_total_murder_rate)     # it is a dataframe

# to use the same but return as numeric
us_total_murder_rate_numeric <- murders %>% 
    summarise(rate=sum(total)*1000000/sum(population)) %>% .$rate

# check class
class(us_total_murder_rate_numeric)     # it is numeric






