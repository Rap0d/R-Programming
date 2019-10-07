## 입력되는 인수가 5이상일때는 1을 출력, 5 미만이면 0을 출력

myf1 <- function(x) {
  res <- 0
  ifelse(x >= 5, res <- 1, res <- 0)
  return (res)
}
myf1(5)

## 입력되는 인수가 양수일대는 1 출력, 음수는 0 출력

myf2 <- function(x) {
  res <- 0
  ifelse(x > 0, res <- 1, res <- 0)
  return (res)
}
myf2(5)

## 두 숫자 중에 큰 수 출력

myf3 <- function(x, y) {
  res <- 0
  ifelse(x > y, res <- x, res <- y)
  return (res)
}
myf3(5, 6)

## 사용자가 y, Y를 입력하면 화면에 Yes 출력, 그 외에는 No 출력

myf5 <- function(x) {
  res <- 'Yes'
  ifelse(x == 'y' | x == 'Y', res <- 'Yes', res <- 'No')
  return (res)
}

myf5('y')
myf5('Y')
myf5('a')
