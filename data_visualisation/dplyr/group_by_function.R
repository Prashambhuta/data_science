library(dplyr)

# calculate avg, sd of height after applying group_by
group_by_summary <- heights %>% group_by(sex) %>% summarise(average_height = mean(height), standard_deviation = sd(height))
print(group_by_summary)

# calculate avg, sd for murder rate in 'murders' dataframe
group_by_murder_s <- murders %>% group_by(region) %>% summarise(median_rate = median((total*1000000)/population))
print(group_by_murder_s)