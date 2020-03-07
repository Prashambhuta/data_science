library(dslabs)
library(dplyr)
data(murders)

murders = mutate(murders, rate = (total/population)*100000)
population_in_millions <- murders$population / 1000000
total_gun_murders <- murders$total
plot(log(population_in_millions), total_gun_murders)