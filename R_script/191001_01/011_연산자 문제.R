# 추가 문제
# seq를 이용하여 100, 97, 94, ... 1 만들기

ex1 <- seq(from=100, to=1, by=-3)

# seq와 sum을 이용하여 1+9+25+...9801의 합 
# 99의 제곱

ex2 <- sum(seq(from=1, to=99, by=2) ** 2)


# 1 - 1/2 + 1/3 - 1/4 ... - 1/100

ex3 <- sum(1 / seq(from=1, to=100, by=2)) - sum(1 / seq(from=2, to=100, by=2))

# 벡터 kk : 1, 4, 7, 10 --- 100
kk <- c(seq(from=1, to=100, by=3))
ex4 <- sum(c(seq(from=1, to=100, by=3)))

# 벡터 ii : 96, 91, ... 1
ii <- c(seq(from=96, to=1, by=-5))
ex5 <- sum(c(seq(from=96, to=1, by=-5)))

# 벡터 mm : 1, 2, 4, 5, 7, .... 100
ex6 <- sum(seq(from=1, to=100, by=3)) + sum(seq(from=2, to=100, by=3))

# abc.csv 파일을 읽어 들이세요.
exCsv <- read.csv('R_Script/191001_01/abc.csv')
# address 컬럼을 이용하여 막대 그래프를 그리세요.
plot(exCsv$address)
# gender 컬럼을 이용하여 파생 컬럼을 생성하세요.
gender2 <- factor(exCsv$gender, levels = c(1, 2), labels = c('Male', 'Female'))
# gender2 컬럼을 이용하여 막대 그래프를 그리세요.
plot(gender2)
# price의 평균은 얼마인가요?
mean(exCsv$price, na.rm = T)
