beads <- rep(c('red', 'blue'), times=c(2,3))
event <- sample(beads, 1)
stimulation <- replicate(10000, sample(beads, 1))
tab <- table(stimulation)
print(tab)

# without the replicate function, using 'replacement = True'.

event <- sample(beads, 10000, replace = TRUE)
tab <- table(event)
print(tab)