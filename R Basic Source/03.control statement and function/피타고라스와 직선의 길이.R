# 점 a(x=1, y=4), b(x=1, y=1), c(x=5, y=1) 가 있다.
# 두 점의 길이는 다음과 같이 구한다.
# 루트((x1-x2)**2 + (y1-y2)**2)
# 
# 예를 들면, 선분 ab의 길이는 다음과 같다.
# 루트((x1-x2)**2 + (y1-y2)**2) = 루트((1-1)**2 + (4-1)**2) = 3.0이다.
# 이러한 기능을 수행하는 함수 get_length() 함수를 구현하시오.
# 이 함수를 이용하여 선분 ab와 bc의 길이를 각각 구하시오.
# 변수 abline : 선분 ab의 길이 
# 변수 bcline : 선분 bc의 길이 
# 
# 직각 삼각형에서 선분 ab와 bc를 두 변으로 하는 빗변의 길이를 구해주는 함수
# pythagoras 함수를 정의하고 빗변의 길이를 구하는 프로그램을 작성하시오. 
# 빗변 구하는 공식 : 루트((변1)**2 + (변2)**2)

a <- c(1, 4)
b <- c(1, 1)
c <- c(5, 1)

getLength <- function(x, y) {
  res <- 0.0
  res <- sqrt(((x[1] - y[1]) ** 2) + ((x[2]-y[2]) ** 2))
  return (res)
}

abLine <- getLength(a, b)
bcLine <- getLength(b, c)
acLine <- getLength(a, c)

pythagoras <- function(x, y) {
  res <- 0.0
  res <- sqrt(x^2 + y^2)
  return (res)
}

pythagoras(abLine, bcLine)
