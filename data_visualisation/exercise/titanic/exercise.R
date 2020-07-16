#' ---
#' title: "Titanic Survival Analysis"
#' author: "Prasham Bhuta"
#' date: "June 2, 2020"
#' ---

#' # Titanic exercise for R
library(titanic)
library(tidyverse)
options(digits = 3)

# defining the dataset
titanic <- titanic_train %>%
    select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
    mutate(Survived = factor(Survived), Pclass = factor(Pclass),
           Sex = factor(Sex))

summary(titanic)
str(titanic)

# density plot
titanic %>% 
    ggplot(aes(Age, y= ..count.., fill = Sex)) + geom_density(alpha = 0.25, 
                                                position = "stack") +
    guides(fill = guide_legend(reverse = TRUE)) + 
    scale_x_continuous(breaks = c(0,5,10,18,25,35,40,50,60,70,80))

# qqplot
params <- titanic %>% filter(!is.na(Age)) %>% summarize(mean = mean(Age),
                                                        sd = sd(Age))


titanic %>% filter(!is.na(Age)) %>%
    ggplot(aes(sample = Age)) + geom_qq(dparams = params) +geom_abline()

# Barplot
titanic %>% ggplot(aes(Survived, fill = Sex)) + geom_bar(position = 'dodge2')

# Density plot for survival by Age
titanic %>% filter(!is.na(Age)) %>% ggplot(aes(Age, y=..count.., 
                                               fill=Survived)) +
    geom_density(alpha = 0.2)

# Box plot for survival by Fare
titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    ggplot(aes(Survived, Fare, fill=Sex)) + geom_boxplot() +
    scale_y_continuous(trans = "log2", breaks = c(8,16,32,64,128,256,512)) +
    geom_jitter(alpha = 0.2) +
    ggtitle("Boxplot for survival based on Fare")

median_fare <- titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    group_by(Survived) %>% summarise(median = median(Fare))

print(median_fare)

# Barplot for survival by passenger Class
titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    ggplot(aes(Pclass, fill=Survived)) +
    geom_bar() +
    ggtitle("Barplot for Pclass filled with Survival")

# Barplot2 with 'position' argument
titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    ggplot(aes(Pclass, fill=Survived)) +
    geom_bar(position = position_fill()) +
    ggtitle("Barplot for Pclass filled with Survival with position")

# Barplot3 for pclass with Survival as fill
titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    ggplot(aes(Survived, fill=Pclass)) +
    geom_bar(position = position_fill()) +
    ggtitle("Barplot for Survival filled with Pclass & with position")

#' ### Analysis
#' * first class or second class people had more chance of survival.

#' Grid of density plot for age, filled by Survival, faceted by Sex & Pclass.
library(RColorBrewer)
titanic %>% filter(!is.na(Age) & !is.na(Fare)) %>%
    ggplot(aes(Age, y=..count.., fill=Survived)) +
    geom_density(alpha = 0.5) + 
    facet_grid(Pclass ~ Sex) +
    scale_fill_brewer(palette = "Accent")

#' ### Analysis
#' * Third class males are the highest group on Titanic.
#' * Almost no male of 2nd class survived, except for children.