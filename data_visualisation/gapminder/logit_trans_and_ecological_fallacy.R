# Looking at variability within the group, logit function and ecological 
# fallacy, where conclusion based on multiple countries in one region have
# high number of variability.

# defining few more regions
western_regions <- c("Northern America", "Western Europe", "Northern Europe", 
                     "Australia and New Zealand", "Southern Europe")
east_asia <- c("Eastern Asia", "South-Eastern Asia")
latin_america <- c("Caribbean", "Central America", "South America")
pacific_islands <- c("Melanesia", "Micronesia", "Polynesia")

gapminder <- gapminder %>% mutate(group = case_when(
    .$region %in% east_asia ~ "East Asia", 
    .$region %in% western_regions ~ "Western Regions", 
    .$region %in% latin_america ~ "Latin America",
    .$region == "Northern Africa" ~ "North Africa",
    .$continent %in% "Africa" & .$region != "Northern Africa" ~ 
        "Sub-Saharan Africa",
    .$region %in% pacific_islands ~ "Pacific Islands",
    .$region == "Southern Asia" ~ "Southern Asia"
 ))

# calculating the quantities where are interested in
surv_income <- gapminder %>%
    filter(year == 2011 & !is.na(gdp) & !is.na(infant_mortality) & 
               !is.na(group)) %>%
    group_by(group) %>%
    summarise(income = sum(gdp)/sum(population)/365, 
              infant_survival_rate = 1 - sum(infant_mortality/1000*population)
              /sum(population))
surv_income %>% arrange(income)

# plotting surv_income
# using the limit argument to change the range of the axis
surv_income %>% ggplot(aes(income, infant_survival_rate, label = group, 
                           color =group)) +
    scale_x_continuous(trans = "log2", limits = c(0.25, 250)) +
    scale_y_continuous(trans = "logit", limits = c(0.85,0.999),
                       breaks = c(0.85, 0.90, 0.93, 0.97, 0.995, 0.999)) +
    geom_label(size = 4, show.legend = FALSE)