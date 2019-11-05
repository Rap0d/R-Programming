library(ROCR)

data <- read.csv('weather.csv', header = T)
str(data)
colnames(data)
unique(data$RainTomorrow)

# 로지스틱 회귀는 확률로 따지는 것이므로 숫자화
data$RainTomorrow <- as.character(data$RainTomorrow)

# recode 비온다(1), 안온다(0)
data$RainTomorrow[data$RainTomorrow == 'Yes'] <- 1
data$RainTomorrow[data$RainTomorrow == 'No'] <- 0
data$RainTomorrow <- as.numeric(data$RainTomorrow)
data$RainTomorrow
str(data$RainTomorrow)
dim(data)
table(data$RainTomorrow)

# 학습용과 점검용으로 데이터 분석
train_row <- round(0.7 * nrow(data))
train_row

training <- data[1:train_row,]
testing <- data[(train_row + 1):nrow(data), ]
dim(training)
dim(testing)

colnames(data)

# family = 'binomial' : 이항 분류를 위한 옵션
model <- glm(RainTomorrow ~ ., data = training, family = 'binomial')
summary(model)
model

# sigmoid function : 일반적인 수를 0에서 1까지로 변환
## 이것을 0.5를 기준으로 0과 1로 변환하여 로지스틱 회귀분석
pred <- predict(model, newdata = testing, type = 'response')
head(pred)
head(testing$RainTomorrow)
# > head(pred)
# 257         258         259         260         261         262 
# 0.017666666 0.093528864 0.240739871 0.100249740 0.153547394 0.008485457 
# > head(testing$RainTomorrow)
# [1] 0 0 0 0 1 0

# 예측치 -> 이항형으로 변환
res_pred <- ifelse(pred >= 0.5, 1, 0)
res_pred

mTable <- table(res_pred, testing$RainTomorrow)
mTable
# res_pred    0  1
#         0 90  9
#         1  1  7

accuracy <- (90 + 7) / sum(mTable)
accuracy

# predict, prediction : 예측치
# labels : 정답(answer)
pr <- prediction(predictions = pred, testing$RainTomorrow)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf, main = 'ROC Curve')
