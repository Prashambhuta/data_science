library(dslabs)
data(heights)
length(unique(heights$height))

tab <- table((heights$height))

# calculate the total number of entries with 1.
sum(ifelse(tab == 1, 1, 0))

# make a table of category proportions
prop.table(table(heights$sex))