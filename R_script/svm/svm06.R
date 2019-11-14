library(kernlab)

data <- read.csv('../../R Basic Source/31.KNN/likelyhood.csv')
head(data)
str(data)
summary(data)
dim(data)
colnames(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx, ]
testing <- data[-idx, ]

model <- ksvm(likelyhood ~ ., data = training, kernel = 'rbfdot')
pred <- predict(model, testing)

table(pred, testing$likelyhood)
prop.table(table(pred == testing$likelyhood))
