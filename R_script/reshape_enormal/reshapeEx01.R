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

write.csv(wideData, 'wide.csv', row.names = F)

newWide <- read.csv('wide.csv')
newWide

colnames(newWide) <- c('name', '1-1', '1-2', '1-3')

long <- melt(newWide, id='name')
long

colnames(long) <- c('name', 'date', 'qty')
long

# students.csv file을 읽어 melt하기

std <- read.csv('students.csv', header = T)
std

stdWide <- melt(std, id=c(1:2))
stdWide

fruits01 <- read.csv('fruits_10.csv', header = T)
fruits01

colnames(fruits01)

# year만 남기고 나머지를 아래로 길게
fruitMelt <- melt(fruits01, id=c('year'))
fruitMelt

# year과 name을 남기고 나머지를 아래로 길게
fruitMelt2 <- melt(fruits01, id=c('year', 'name'))
fruitMelt2

# variable의 col name을 지정 
mtest <- melt(fruits01, id=c(1:2), variable.name = 'va_n', value.name = 'va_n2')
mtest

dcast(mtest, year + name ~ va_n)

dcast(mtest, year ~ va_n, sum)

# subset 함수를 사용하기 위한 plyr 패키지 로드
library('plyr')
# 전체 데이터 중 name이 apple인 리스트 필터링 
dcast(mtest, year ~ va_n, sum, subset=.(name == 'apple'))

# 논리 연산자 사용가능
dcast(mtest, year ~ va_n, sum, subset=.(name == 'apple' | name == 'banana'))

payData <- read.csv('pay_data.csv', header = T)
payData
# user_id product_type pay_method price
# 1   김철수         사과       현금  1000
# 2   김철수         사과   직불카드  2000
# 3   김철수         사과       현금  3000
# 4   김철수         사과   직불카드  4000
# 5   김철수         사과   신용카드  6000
# ~~~~~~~

# 고객별 상품 유형에 따른 구매 금액의 총합 
res <- dcast(payData, user_id ~ product_type, sum, value.var = "price", na.rm = T)
res
# user_id  사과  포도
# 1  김철수 21000 19000
# 2  박영희 23000 20000

# 행 : 고객 유형, 상품 유형 / 열 : 지불 방법
res2 <- dcast(payData, user_id + product_type ~ pay_method, sum, value.var = 'price', na.rm = T)
res2
# user_id product_type 신용카드 직불카드 현금
# 1  김철수         사과    11000     6000 4000
# 2  김철수         포도     3000     9000 7000
# 3  박영희         사과    10000     6000 7000
# 4  박영희         포도     6000     8000 6000

# 고객 유형별 지불 방법에 따른 구매 금액의 총합 
res3 <- dcast(payData, user_id ~ pay_method, sum, value.var = 'price', na.rm = T)
res3
# user_id 신용카드 직불카드  현금
# 1  김철수    14000    15000 11000
# 2  박영희    16000    14000 13000

# 행 : 고객 유형, 상품 유형 / 열 : 지불 방법
res4 <- dcast(payData, user_id ~ product_type + pay_method, sum, value.var = 'price', na.rm = T)
res4
# user_id 사과_신용카드 사과_직불카드 사과_현금 포도_신용카드 포도_직불카드 포도_현금
# 1  김철수         11000          6000      4000          3000          9000      7000
# 2  박영희         10000          6000      7000          6000          8000      6000