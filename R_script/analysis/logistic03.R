library(ROCR)

data <- read.csv('wine.csv', header = F)
str(data)
summary(data)

idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx, ]
testing <- data[-idx, ]

# 로지스틱 회귀 모델
model <- glm(V13 ~ ., data = training, family = 'binomial')

coef(model)

# 로지스틱 회귀모델 예측치 생성
## model을 이용하여 testing 데이터 검증
pred <- predict(model, newdata = testing, type = 'response')
head(pred)

# recode
pred_res <- ifelse(pred >= 0.5, 1, 0)
head(pred_res)

table(pred_res)
# pred_res
# 0    1 
# 1476  474 

conf <- table(pred_res, testing$V13)
conf
# pred_res    0    1
#       0 1468    8
#       1    6  468

acc <- (conf[1, 1] + conf[2, 2]) / sum(conf)
acc
accPer <- paste(round(100 * acc, 2), '%', sep = '')
# [1] 0.9928205

# ROC Curve를 이용한 모델 평가
pr <- prediction(pred, testing$V13)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
mainText <- paste('ROC Curve', accPer)
plot(prf, main = mainText)