#' ---
#' title: "Star Properties"
#' author: "Prasham Bhuta"
#' date: "June 4, 2020"
#' ---

#' # Properties of star excercises
#' ## Loading the dataframe
library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)

#' ## Getting summary of the dataframe
summary(stars)
str(stars)

#' ## Analysis 1
#' * Mean magnitude is: 4.26
#' * Standard deviation is: 7.35
# Calculate the standard deviation
sd_magnitude <- stars %>% select(magnitude) %>% 
    summarise(sd = sd(magnitude)) %>% 
    .$sd
print(sd_magnitude)

#' ## Make a density plot of magnitude
#' ### Analysis
#' * There are 2 peaks, one at -1 and another at +12.5
# Density plot for magnitude
stars %>% select(magnitude) %>% ggplot(aes(magnitude, y=..count..)) + 
    geom_density(alpha = 0.25, fill='lightblue') +
    scale_x_continuous(breaks = c(-5,0,5,10,15)) +
    ggtitle("Density plot for magnitude")

#' ## Distribution for star temperature
#' ### Analysis
#' * Most stars are low temperature
# Density plot for temperature
stars %>%
    select(temp) %>%
    ggplot(aes(temp, y =..scaled..)) +
    geom_density(alpha=0.25, fill='lightblue') +
    ggtitle("Density plot for temperature")

#' ## Scatter plot of magnitude vs temperature
#' ### Analysis
#' * Temperature increases as luminosity increases i.e. magnitude decreases.
# Scatter plot 
p <- stars %>% ggplot(aes(temp, magnitude)) + 
    geom_point(color='blue', size=2.5, alpha = 0.2 ) +
    ggtitle("Scatter plot for magnitude vs temperature")

# Inverting the axis to correlate luminosity and temp
p <- p + scale_y_reverse() + 
    scale_x_log10() +
    scale_x_reverse()

#' ### How many white-dwarf (low luminous & high temp stars) are there? **4**
white_dwarfs <- stars %>% filter(temp>mean(temp) & magnitude>10)
print(count(white_dwarfs))

#' ### Mean temp of red giants (not white-dwarfs & not main sequence)? **5799**
red_giants <- stars %>% filter(magnitude < 0 & temp < 10000)
print(mean(red_giants$temp))

#' ### Add text label to identify each star.
# Adding labels
p <- p + geom_text(aes(label = star), check_overlap = TRUE)
p

#' ### Scatter plot with color as type of star
p <- stars %>% ggplot(aes(temp, magnitude, color = type)) +
    geom_point( size = 2.5) +
    scale_y_reverse() +
    scale_x_log10() +
    scale_x_reverse() +
    ggtitle("Scatter plot of magnitude & temp, based on type of star.")
p
#' ### Analysis
#' * `M` star type has the lowest temperature and luminosity.
#' * `O` star type has the highest temperature.
