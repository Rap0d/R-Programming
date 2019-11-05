library("ggplot2")

# cars : 기본 데이터
cars
str(cars)
# 'data.frame':	50 obs. of  2 variables:
# $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
# $ dist : num  2 10 4 22 16 10 18 26 34 17 ...

plot(cars$speed, cars$dist, main = 'scatter plot')

model <- lm(dist ~ speed, cars)
model

# dist = 3.932 * speed - 17.579
abline(coef(model), col = 'red', lwd = 2)

coef(model)
fitted.values(model)[1:4]
residuals(model)[1:4]

cars$dist[1:4]

# 잔차 제곱의 총합
deviance(model)

# 학습된 모델을 이용하여 예측하기
testData <- data.frame(speed = 3)
testData

predict(model, testData)
# > # dist = 3.932 * speed - 17.579
# -5.781869 

# confidence : 오차 범위가 평균값(fit)을 기준
# prediction : 잔차가 정규분포를 따르고 변화(variance)가 일정할때 사용
predict(model, testData, interval = 'confidence')
predict(model, testData, interval = 'prediction')
        # fit       lwr      upr
# 1 -5.781869 -17.02659 5.462853
# 1 -5.781869 -38.68565 27.12192

# speed의 최솟값과 최댓값을 확인
summary(model)
# 위의 최소, 최대의 범위를 이용하여 신뢰구간 확인
newData <- data.frame(speed = seq(4.0, 25.0, 0.2))
predict(model, newdata = newData, interval = 'confidence')

## 그래프
data("cars", package = "datasets")
model <- lm(dist ~ speed, data = cars)
# 1. Add predictions 
pred.int <- predict(model, interval = "prediction")
mydata <- cbind(cars, pred.int)
# 2. Regression line + confidence intervals
p <- ggplot(mydata, aes(speed, dist)) +
  geom_point() +
  stat_smooth(method = lm)
# 3. Add prediction intervals
p + geom_line(aes(y = lwr), color = "red", linetype = "dashed")+
  geom_line(aes(y = upr), color = "red", linetype = "dashed")
