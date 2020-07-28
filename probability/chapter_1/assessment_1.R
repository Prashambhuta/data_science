library(gtools)
library(tidyr)
# how many ways 3 medals can be distributed across 8 players.
runners <- seq(as.character(1:8))
medals <- c("Gold", "Silver", "Bronze")

dist <- expand.grid(runners=runners, medals=medals)
x <- permutations(8, 3)
paste(nrow(x))

paste(nrow(permutations(3,3)))

# probability of all 3 medals won by Jamaica
# 6 ways Jam get medals, out of 8P3.(336)

# Monte Carlo
runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", 
             "France", "South Africa")
set.seed(1)
B <- 10000
results <- replicate(B, {
    winners <- sample(runners, 3)
    (winners[1] %in% "Jamaica" & winners[2] %in% "Jamaica" & winners[3] %in% 
            "Jamaica")
})
mean(results)

# Meal Combinations
# 6 types of Entre
# 6C2 types of sides - 15
nrow(combinations(6,2))
# 2 drinks
6*15*2

# add 1 drink
6*15*3

# select 3 sides
nrow(combinations(6,3))*6*3

# write function that gives total number of options with changing 
# number of entree choices.
n <- seq(1:10)
entree_choices <- function(n){
    print(nrow(combinations(6, 2))*3*n)
}
entree_choices(n)

# do the same for side choices
n <- c(4:10)
side_choices <- function(n){
    print(nrow(combinations(n, 2))*3*6)
}
sapply(n, side_choices)

# Question 3 and 4.
head(esoph)
library(tidyverse)
# groups in study
nrow(esoph)

# no of cases
sum(esoph[,4])

# no of controls
sum(esoph$ncontrols)

# prob of cancer case in highest alcohol consumption
unique(esoph$alcgp)
esoph %>% filter(alcgp == "120+") %>% summarise(cases = sum(ncases), 
                                                total = sum(ncases) + 
                                                    sum(ncontrols),
                                                prob = cases/total)

# prob of cancer case in lowest alcohol consumption
low_consp = "0-39g/day"
esoph %>% filter(alcgp %in% low_consp) %>% 
    summarise(cases = sum(ncases), total = sum(ncases) + 
                  sum(ncontrols), prob = cases/total)

# given a cancer case what is the probability of smoking > 10g
totalcases <- sum(esoph$ncases)
cases <- esoph %>% filter(tobgp != "0-9g/day") %>% 
    summarise(cases = sum(ncases))
cases/totalcases

# given a control case what is the probability of smoking > 10g
total <- sum(esoph$ncontrols)
cases <- esoph %>% filter(tobgp != "0-9g/day") %>% 
    summarise(controls = sum(ncontrols))
cases/total

# Question  5 & 6
# probability of being in highest alcohol group, for cases
al_cases <- esoph %>% filter(alcgp == "120+") %>% 
    summarise(cases = sum(ncases))
cases/totalcases

# probability of being in highest tobacco group, 
unique(esoph$tobgp)
tb_cases <- esoph %>% filter(tobgp == "30+") %>% 
    summarise(cases = sum(ncases))
cases/totalcases

# what is the probability in being both highest alcohol & highest tobacco
cases <- esoph %>% filter(tobgp == "30+" & alcgp == "120+") %>%
    summarise(cases = sum(ncases))
cases/totalcases

# what is the probability in being highest alcohol or highest tobacco
cases <- esoph %>% filter(tobgp == "30+" | alcgp == "120+") %>%
    summarise(cases = sum(ncases))
cases/totalcases

# for controls, what is the probability of being in highest alcohol group
totalcontrols <- sum(esoph$ncontrols)
control <- esoph %>% filter(alcgp == "120+") %>% 
    summarise(controls = sum(ncontrols))
control/totalcontrols

# how many times it is more likely to be a case than a control in
# high consumption group.
cases_vs_controls <- esoph %>% filter(alcgp == "120+") %>%
    summarise(cases = sum(ncases), controls = sum(ncontrols), 
              ca_prob = cases/totalcases, 
              co_prob = controls/totalcontrols, 
              ratio = ca_prob/co_prob)
cases_vs_controls$ratio

# for control, what is the probability in being in the highest tobacco
# group
control <- esoph %>% filter(tobgp == "30+") %>% 
    summarise(control = sum(ncontrols))
control/totalcontrols

# for control, probability of being in the highest alcohol group and 
# highest tobacco group
control <- esoph %>% filter(tobgp =="30+" & alcgp == "120+") %>%
    summarise(control = sum(ncontrols))
control/totalcontrols

# for control, probability of being in the highest alcohol group OR 
# highest tobacco group
control <- esoph %>% filter(tobgp =="30+" | alcgp == "120+") %>%
    summarise(control = sum(ncontrols))
control/totalcontrols

# how many times cases are more likely to be in either highest 
# alcohol group or tobacco group
cases_vs_controls <- esoph %>% filter(tobgp == "30+" | 
                                          alcgp == "120+") %>%
    summarise(cases = sum(ncases), controls = sum(ncontrols), 
              ca_prob = cases/totalcases, 
              co_prob = control/totalcontrols, 
              ratio = ca_prob/co_prob)
cases_vs_controls$ratio