product = read.csv("product.csv", header=TRUE) 
str(product)
head(product)

colnames(product) <- c('xdata1', 'xdata2', 'ydata')
colnames(product)
head(product)

model = lm(formula=ydata ~ xdata1 + xdata2, data=product) 

model  # 절편과 기울기 확인

# 다중 공선성 문제 확인
install.packages('car')
library(car)

# 분산 팽창 요인의 값이 10 이상인 경우에는 다중 공선성의 문제를 의심해볼 필요가 있다.
vif_result <- vif(model)
class(vif_result)

# 10이 넘는 값이 있으면, 상관 계수를 이용하여 강한 상관 관계가 있으면 변수들을 확인한다.
vif_result
vif_result >= 10.0

summary(model)
# Call:
# lm(formula = ydata ~ xdata1 + xdata2, data = product)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -2.01076 -0.22961 -0.01076  0.20809  1.20809 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.66731    0.13094   5.096 6.65e-07 ***
# xdata1           0.09593    0.03871   2.478   0.0138 *  
# xdata2           0.68522    0.04369  15.684  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5278 on 261 degrees of freedom
# Multiple R-squared:  0.5975,    Adjusted R-squared:  0.5945 
# F-statistic: 193.8 on 2 and 261 product,  p-value: < 2.2e-16