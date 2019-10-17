getwd()
setwd('R_data/')

data <- read.csv('mathfunc.csv')

kor <- data$kor
eng <- data$eng
math <- data$math

sqrt(kor)

ceiling(kor)

floor(kor)

round(kor)

kor

cumsum(kor)

which.max(kor)
which.min(kor)

sin(pi/2)
cos(pi/2)
tan(pi/4)

log(10)
log10(10)

abs(-3)

vec <- c(1:3, 3)
prod(vec)

i <- 5
factorial(i)

# pmax : 1개 이상의 벡터에서 index 비교 

pmax(kor)
pmax(kor, eng)
pmax(kor, eng, math)
pmin(kor, eng, math)

c1 <- c(1, 2)
c2 <- c(4, 1)
matA <- cbind(c1, c2)
matA


nrow(matA)
ncol(matA)

apply(matA, 1, sum)

transA <- t(matA)
transA

diag(3)

solA <- solve(matA)
resA <- solA %*% matA
resA

data <- c(1:5)
findD <- c(2, 6, 3, 1)
res <- sum(findD %in% data)
res
