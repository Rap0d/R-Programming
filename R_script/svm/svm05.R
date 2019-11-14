library(kernlab)

data <- read.csv('mushrooms.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

data <- data[, -17]

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx, ]
testing <- data[-idx, ]

model <- ksvm(type ~ ., data = training, kernel = 'rbfdot')
pred <- predict(model, testing)

table(pred, testing$type)
prop.table(table(pred == testing$type))
