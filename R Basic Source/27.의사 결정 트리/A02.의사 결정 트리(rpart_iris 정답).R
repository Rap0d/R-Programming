# 학습 데이터와 검증 데이터로 분리
set.seed(1234)
result = sample(1 : nrow(iris), nrow(iris) * 0.7) 
train = iris[result,] 
test = iris[-result,]  

# 분류 모델 생성 
library(rpart)
myformula = Species ~ Sepal.Length + Sepal.Width + Petal.Length +Petal.Width 
model <- rpart(myformula, data=train, control=rpart.control(minsplit = 2))
plot(model, compress=T, uniform=T, margin=0.1)
text(model, use.n=T, col='blue')

model

# 예측치 테스트
prop.prediction = predict(model, test)
prop.prediction  # setosa versicolor  virginica

# -- 시그모이드 함수 
prediction = ifelse(prop.prediction[, 1]>= 0.5, "setosa",
               ifelse(prop.prediction[, 2]>= 0.5, "versicolor", "virginica"))

head(prediction)

mytable <- table(prediction, test$Species)
mytable

bunmo <- sum(mytable)
bunmo
bunja <- mytable[1, 1] + mytable[2, 2] + mytable[3, 3]
bunja

# 정확도 구하기
accuracy <- bunja / bunmo 
round(100 * accuracy, 3)
