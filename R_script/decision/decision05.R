library(party)
setwd('R Basic Source/27.의사 결정 트리')
data <- read.csv('product_sales.csv')

str(data)
summary(data)
colnames(data)
s
idx <- sample(1:nrow(data), 0.7 * nrow(data))

training <- data[idx,]
testing <- data[-idx,]

mFormula <- tot_price ~ .
model <- ctree(formula = mFormula, data = training)
model

plot(model)
# tot price 에 영향을 가장 많이 미치는 독립 변수는 avg_price이다.

pred <- predict(model, testing)
pred
length(pred)

mTable <- table(round(pred, 1), testing$tot_price)
mTable

ch <- mTable[1, 1] + mTable[2, 2]
mo <- sum(mTable)

acc <- ch / mo
round(100 * acc, 3)

