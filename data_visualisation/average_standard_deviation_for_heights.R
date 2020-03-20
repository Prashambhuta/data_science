library(dslabs)
data(heights)

ind <- heights$sex == 'Male'    # index of males
males <- heights$height[ind]    # new table of males

average <- mean(males)  # average height of males
sd <- sd(males) # standard deviation between males
standard_units <- scale(males)  # deriving standard_units using scale function
std_index <- abs(standard_units) < 2    # generating index of users with SD < 2
no_of_users <- sum(std_index)   # total number of users with SD < 2 
