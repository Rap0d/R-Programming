##################################################################
# 단계 01 : 학습용과 훈련용 데이터 분리하기
##################################################################
housing = read.table("housing.csv", header=FALSE)
colnames(housing) <- c('CRIM', 'ZIN', 'INDUS', 'CHAS', 'NOX', 
	'RM', 'AGE', 'DIS', 'RAD', 'TAX', 'PTRAITO', 'B', 'LSTAT', 'PRICE')
str(housing)
dim(housing)
head(housing)

testing_row <- 10
train_row <- nrow(housing) - testing_row
training <- housing[1:train_row, ]
testing <- housing[(train_row+1):nrow(housing), ]
nrow(training) + nrow(testing)
##################################################################
# 단계 02 : 모델 생성하기
##################################################################
help(lm)
myformula <- PRICE ~ .
mymodel <- lm(formula <- myformula, data = training)
mymodel
##################################################################
# 단계 02 : 선형 회귀의 결과 값 추출해보기
##################################################################
coef( mymodel ) # 회귀 계수 구하기

fitted(mymodel)[1:7] # 적합 값 구하기

# 잔차(residuals)
residuals(mymodel)[1:7]

# 적합된 값과 잔차의 합은 실제 데이터의 합과 같다.
fitted(mymodel)[1:7] + residuals(mymodel)[1:7]
housing[c(1:7), c('PRICE') ]
##################################################################
# 단계 03 : 예측과 신뢰 구간
##################################################################
# help(predict)
pred <- predict(mymodel, newdata=testing)
pred

predict(mymodel, newdata = testing, interval="confidence")

predict(mymodel, newdata = testing, interval="prediction")
##################################################################
# 단계 04 : 모델에 대한 평가하기
##################################################################
summary( mymodel )

# 단계 05 : 예측 값과 정답을 한 번에 보여 주기
testing$PRICE
df <- data.frame(prediction=pred, real_Price=testing$PRICE)
df
##################################################################