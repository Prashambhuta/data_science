library(tidyverse)
# HISTOGRAM PLOTS
# histogram for male heights
p1 <- heights %>% filter(sex == 'Male')

# adding the aesthetic mappings
p1 <- p1 %>% ggplot(aes(x = height))

# plotting with histogram
p1 <- p1 + geom_histogram(binwidth = 1, fill = "lightgreen", col = "black")

# adding labels
p1 <- p1 + xlab("Male heights in in.") + ggtitle("Histogram")
print(p1)



# DENSITY PLOT
# adding density for the same
p2 <- heights %>% filter(sex == 'Male') %>% ggplot(aes(x = height))
p2 <- p2 + geom_density(fill = "lightyellow")
print(p2)




# QQ plots
# QQ plot require a 'sample' argument instead of 'x' argument
p3 <- heights %>% filter(sex == 'Male') %>% ggplot(aes(sample = height))
p3 <- p3 + geom_qq()
print(p3)

# Notice that gg plot requires 'dparams' argument for mean and sd.
# Redefining p3
p3 <- heights %>% filter(sex == 'Male') %>% ggplot(aes(sample = height))
params <- heights %>% filter(sex == 'Male') %>% summarise(mean = mean(height), sd = sd(height))

# Adding params to geom_qq plot
p3 <- p3 + geom_qq(dparams = params)

# Adding abline
p3 <- p3 +geom_abline()
print(p3)



# QUICK WAY TO CALCULATE 'MEAN' and 'SD"
p4 <- heights %>% filter(sex == 'Male') %>% ggplot(aes(sample = scale(height))) + geom_qq() + geom_abline()
print(p4)

# TO SHOW PLOTS NEXT TO EACH OTHER
library(gridExtra)

grid.arrange(p1,p2,p4, ncol=3)
                                                   
