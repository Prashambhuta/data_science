

# Smooth Density plots
western_regions <- c("Northern America", "Western Europe", "Northern Europe", 
                     "Australia and New Zealand", "Southern Europe")
# Calculate no of countries in "Western" & "Developing"

gapminder %>% filter(year == 1970 & !is.na(gdp)) %>% 
    mutate(group = ifelse(region %in% western_regions, "West", 
                          "Developing World")) %>% 
    group_by(group) %>%
    summarise(n=n()) %>% knitr::kable()

# Smooth density plot 1
p <- gapminder %>% filter(year %in% c(1970,2011) & !is.na(gdp)) %>%
    mutate(group = ifelse(region %in% western_regions, "Western Region", 
                          "Developing countries")) %>%
    ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
    scale_x_continuous(trans = "log2") 
p + geom_density(alpha = 0.25, bw = 0.66) + facet_grid(year ~ .)

# filter key regions separately
# Use of 'case_when' equvivalent of if & if_else
gapminder <- gapminder %>%
    mutate(group = case_when(
        .$region %in% western_regions ~ "West",
        .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "Asia",
        .$region %in% c("Caribbean", "Central America", "South America") ~ 
            "Latin America",
        .$continent == "Africa" & .$region != "Northern Africa" ~ 
        "Sub-Saharan Africa",
        TRUE ~ "Other regions"
    ))
# Creating groups based on region
gapminder <- gapminder %>% 
    mutate(group = factor(group, levels = c("Other regions",
                                            "Latin America", 
                                            "Sub-Saharan Africa",
                                            "West", "Asia")))

# Creating density plot based on new groups
p <- gapminder %>% 
    filter(year %in% c(1970, 2011) & country %in% intersect(
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country, 
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country
    )) %>%
    ggplot(aes(dollars_per_day, fill = group)) +
    scale_x_continuous(trans = "log2")

p + geom_density(alpha = 0.25, bw = .75) + facet_grid(year ~.)

# Creating stacked density plot with weights
p <- gapminder %>% 
    filter(year %in% c(1970, 2011) & country %in% intersect(
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country, 
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country
    )) %>%
    ggplot(aes(dollars_per_day, fill = group)) +
    scale_x_continuous(trans = "log2")

p + geom_density(alpha = 0.25, bw = .75, position = "stack") + 
    facet_grid(year ~.) +
    ggtitle("Density plot for various regions for 1970 & 2011")

# Adding the weight argument based on the population
p <- gapminder %>% 
    filter(year %in% c(1970, 2011) & country %in% intersect(
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country, 
        gapminder %>% filter(year == 1970 & !is.na(gdp)) %>%.$ country
    )) %>%
    mutate(weight = population/sum(population)*2) %>%
    ungroup() %>%
    ggplot(aes(dollars_per_day, fill = group, weight = weight)) +
    scale_x_continuous(trans = "log2")

p + geom_density(alpha = 0.25, bw = .75, position = "stack") + 
    facet_grid(year ~.) +
    ggtitle("Density plot for various regions for 1970 & 2011")
