library(devtools)
library(nnet)
library(party)
library(ROCR)

setwd('R Basic Source/28.인공 신경망')
# 데이터 셋 : ThoraricSurgery.csv
# 마지막 컬럼이 폐암 여부를 저장하고 있는 열이다.
# 데이터 셋을 읽어 들이시오.
data <- read.csv('ThoraricSurgery.csv', header = F)
head(data)
str(data)
summary(data)
dim(data)

head(data$V18)

# 훈련:테스트 = 7:3으로 데이터 셋을 나누세요.
idx <- sample(1:nrow(data), 0.7 * nrow(data))
training <- data[idx,]
testing <- data[-idx,]

# 로지스틱 회귀 모델을 생성하세요.
model <- glm(V18 ~ ., data = training, family = 'binomial')
model

# 로지 스틱 회귀 모델에 대하여 예측 값을 구해 보세요.
pred <- predict(model, newdata = testing, type = 'response')
pred
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred

# confusion matrix를 이용하여 정확도를 구해 보세요.
mTable <- table(result_pred, testing$V18)
mTable

acc <- round((mTable[1,1] + mTable[2,2]) / sum(mTable) * 100, 2)
acc

# ROC 곡선을 그려 보세요.
pr <- prediction(pred, testing$V18)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf, main='ROC Curve Graph')