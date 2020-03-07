library(dslabs)
data("na_example")
sum(is.na(na_example))

no_nas <- ifelse(is.na(na_example) == TRUE, 0, na_example)
ind <- no_nas %in% "0"
print(ind)