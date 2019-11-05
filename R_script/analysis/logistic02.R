library(ROCR)

data <- read.csv('pima-indians-diabetes.csv', header = F)
str(data)
summary(data)
ncol(data)

# V9이 종속 변수
dim(data)
# set.seed(1234)
idx <- sample(1:nrow(data), 0.7 * nrow(data))
train <- data[idx,]
test <-data[-idx,]
dim(train)
dim(test)
# > dim(train)
# [1] 537   9
# > dim(test)
# [1] 231   9

model <- glm(V9 ~ ., data = train, family = 'binomial')
pred <- predict(model, newdata = test, type = 'response')

pred_res <- ifelse(pred >= 0.5, 1, 0)

head(pred_res)
head(test$V9)
# > head(pred_res)
# 9 10 12 13 14 17 
# 1  0  1  1  1  0 
# > head(test$V9)
# [1] 1 1 1 0 1 1

mTable <- table(pred_res, test$V9)
a <- mTable[1, 1]
b <- mTable[2, 2]

acc <- (a + b) / sum(mTable)
accPer <- paste(round(100 * acc, 2), '%', sep = '')

# K겹 교차 검증
pr <- prediction(pred, test$V9)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
mainText <- paste('ROC Curve', accPer)
plot(prf, main = mainText)