# 주석은 #으로 시작한다. 
# <- 는 대입 연산자 
# 문자열은 외따옴표나 쌍따옴표로 
name <- '홍길동'
age <- 35

# 변수 이름을 입력하면 출력된다. 
name
age

int <- 20
string <- "김철수"
boolean <- T # TRUE
sum(10, 20, 30, NA) # NA : Not Available

# T는 True를 의미한다. 
sum(10, 20, 30, NA, na.rm = T)

ls() # 현재 사용중인 변수 목록 보기 

x <- 100

is.character(string)
is.numeric(int)
is.logical(boolean)
is.na(x)

y <- '100'
result <- 3 * y # ERROR
newy <- as.numeric(y)
result <- 3 * newy
result

# mode와 class 함수
mode(result)
class(result)

