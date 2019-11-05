##################################################################
# 모델 생성하기
##################################################################
# 주행 속도(독립)와 제동 거리(종속)에 대한 간단히 다음 모델을 생각해보자
class(cars) # "data.frame"
head(cars)

plot(cars$speed, cars$dist, main='cars 데이터의 산점도와 회귀 곡선') # 산점도 그리기

model <- lm(dist ~ speed, cars)

model
# Call:
# lm(formula = dist ~ speed, data = cars)
# 
# Coefficients:
# (Intercept)        speed  
#     -17.579        3.932  
# 부연 설명
# 수행 결과 dist와 speed 간의 관계는 다음과 같이 구해진다.
# dist = -17.579 + 3.932 * speed + ε
##################################################################
# 회귀 직선의 시각화
##################################################################
abline(coef(model), col='red', lwd=2) # 선형 회귀의 절편과 기울기
# cars 데이터의 산점도와 회귀 곡선.png
##################################################################
# 단계 02 : 선형 회귀의 결과 값 추출해보기
##################################################################
# 선형 회귀 함수 lm()으로 구한 세부 내용을 살펴 보기 위하여 
# 다음과 같은 함수들을 살펴 보도록 한다.
coef( model ) # 회귀 계수 구하기
# (Intercept)       speed 
# -17.579095    3.932409 

fitted(model)[1:4] # 적합 값 구하기

# 잔차(residuals) : 모델로부터의 구한 예측 값과 실제 값 사이의 차이
residuals(model)[1:4]
 
# 적합된 값과 잔차의 합은 실제 데이터의 합과 같다.
fitted(model)[1:4] + residuals(model)[1:4]

cars$dist[1:4]

help(deviance)
# 선형 회귀에서는 오차의 제곱의 합이 최소가 되도록 회귀 계수를 정한다.
deviance( model ) # 잔차 제곱 합(deviance) 구하기
##################################################################
# 예측과 신뢰 구간
##################################################################
# help(predict)
# speed가 3일때 dist의 값을 예측해보자.
# 이전 모델을 이용하여 새로운 데이터에 대하여 예측한다.
testdata <- data.frame(speed=3)
testdata
predict(model, newdata=testdata)
# -5.781869

# 그 값을 이용하여 직접 산술 연산
-17.579095 + 3.932409 * 3 

# 주행 속도가 3인 경우의 예측을 수행했더니 제동 거리가 -5.781869으로 예측이 되었다.
# 그리고, 이 값은 선형 회귀 모델의 회귀 계수를 직접 계산한 값과 일치했다.

# interval="confidence" 옵션을 사용하게 되면 제동 거리(dist)에 신뢰 구간의 상하한값을 구할수 있다.
predict(model, newdata=testdata, interval = 'confidence')

# 특정 속도를 가진 차량 1대에 대한 제동 거리를 생각할 때 오차를 무시할 수 없다.
# prediction 옵션을 추가한다.
# predict(model, newdata=data.frame(speed=3), interval="prediction")
predict(model, newdata=data.frame(speed=3))
#        fit       lwr      upr
# 1 -5.781869 -38.68565 27.12192
##################################################################
# 모델에 대한 평가하기
##################################################################
# 선형 회귀 모델을 평가하는 다양한 기준을 살펴 본다.
summary( model ) 

# R-squared(결정 계수) : 데이터의 분산을 얼마나 설명하는 지를 알려 준다.
# Adjusted R-squared(수정 결정 계수) : 데이터의 분산을 얼마나 설명하는 지를 알려 준다.
# F-statistic(F 통계량) : 모델이 통계적으로 어떤 의미가 있는 지를 알려 주는 정보

# Residual standard error: 15.38 on 48 degrees of freedom
# Multiple R-squared:  0.6511,    Adjusted R-squared:  0.6438 
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

# 그래프에 추정 값의 신뢰 구간을 포함하기
# speed의 최소값과 최대 값을 찾는다.
summary(cars$speed )
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 4.0    12.0    15.0    15.4    19.0    25.0

# 이 값의 범위에 대하여 신뢰 구간을 구한다.
predict(model, newdata = data.frame(speed=seq(4.0, 25.0, 0.2)), interval = 'confidence')

test <- seq(min(cars$speed), max(cars$speed), 0.1)
test

myspeed <- data.frame(speed=test)
myspeed

ys <- predict(model, newdata = myspeed, interval='confidence')
class(ys) # matrix

# 회귀 방정식은 직선으로 , 신뢰 구간은 점선으로 그리기
matplot(myspeed, ys, type='n')

matlines(myspeed, ys, lty=c(1, 2, 2), col=c('red','blue', 'blue') )
# 회귀 직선과 신뢰 구간.png