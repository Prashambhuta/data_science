library(tidyverse)

# segregrate the data into regions
western_regions <- c("Northern America", "Western Europe", "Northern Europe", 
                     "Australia and New Zealand", "Southern Europe")

# create a hist based on the groups of region defined
gapminder %>% filter(year %in% c(1970, 2011) & !is.na(gdp)) %>% 
    mutate(group = ifelse(region %in% western_regions, "West", 
                          "Developing World")) %>% 
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black", fill = "yellow") +
    scale_x_continuous(trans = "log2") +
    facet_grid(year ~ group)

# remake the plots for common countries in 1970 & 2011
country_1970 <- gapminder %>% filter(year == 1970 & !is.na(dollars_per_day))

country_2010 <- gapminder %>% filter(year == 2010 & !is.na(dollars_per_day))

# remake the plot using the subset
gapminder %>% 
    filter(year %in% c(1970, 2010) & country %in% 
               intersect(country_1970$country, country_2010$country)) %>%
    mutate(group = ifelse(region %in% western_regions, "Western World", 
                          "Developing")) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black", fill="green") +
    scale_x_continuous(trans = "log2") +
    facet_grid(year ~ group)

# making the boxplot from earlier
gapminder %>% filter(year %in% c(1970, 2010) & country %in% 
                         intersect(country_1970$country, 
                                   country_2010$country)) %>%
    mutate(group = ifelse(region %in% western_regions, "Western", 
                          "Developing")) %>% 
    mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
    ggplot(aes(region, dollars_per_day, fill = continent)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(hjust = 1, angle = 60)) +
    scale_y_continuous(trans = "log2") +
    facet_grid(year ~ .)

# Ease comparison 
# Plot the boxes for each region next to each other
gapminder %>% filter(year %in% c(1970, 2010) & country %in% 
                         intersect(country_1970$country, 
                                   country_2010$country)) %>%
    mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
    mutate(group = ifelse(country %in% western_regions, "Western Country",
                          "Developing")) %>%
    ggplot(aes(region, dollars_per_day, 
               fill = factor(year))) + 
    geom_boxplot() +
    theme(axis.text.x = element_text(hjust = 1, angle = 45)) +
    scale_y_continuous(trans = "log2") 


