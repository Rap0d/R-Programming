getwd()

jumsu <- read.csv('jumsunew.csv')
jumsu

# 과목별 최소 점수들을 벡터 변수 vec01에서 저장하세요.
vec01 <- c(min(jumsu$kor), min(jumsu$eng), min(jumsu$math))
vec01
# 과목별 (최대-최소)의 차이 값을 벡터 변수 vec02에서 저장하세요.
vec02 <- c(max(jumsu$kor), max(jumsu$eng), max(jumsu$math)) - c(min(jumsu$kor), min(jumsu$eng), min(jumsu$math))
vec02
# 국어(kor) 점수 중에서 짝수의 개수를 반환하는 함수 myfunctin을 만들어 주세요.
myfunction <- function(x) {
  res <- 0
  for(idx in x) {
    if(idx %% 2 == 0) {
      res <- res + 1
    }
  }
  return (res)
}
# 다음 문장을 이용하여 테스트를 수행하세요.
mykor <- jumsu$kor
result <- myfunction( mykor )
cat('count :', result)

###############################################

data <- c(20, 25, 30, 15, 60)

# 위의 벡터를 사용하여 짝수와 홀수의 갯수를 구해주는 함수 evenodd를 구현하세요.
evenodd <- function(x) {
  res <- c(0, 0)
  for(idx in x) {
    ifelse(idx %% 2 != 0, res[1] <- res[1] + 1, res[2] <- res[2] + 1)
  }
  return (res)
}
# 다음 문장을 이용하여 테스트를 수행하세요.
result <- evenodd( data )
cat('홀수 갯수 :', result[1], '\n') # 홀수 갯수 : 2
cat('짝수 갯수 :', result[2], '\n') # 짝수 갯수 : 3



# 여러 개의 벡터를 이용하여 생성이 가능하다.
no <- c(1, 2, 3)
name <- c('hong', 'lee', 'kim')
pay <- c(100, 200, 300)
emp01 <- data.frame(No=no, Name=name, Pay=pay)
emp01

m <- matrix(c(1, 'hong', 100, 2, 'kim', 200, 3, 'kang', 300), 3, byrow=T)
emp02 <- data.frame(m)
emp02
