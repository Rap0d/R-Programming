testdata1 <- read.csv('시험 점수와 공부 시간1.csv', header=TRUE)
testdata1

testdata2 <- read.csv('시험 점수와 공부 시간2.csv', header=TRUE)
testdata2

# cor() : 상관 계수를 구해준다.
result1 <- cor(testdata1)
result1
mode( result1 ) # "numeric"
class( result1 ) # "matrix"

result2 <- cor(testdata2)
result2

# 소수점 2째 자리까지 반올림
round(result1, digits = 2)	
#          학교성적 공부시간
# 학교성적     1.00     0.85
# 공부시간     0.85     1.00

# 상관 계수가 0.85이라는 것은 공부를 많이 할 수록 학교 성적이 올라간다는 의미이다.

# Correlation Matrix(상관 행렬 그래프)
# install.packages('corrplot')
library( corrplot )

# 크기가 색상을 유심히 살펴 보라
corrplot(result1)

corrplot(result1, addCoef.col = 'red')

corrplot(result1, method='ellipse', addCoef.col = 'red')

corrplot(result1, method='ellipse', addCoef.col = 'yellow', type='upper')