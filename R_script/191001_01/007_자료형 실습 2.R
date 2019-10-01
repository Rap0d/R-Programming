# 데이터형 실습 

name <- 'Hong'
age <- 30
hasCar <- TRUE
name
age
hasCar
doublevar <- 10.12

# NA : Not Available
sum(10, 20, 30)
sum(10, 20, 30, NA)
var <- NA

# na.rm = T : NA를 Remove = True, NA를 배재하고 연산
sum(10, 20, 30, NA, na.rm = T)

mean(10, 20)
mean(10, 20, NA, na.rm = T)

# 체크 함수 is 
is.character(name)
is.character(age)
is.numeric(age)
is.logical(hasCar)
is.na(var)
is.numeric(doublevar)

somedata <- c(10, 20, "30")
somedata

# 문자가 들어가서 실패 
result <- somedata * 3

# as -> 형변환 
result <- as.numeric(somedata) * 3
result

# 현재 사용중인 변수 리스트 보기
ls()

data <- c(1, 2)

# mode : 자료의 타입
mode(data)

# class : 자료의 구조
class(data)

# 변수.멤버 형태
goods.code <- 101
goods.name <- '냉장고'
goods.price <- 123000

ls()

data <- c(1, 2)

# args : 해당 함수의 매개 변수 목록을 보고자 할 때 사용
args(mean)
args(sum)

# example() : 함수의 예제 보기
example(mean)
example(as)
example(cat)
example(getwd)
example(setwd)

# getwd(), setwd() 
getwd()
setwd("/Users/seungheonchang/Documents/Workspace/_3_rProgramming/R-Programming")
