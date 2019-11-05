
product <- read.csv('../26.회귀 분석/product.csv', header=T)
head(product)

newproduct <- product[c('appropriacy', 'satisfaction')]
colnames(newproduct) <- c('xdata', 'ydata') 

# 단순 회귀 선형 모델을 다음과 같이 생성한다.
# lm 함수는 xdata를 이용하여 ydata를 예측한다.
model <- lm( ydata ~ xdata, newproduct )
model

# 선형 회귀 분석 모델 시각화 : 산점도 그리기
par(family = 'AppleGothic')
plot(newproduct, pch='*', lwd=2, cex=2.0 , col='blue', xlab='제품의 적절성', 
	ylab='제품의 만족도', main='적절성과 만족도에 대한 산점도') # 산점도 그래프

# 회귀 계수를 이용하여 회귀 선을 그려 주는 데, 가장 최적화된 직선을 그려 준다.
abline(coef(model), col='red', lwd=2) # 회귀선

# 모델의 적합값과 잔차 보기
names(model)
#  [1] "coefficients"  "residuals"     "effects"       "rank"         
#  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#  [9] "xlevels"       "call"          "terms"         "model" 

model$coefficients # 회귀 계수 확인

# fitted.values : 모델이 예측한 적합 값을 제공해준다.
# residuals : 모델의 잔차를 말한다.

# 모델의 적합 값 보기
fitted.values(model)[1:2]

# 관측 값 : xdata, ydata 변수의 첫 번째 변량 확인
head(newproduct, 1)

# 잔차 계산
3 - 3.735963 
# [1] -0.735963

# 모델의 잔차는 residuals() 함수를 사용하여 구할 수 있다.
residuals(model)[1:2]

# 관측 값 = 잔차 + 적합 값
-0.735963 + 3.735963 

# 선형 회귀 분석 결과 보기
summary(model)
# Call:
# lm(formula = ydata ~ xdata, data = newproduct)
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -1.99669 -0.25741  0.00331  0.26404  1.26404 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.77886    0.12416   6.273 1.45e-09 ***
# xdata            0.73928    0.03823  19.340  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5329 on 262 degrees of freedom
# Multiple R-squared:  0.5881,    Adjusted R-squared:  0.5865 
# F-statistic:   374 on 1 and 262 DF,  p-value: < 2.2e-16

# R-squared:  0.5881의 값이 독립 변수와 종속 변수와의 상관 관계를 의미한다.
# 1에 가까울수록 변수의 모델이 잘 되었다는 의미이다.
# 유의 확률이 0.05이상인 경우에는 회귀선이 모델에 부적합하다는 의미이다.
# 예시에서는 p-value(< 2.2e-16)이므로 적합하다고 볼 수 있다.

