# 최소 자승법.xlsx 파일 참조 요망
test <- read.csv('linear_reg.csv', header=T)

head(test)

x <- test$x 
y <- test$y

mean_x <- mean(x)
mean_y <- mean(y)

bunja <- sum((x-mean_x)*(y-mean_y))
bunmo <- sum((x-mean_x)**2)

a <- bunja / bunmo 
b <- mean_y - a * mean_x
a; b;

# 선형 회귀 분석 모델 시각화 : 산점도 그리기
plot(test, pch='*', lwd=2, cex=2.0 , col='blue', main='최소 자승법', xlab='온도', ylab='에어콘 판매 대수') 

# abline 함수는 a와 b가 반대이다.
abline(a=b, b=a, col='red', lwd=2) # 회귀선

model <- lm( y ~ x, test )
model

# 모델의 적합값(fitted.values)과 잔차(residuals) 보기
names(model)

model$fitted.values
model$df.residual

model$coefficients # 회귀 계수 확인

# 모델의 적합 값 보기
fitted.values(model)[1:2]

# 관측 값 : x, y 변수의 첫 번째 변량 확인
head(test, 1)

# 모델의 잔차는 residuals() 함수를 사용하여 구할 수 있다.
residuals(model)[1:2]

# 선형 회귀 분석 결과 보기
summary(model)


# 부모의 IQ 가 117 일때 자녀의 IQ는 얼마가 될것으로 예상하는 가?
x <- c(110, 120, 130, 140, 150)

y <- c(100, 105, 128, 115, 142)

