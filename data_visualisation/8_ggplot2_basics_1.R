# murders dataset is already loaded from in the environment
#
# first import ggplot library
library(tidyverse)

# define a ggplot object and associate data with it
p <- murders %>% ggplot(aes(population_in_millions, total, label=abb)) +

# you can also use pipe %>%
# eg `murders %>% ggplot()`

# adding geom_text to the plots
geom_text(nudge_x = 0.04, nudge_y = 0.031) +

# changing scales to logarithmic
scale_x_continuous(trans = "log10") +
scale_y_continuous(trans = "log10") + 
xlab("Population in Millions") +
ylab("Total (Log scale)") +
    # adding title
    ggtitle("US total murders for state vs state population")
    
# define the line of avg murder rate in us
r <- murders %>% summarise(rate = sum(total) / (sum(population)) * 10^6) %>% .$rate
    
        
    # adding abline of average murders rate
        p <- p + geom_abline(intercept = log10(r), colour = "darkgrey", lty = 2, size = 1.3 ) +
    
    # adding geom_point with color argument
    geom_point(aes(col = region), size = 2.4) +
        
    # capitalising the label `region`
    scale_color_discrete(name = "Regions in US") 
    
# adding themes and other embellishments
library(ggthemes)
    
# adding theme to our plot
    p + theme_economist()

# adding repel to improve text view of the plot
    # p + geom_text_repel()
