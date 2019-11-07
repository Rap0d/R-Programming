library(rpart)

head(iris)
unique(iris)

# Species를 결정짓는 컬럼에 대해 의사 결정 트리로 풀어보기

# 훈련 : 검정 = 7 : 3으로 분류
idx <- sample(1:nrow(iris), 0.7 * nrow(iris))
training <- iris[idx,]
testing <- iris[-idx,]

# 분류 모델 생성
colnames(iris)
mFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

model <- rpart(formula = mFormula, data = iris, control = rpart.control(minsplit = 2))
plot(model, compress = T, uniform = T, margin = 0.1)
text(model, use.n = T, col = 'blue')

model

# 예측하기, 다항 분류는 softmax 함수
dim(testing)
prop.prediction <- predict(model, testing)
prop.prediction

prediction <- ifelse(prop.prediction[,1] >= 0.5, 'setosa', ifelse(prop.prediction[,2] >= 0.5, 'versicolor', 'virginica'))
prediction

mTable <- table(prediction, testing$Species)
mTable

ch <- mTable[1, 1] + mTable[2, 2] + mTable[3, 3]
mo <- sum(mTable)

acc <- ch / mo
round(100 * acc, 3)
