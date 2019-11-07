library(party)

data <- read.csv('mushrooms.csv')
head(data)
str(data)
summary(data)
dim(data)

# sampling data
idx <- sample(1:nrow(data), 0.7 * nrow(data))

training <- data[idx,]
testing <- data[-idx,]

dim(training)
dim(testing)

mFomula <- type ~ .
model <- ctree(formula = mFomula, data = data)
model

plot(model)

# prediction
pred <- predict(model, testing)

mTable <- table(pred, testing$type)

ch <- mTable[1, 1] + mTable[2, 2]
mo <- sum(mTable)

acc <- ch / mo
round(100 * acc, 3)
