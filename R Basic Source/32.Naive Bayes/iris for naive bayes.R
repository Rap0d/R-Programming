#나이브 베이즈즈 모델 학습시키기
# install.packages('klaR')
# library(klaR)

# install.packages('e1071')
library(e1071) 

set.seed(1234)
idx <- sample(1:nrow(iris), 0.7*nrow(iris))
# idx <- sample(1:nrow(iris), 100)
training <- iris[idx, ]
testing <- iris[-idx, ]

model <- naiveBayes(formula = Species ~ ., data = iris)

# 학습된 나이브 베이즈 모델로 예측
pred <- predict(model, testing)
attributes(pred)
head(pred)

# 정분류율 및 오분류율 계산
# 정오분류표(confusion matrix) 작성
mytable <- table(pred, testing$Species)
mytable            

#정분류율
accuracy <- sum(mytable[row(mytable) == col(mytable)])/sum(mytable) 
accuracy

#오분류율
inaccuracy <- 1 - accuracy 
inaccuracy

# 정오분류표 그래프화
library(ggplot2)
test <- testing
colnames(test)
test$pred <- predict(model, testing) #예측된 분류 입력하기

ggplot(test, aes(Species, pred, color = Species)) + geom_jitter(width = 0.2, height = 0.1, size=2) + labs(title="Confusion Matrix", subtitle="Predicted vs. Observed from Iris dataset", y="Predicted", x="Truth")
