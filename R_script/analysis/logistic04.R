
data <- read.table('housing.csv', header = F)
head(data)
str(data)
summary(data)

colnames(data) <- c('CRIM', 'ZIN', 'INDUS', 
                       'CHAS', 'NOX', 'RM', 
                       'AGE', 'DIS', 'RAD', 
                       'TAX', 'PTRAITO', 'B', 
                       'LSTAT', 'PRICE')
head(data)

# 학습용, 훈련용 데이터 분리
testing_row <- 10
training_row <- nrow(data) - testing_row
training <- data[1:training_row, ]
testing <- data[(training_row+1):nrow(data), ]
nrow(training) + nrow(testing)

# 모델 생성
model <- lm(formula <- PRICE ~ ., data = training)
model

# 선형 회귀 결과 값 추출
# 회귀 계수
coef(model)

# 적합 값
fitted(model)[1:7] 

# 잔차(residuals)
residuals(model)[1:7]

# 적합된 값과 잔차의 합은 실제 데이터의 합과 같다음
fitted(model)[1:7] + residuals(model)[1:7]
data[c(1:7), c('PRICE') ]

# 예측과 신뢰 구간
pred <- predict(model, newdata = testing, interval="confidence")
pred

# 모델 평가
summary(model)
# Call:
#   lm(formula = formula <- PRICE ~ ., data = training)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -15.700  -2.665  -0.525   1.869  25.962 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  35.405559   5.145942   6.880 1.86e-11 ***
#   CRIM         -0.105122   0.032942  -3.191 0.001510 ** 
#   ZIN           0.048787   0.013782   3.540 0.000439 ***
#   INDUS         0.021118   0.062052   0.340 0.733765    
# CHAS          2.609734   0.863178   3.023 0.002633 ** 
#   NOX         -17.035131   3.844504  -4.431 1.16e-05 ***
#   RM            3.801268   0.419774   9.056  < 2e-16 ***
#   AGE           0.002384   0.013268   0.180 0.857460    
# DIS          -1.509027   0.201412  -7.492 3.26e-13 ***
#   RAD           0.292501   0.067016   4.365 1.56e-05 ***
#   TAX          -0.012648   0.003778  -3.347 0.000880 ***
#   PTRAITO      -0.886459   0.134816  -6.575 1.26e-10 ***
#   B             0.009244   0.002691   3.436 0.000642 ***
#   LSTAT        -0.542078   0.051189 -10.590  < 2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 4.75 on 482 degrees of freedom
# Multiple R-squared:  0.7442,	Adjusted R-squared:  0.7373 
# F-statistic: 107.8 on 13 and 482 DF,  p-value: < 2.2e-16

# 예측 값과 정답
testing$PRICE
df <- data.frame(prediction=pred, real_Price=testing$PRICE)
df
# prediction.fit prediction.lwr prediction.upr real_Price
# 497       14.05287       12.91404       15.19170       19.7
# 498       19.25956       18.36332       20.15580       18.3
# 499       21.47470       20.48618       22.46323       21.2
# 500       18.61183       17.58406       19.63960       17.5
# 501       20.64221       19.74371       21.54071       16.8
# 502       23.98176       22.60630       25.35723       22.4
# 503       22.85730       21.48604       24.22856       20.6
# 504       28.18949       26.60877       29.77020       23.9
# 505       26.66713       25.16609       28.16817       22.0
# 506       22.84702       21.43355       24.26049       11.9
