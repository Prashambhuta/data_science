# Trying to replicate monty hall problem, with switching and not switching the
# doors.

# Without switching
B <- 10000
stick <- replicate(B, {
    doors <- as.character(1:3)
    prize <- sample(c("car", "goat", "goat"))
    prize_door <- doors[prize == 'car']
    my_pick <- sample(doors, 1)
    show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)
    stick <- my_pick
    stick == prize_door
})
mean(stick)

# With switching
switch <- replicate(B, {
    doors <- as.character(1:3)
    prize <- sample(c("car", "goat", "goat"))
    prize_door <- doors[prize == 'car']
    my_pick <- sample(doors, 1)
    show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)
    switch <- sample(doors[!doors %in% c(my_pick, show)], 1)
    switch == prize_door
})
mean(switch)