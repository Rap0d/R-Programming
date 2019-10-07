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
