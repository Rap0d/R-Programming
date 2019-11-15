library(e1071)
library(ggplot2)

data <- read.csv('mushrooms.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx,]
testing <- data[-idx,]

model <- naiveBayes(type ~ ., data = training, laplace = 0)
model

pred <- predict(model, testing[-1])
pred

table(예측 = pred, 정답 = testing$type)

testing$pred <- pred

ggplot(testing, aes(x = type, y = pred, color = type)) + geom_jitter(width = 0.2, height = 0.1, size = 2)

