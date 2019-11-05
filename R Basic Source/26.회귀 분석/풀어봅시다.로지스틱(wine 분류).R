wine <- read.csv('wine.csv', header=F, stringsAsFactors=F)

dim(wine) # 6497   13
head(wine)
str(wine)

set.seed(1234) # 시드 배정
idx <- sample(1:nrow(wine), 0.7 * nrow(wine))

training <- wine[idx, ]
testing <- wine[-idx, ]

# 로지스틱 회귀 모델 생성
model <- glm(V13 ~ ., data=training, family = 'binomial' )
model

coef(model)
summary(model)

# 로지 스틱 회귀 모델 예측치 생성
# model 모델을 이용하여 testing 데이터를 검증해 주세요.
pred <- predict(model, newdata=testing, type='response')
pred[1:10] # 10개만 조회하기

# 예측치를 이항형으로 변환
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred[1:10]

table(result_pred)
# result_pred
# 0    1 
# 1485  465

table(testing$V13)
# 0    1 
# 1482  468 

conf_matrix <- table(result_pred, testing$V13)
conf_matrix
# result_pred    0     1
# 0              1477  8
# 1              5     460

accuracy <- (1477 + 460) / sum(conf_matrix)
round(100 * accuracy, 3) # 0.9933333

# ROC Curve를 이용한 모델 평가
# Receiver Operating Characteristic 패키지 설치
# install.packages("ROCR")
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, testing$V13)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)