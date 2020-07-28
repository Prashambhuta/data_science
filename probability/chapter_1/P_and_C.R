suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", 'two', 'three', 'four', 'five', 'six', 'seven',
             'eight', 'nine', 'ten', 'jack', 'queen', 'king')

deck <- expand.grid(suits=suits, numbers=numbers)
deck <- paste(deck$numbers, deck$suits)

# Checking probability of king
kings <- paste("king", suits)
mean(deck %in% kings)

# probability of second being a king, given first was a king.
library(gtools)
permutations(5, 2) # ways to choose 2 numbers in order from 1:5
all_phone_numbers <- permutations(10, 7, v = 0:9)
n <- nrow(all_phone_numbers)
index <- sample(n, 5)
all_phone_numbers[index,] # randomly generate 5 phone numbers

# probability of second king after 1st king
hands <- permutations(52, 2, v=deck)
first_card <- hands[,1]
second_card <- hands[,2]
sum(first_card %in% kings & second_card %in% kings) / sum(first_card %in% kings)
# Pr(B | A) = Pr(A and B)/Pr(A)

# Probability of getting a natural 21 in BlackJack.
aces <- paste("Ace", suits)
face_card <- c("king", "queen", "jack", "ten")
face_card <- expand.grid(numbers=face_card, suits=suits)
face_card <- paste(face_card$numbers, face_card$suits)
hands <- combinations(52, 2, v=deck)
mean(hands[,1] %in% aces & hands[,2] %in% face_card) # 0.048 

# Using monte-carlo simulation
N <- 100000
results <- replicate(N, {
    hand <- sample(deck, 2)
    (hand[1] %in% aces & hand[2] %in% face_card) |
        (hand[1] %in% face_card & hand[2] %in% aces)
})
mean(results)

# Birthday problem
N <- 100000
results <- replicate(N, {
    bday <- sample(1:365, 50, replace = TRUE)
    any(duplicated(bday))
})
mean(results)