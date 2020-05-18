# compare life expectancy vs fertility for years 1962 & 2012
# using facet_grid(row~column)
ds_theme_set()
filter(gapminder, year %in% c(1962,2012)) %>% 
    ggplot(aes(fertility, life_expectancy, col=continent)) + 
    geom_point(size =2.5) + 
    facet_grid(.~year)

# adding multiple rows & columns, using facet_wrap
gapminder %>% filter(year %in% c(1962, 1970, 1980, 1990, 2000, 2012)) %>%
    ggplot(aes(fertility, life_expectancy, col=continent)) +
    geom_point(size=2.5) +
    facet_wrap(.~year)