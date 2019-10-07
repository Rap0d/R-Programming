i <- 0
while( i < 10 ){
  i <- i + 1
  print( i )
}

# 1부터 10까지의 합
total <- 0
i <- 1
while( i <= 10 ){
  total <- total + i
  i <- i + 1
}
cat('결과 :', total)

# break : 가장 가까운 반복문을 강제로 빠져 나가기  
# 1부터 10까지 출력하다가 5에서 빠져 나가기
x <- 0
while( x < 10 ){
  x <- x + 1 
  if( x == 5 ){
    break
  }
  print( x )
}

# next : 특정한 조건을 건너 띄고자 할 때 사용
# 타 프로그램의 continue 구문과 동일한 개념이다.
# 1부터 10까지의 정수 중에서 3의 배수가 아닌 수만 출력하기
x <- 0
while( x < 10 ){
  x <- x + 1
  if( x %% 3 == 0 ){
    next
  } 
  print( x )
}

# while, if, next를 이용하여 다음 문제를 풀어주세요.
# 1 + 2 + 4 + 5 + 7 + 8 + ...49 + 50
# 정답 : 867
x <- 0
total <- 0
while( x < 50 ){
  x <- x + 1
  if( x %% 3 == 0 ){
    next
  } 
  total <- total + x
}
print( total )


cnt <- c(1:3)
for( idx in cnt ){
  print( idx )
}

# 1부터 10까지의 합
cnt <- c(1:10)
total <- 0
for(idx in cnt){
  total <- total + idx
}
cat('결과 :', total)

# 3으로 나눌 때 나머지가 1인 항목들의 총합
# 1 + 4 + 7 + ... + 97 + 100
# 정답 : 1717
cnt <- seq(from=1, to=100, by=3)
cnt
total <- 0
for(idx in cnt){
  total <- total + idx
}
cat('결과 :', total)

# 1*1 + 6*6 + 11*11 + ... + 96*96
# 정답 : 63670
cnt <- seq(from=1, to=96, by=5)
cnt
total <- 0
for(idx in cnt){
  total <- total + idx**2
}
cat('결과 :', total)

transport <- c('버스', '지하철', '자동차')
for( vehicle in transport ){
  print( vehicle )
}

# 1부터 입력 받은 정수 까지 더하기

sc <- scan()

x <- seq(1, sc, 1)
res <- 0
for(idx in x) {
  res <- idx + res
}
res

# 1 ~ 100까지 홀수의 총합, 짝수의 총합 

x1 <- c(1:100)
res1 <- 0
res2 <- 0
for(idx in x1) {
  ifelse (idx %% 2 == 0, res2 <- idx + res2, res1 <- idx + res1)
}
res1
res2

x2 <- c(1:100)
res3 <- 0
res5 <- 0
for(idx in x2) {
  if (idx %% 3 == 0) {
    res3 <- idx + res3
  } else if (idx %% 5 == 0) {
    res5 <- idx + res5
  }
}
res3
res5

