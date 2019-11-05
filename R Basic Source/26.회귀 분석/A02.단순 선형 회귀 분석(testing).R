test <- read.csv('test01.csv', header=T)
# test <- read.csv('test02.csv', header=T)
# test <- read.csv('test03.csv', header=T)
head(test)

x <- test$x 
y <- test$y

# 단순 회귀 선형 모델을 다음과 같이 생성한다.
# lm 함수는 x를 이용하여 y를 예측한다.
model <- lm( y ~ x, test )
model

# 선형 회귀 분석 모델 시각화 : 산점도 그리기
plot(test, pch='*', lwd=2, cex=2.0 , col='blue', main='산점도') 

abline(coef(model), col='red', lwd=2) # 회귀선

# 모델의 적합값(fitted.values)과 잔차(residuals) 보기
names(model)

model$coefficients # 회귀 계수 확인

# 모델의 적합 값 보기
fitted.values(model)[1:2]

# 관측 값 : x, y 변수의 첫 번째 변량 확인
head(test, 1)

# 모델의 잔차는 residuals() 함수를 사용하여 구할 수 있다.
residuals(model)[1:2]

# 선형 회귀 분석 결과 보기
summary(model)
