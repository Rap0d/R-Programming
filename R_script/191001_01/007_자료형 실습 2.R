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


