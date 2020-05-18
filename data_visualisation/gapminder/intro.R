# load packages
library(dplyr)
library(ggplot2)

# gapminder dataset
library(dslabs)
data(gapminder)

# get head
head(gapminder)

# filter `infant mortality` for 2 countries
infant_mortality <- function(country1, country2) {
    p <- gapminder %>% filter(year == 2015 & country %in% c(country1, country2)) %>% select(country, infant_mortality)
    print(p)
}

infant_mortality('Sri Lanka', 'Turkey')
infant_mortality('Poland', 'South Korea')
infant_mortality('Malaysia', 'Russia')
infant_mortality('Pakistan','Vietnam')
infant_mortality('Thailand', 'South Africa')

# scatter plot of life-expectancy vs fertlity rate
data <- gapminder %>% filter(year == 1962) %>% ggplot(aes(fertility, life_expectancy, color = continent)) + geom_point(size=3)
print(data)

