library(dplyr)

# use arrange to sort entire table
# sort murders table based on population of the state
murders <- murders %>% arrange(desc(total*1000000/population))
print(murders %>% head())

# use 'top_n' to disply n numbers of rows.
# example, display first 15 data
p <- murders %>% arrange(desc(total)) %>% top_n(15)
print(p)
