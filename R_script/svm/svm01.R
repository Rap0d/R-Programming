library(kernlab)

data <- read.csv('bmi.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.9 * nrow(data))
training <- data[idx, ]
testing <- data[-idx, ]

model <- ksvm(label ~ ., data = training, kernel = 'vanilladot')
pred <- predict(model, testing)

table(pred, testing$label)

aggrement <- pred == testing$label

prop.table(table(aggrement))

model_rbf <- ksvm(label ~ ., data = training, kernel = 'rbfdot')
pred_rbf <- predict(model_rbf, testing)

table(pred_rbf, testing$label)

aggrement_rbf <- pred_rbf == testing$label

prop.table(table(aggrement_rbf))

