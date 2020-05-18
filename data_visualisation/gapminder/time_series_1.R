library(tidyverse)

# time series plot
gapminder %>% filter(country %in% c('Germany', 'South Korea')) %>% ggplot(aes(year, fertility, col = country)) +
    geom_line()

# adding labels instead of legends
labels <- data.frame(country = c('India', 'Germany'), x = c(1975, 1965), y = c(60, 72))
gapminder %>% filter(country %in% c('India', 'Germany')) %>% 
    ggplot(aes(year, life_expectancy, col = country)) +
    geom_line() +
    geom_text(data = labels, aes(x, y, label = country), size = 5) +
    theme(legend.position = "none")
