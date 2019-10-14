getwd()
setwd('191014/')

## shape : 차원
### reshape : 분석하기 편하게 차원(형상)을 변환

install.packages('reshape2')
library(reshape2)

par(family = 'D2Coding')

exam <- read.csv('examtest.csv')
exam

str(exam)

# melt : names, gender만 제외하고 변수 / 값을 세로로 재배치 
meltdata01 <- melt(exam, id=c('names', 'gender'))
meltdata01

## measure opt : 변수 값중 eng, math만 가져오기 
meltdata02 <- melt(exam, id=c('names'), measure = c('english', 'math'))
meltdata02

data01 <- read.csv('data.csv', header = T)
data01

# dcast : 데이터에서 이름을 기준으로 날짜 컬럼별 '구매수량'을 sum 한 값을 펼쳐주는 함수
wideData <- dcast(data01, 이름 ~ 날짜, sum, value.var = '구매수량')
wideData
