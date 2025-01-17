library(e1071)
library(ggplot2)

setwd('R Basic Source/32.Naive Bayes/')
data <- read.csv('personinfo.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

range(data$age)
data$age2[data$age >= 10 & data$age < 20] <- '10대'
data$age2[data$age >= 20 & data$age < 30] <- '20대'
data$age2[data$age >= 30 & data$age < 40] <- '30대'
data$age2[data$age >= 40 & data$age < 50] <- '40대'

data$age <- NULL
data

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx,]
testing <- data[-idx,]

model <- naiveBayes(type ~ ., data = training, laplace = 0)
model

pred <- predict(model, testing[-5])
pred

table(예측 = pred, 정답 = testing$type)

testing$pred <- pred

ggplot(testing, aes(x = type, y = pred, color = type)) + geom_jitter(width = 0.2, height = 0.1, size = 2)

