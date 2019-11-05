# 다중 공선성 문제 해결
# install.packages('car') 
library(car)
data(iris)

# 학습 데이터(training), 검증 데이터(testing)를 7 : 3 비율로 셈플링한다.
set.seed(1234)
idx = sample(1:nrow(iris), 0.7*nrow(iris))
training = iris[idx, ] # 훈련용 데이터
testing = iris[-idx, ] # 점검용 데이터

dim(training) # 105   5 (70%)
dim(testing)  # 45  5 (30%)

model <- lm(formula=Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width , data=training)
model

vif(model)
#  Sepal.Width Petal.Length  Petal.Width 
#     1.218701    14.422474    13.654679 

# vif의 값이 10이상이면 다중 공선성 문제 의심
vif(model) > 10
#  Sepal.Width Petal.Length  Petal.Width 
#        FALSE         TRUE         TRUE 

# Petal.Length 변수와 Petal.Width 변수는 강한 상관 관계로 인하여 다중 공선성 문제가 의심이 된다.

# 다중 공선성 문제가 의심이 되는 경우 상관 계수를 구하여 변수간의 강한 
# 상관 관계를 명확히 분석하는 것이 좋다.
cor(iris[, -5]) # Species(종) 제외

# Petal.Length 변수와 Petal.Width 변수의 상관 계수는 0.9628654이다.
# 즉, 매우 강한 상관 관계를 이루고 있다.
# 따라서 Petal.Width 변수를 제외하고 다시 다음과 같이 테스트를 수행해본다.
model <- lm(formula=Sepal.Length ~ Sepal.Width + Petal.Length, data=training)
model
vif(model)

summary(model)
# 결과 설명
# 꽃받침 너비(Sepal.Width)의 p-value(7.14e-11)는 유의 수준하에서 영향을 미치는 것으로 분석이 된다.
# 꽃잎 길이(Petal.Length)의 p-value(< 2e-16)는 유의 수준하에서 영향을 미치는 것으로 분석이 된다.

# 회귀 방정식 도출하기
model

# 테스팅 데이터를 사용한 예측치 생성
pred <- predict(model, testing)
pred[1:5]

# 선형 회귀 모델의 평가는 상관 계수를 이용하여 풀면 된다.
cor(pred, testing$Sepal.Length) # [1] 0.9123762
