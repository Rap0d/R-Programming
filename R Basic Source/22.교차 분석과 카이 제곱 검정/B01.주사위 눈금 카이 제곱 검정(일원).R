# 60회 주사위를 던져서 나온 관측 도수가 다음과 같다고 가정하자.
# 이 주사위는 게임에 적합한 주사위 인가요? 

# 기대 도수 : 각 눈마다 10의 값(60번 던졌으므로)을 가진다.

# 귀무 가설 : '주사위의 각 눈금이 나올 확률은 차이가 없다.'

data <- c(4, 6, 17, 16, 8, 9)

answer <- c(10, 10, 10, 10, 10, 10)

chi_square <- sum((answer-data)**2 / answer)

chi_square

result <- chisq.test( data )

names(result)

# 유의 확률로 해석하기
result$p.value > 0.05

result$statistic # X-squared 검정 통계량
0.01439 > 0.05

result

if( result$p.value > 0.05){
  cat('귀무 가설 채택')
}else{
  cat('귀무 가설 기각')
}

# 따라서, 이 주사위는 '주사위의 각 눈금이 나올 확률은 차이가 있다.'
# 즉, 게임에 적합하지 않다.


# 검정 통계량으로 해석하기
X_squared <- result$statistic 
chi_table <- 11.071

if( X_squared < chi_table ){
  cat('귀무 가설 채택')
}else{
  cat('귀무 가설 기각')
}