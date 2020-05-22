library(tidyverse)

# understanding dollars per day for 1970
gapminder <- gapminder %>% mutate(dollars_per_day = gdp/(population*365))

previous_year <- 1970
country <- c("India", "China")

gapminder %>% filter(year == previous_year & !is.na(gdp)) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color="black") +
    scale_x_continuous(trans = "log2")


# Plotting using boxplot
gapminder %>% filter(year == previous_year & !is.na(gdp)) %>%
    mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
    ggplot(aes(region, dollars_per_day, fill = continent)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle=45, hjust =1)) +
    # xlab("") +
    scale_y_continuous(trans = "log2") +
    geom_point(show.legend = FALSE)