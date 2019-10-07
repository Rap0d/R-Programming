getwd()
setwd('/Users/seungheonchang/Documents/Workspace/_3_rProgramming/R-Programming/R_data/')
abcCsv <- read.csv('Border_Crossing_Entry_Data.csv', header=T)
abcCsv
dim(abcCsv) # dimension
nrow(abcCsv) # 몇행인가요?
ncol(abcCsv) # 몇열인가요?

# 샘플링 방법
# nrow 함수는 전체 행의 갯수를 구해주는 함수이다.
# 1행 ~전체 행수에서 임의의 10%의 데이터를 무작위로 추출한다.
choice1 <- sample(0.1 * nrow(abcCsv))
choice1

abcCsv[choice1,]

# 3행 ~전체 행수에서 임의의 2개의 데이터를 무작위로 추출한다.
choice2 <- sample(3:nrow(abcCsv), 2)
choice2
# [1] 5 4

# 2행 ~ 6행 중에서 임의의 2개의 데이터를 무작위로 추출한다.
choice3 <- sample(c(2:6), 2)
choice3
# [1] 3 6

choice3 <- sample(c(2:6), 2)
choice3
# [1] 5 3

choice3 <- sample(c(2:6), 2)
choice3
# [1] 5 4

choice3 <- sample(c(2:6), 2)
choice3
# [1] 2 6

