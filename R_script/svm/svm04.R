library(kernlab)

data <- read.csv('letterdata.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx, ]
testing <- data[-idx, ]

model <- ksvm(letter ~ ., data = training, kernel = 'rbfdot')
pred <- predict(model, testing)

table(pred, testing$letter)
prop.table(table(pred == testing$letter))
