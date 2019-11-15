library(e1071)
library(ggplot2)

setwd('R Basic Source/32.Naive Bayes/')
data <- read.csv('personinfo.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx,]
testing <- data[-idx,]

model <- naiveBayes(type ~ ., data = training)
model

pred <- predict(model, testing[-6])
pred

table(예측 = pred, 정답 = testing$type)

testing$pred <- pred

ggplot(testing, aes(x = type, y = pred, color = type)) + geom_jitter(width = 0.2, height = 0.1, size = 2)
