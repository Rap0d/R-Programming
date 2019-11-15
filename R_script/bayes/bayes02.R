library(e1071)

setwd('R Basic Source/32.Naive Bayes/')
data <- read.csv('spam_filter.csv', header = T)
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

training <- data[c(1:10),]
testing <- data[-c(1:10),]

model <- naiveBayes(메일종류 ~ ., data = training)
model

pred <- predict(model, testing[-13])
pred

table(예측 = pred, 정답 = testing$메일종류)

