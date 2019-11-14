library(kernlab)

data <- read.csv('zoo_data.csv')
testing <- read.csv('zoo_testing.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

model <- ksvm(type ~ ., data = data, kernel = 'rbfdot')
pred <- round(predict(model, testing), 0)

table(pred, testing$type)

aggrement <- pred == testing$type

prop.table(table(aggrement))
