# Question1 SAT questions
# 1a prob of guessing one correctly
1/5

# E for one question
1*1/5 - 0.25*4/5

# E for all 44 questions
n <- 44
p_correct <- 0.2
p_incorrect <- 0.8
correct_option <- 1
incorrect_option<- -0.25
((correct_option*p_correct) + (incorrect_option*p_incorrect))*n

# std error on all 44 questions
sqrt(n) * abs(1 - (-0.25)) * sqrt(p_correct*p_incorrect)

# using clt to get prob of student scoring greater than 8
1 - pnorm(8, 0, 3.3166)

# Monte carlo simulation for 10000 students
set.seed(21, sample.kind = "Rounding")
B <- 10000
scores <- replicate(B,{
    score <- sample(c(1,-0.25), 44, replace=TRUE, 
                    prob=c(p_correct, p_incorrect))
    sum(score)
})
scores
mean(scores>=8)

# Section 2
# Q1. no negative marks, and no of options = 4, get E
n <- 44
p_correct <- 0.25
p_incorrect <- 0.75
correct_option <- 1
incorrect_option<- 0
((correct_option*p_correct) + (incorrect_option*p_incorrect))*n

# adjust the probability from 0.25 to 0.95 and see at which p the scoring over 35 exceeds 80%

p <- seq(0.25, 0.95, 0.05)
outcomes <- function(p) {
    expected_value <- (correct_option*p + incorrect_option*(1-p))*n
    standard_error <- sqrt(n)*abs(correct_option - incorrect_option)*
        sqrt(p*(1-p))
    # likelihood of pnorm for 35 is >=0.8
    1 - pnorm(35, expected_value, standard_error) > 0.8
}
paste(p, sapply(p, outcomes))


# Q3: Betting on Roulette
winning_options <- 5
loss_options <- 33
win_amount <- 6
loss_amount <- -1
n <- 500

# Q1: Expected value of 1 bet
win_prob <- 5/38
loss_prob <- (1-win_prob)
#calculate E
win_amount*win_prob + loss_amount*loss_prob 

# Q2: calculate standard error
abs(win_amount - (loss_amount))*sqrt(win_prob*loss_prob)

# Q3: Expected value of average payout for 500 bets
500*(win_amount*win_prob + loss_amount*loss_prob)/500

# Q4: standard error for 500 bets
(sqrt(500)*abs(win_amount - (loss_amount))*sqrt(win_prob*loss_prob))/500

# Q5: sum of 500 bets
500*(win_amount*win_prob + loss_amount*loss_prob)

# Q6: Standard error of sum of 500 bets
(sqrt(500)*abs(win_amount - (loss_amount))*sqrt(win_prob*loss_prob))

# Q7: prob of losing money in 500 bets
pnorm(0,500*(win_amount*win_prob + loss_amount*loss_prob)/500, (sqrt(500)*abs(win_amount - (loss_amount))*sqrt(win_prob*loss_prob))/500 )
