library(e1071)
library(ggplot2)

setwd('R Basic Source/32.Naive Bayes/')
data <- iris
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx,]
testing <- data[-idx,]

model <- naiveBayes(Species ~ ., data = training)
model

pred <- predict(model, testing[-5])
pred

table(예측 = pred, 정답 = testing$Species)

testing$pred <- pred

ggplot(testing, aes(x = Species, y = pred, color = Species)) + geom_jitter(width = 0.2, height = 0.1, size = 2)
