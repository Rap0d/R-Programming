pima_indian <- read.csv('pima-indians-diabetes.csv', header=F, stringsAsFactors=F)

colnames(pima_indian) <- c("pregnant", "plasma", "pressure", "thickness", "insulin", "BMI", "pedigree", "age", "class")

dim(pima_indian) # [1] 768   9
head(pima_indian)

str(pima_indian)
# 
# data <- seq(1:10)
# data

# 학습용 데이터(train) : 훈련을 시키기 위한 데이터 → 모델 생성됨(pima_indian_model)
# 검정용 데이터(test) : 모델을 검증하기 위한 데이터
set.seed(1234) # 시드 배정
idx <- sample(1:nrow(pima_indian), 0.7 * nrow(pima_indian))

train <- pima_indian[idx, ] # 366 * 0.7 = 256.2 → 256개
test <- pima_indian[-idx, ] # 366 * 0.3 = 109.8 → 110개

# 로지스틱 회귀 모델 생성
pima_indian_model <- glm(class ~ ., data=train, family = 'binomial' )
pima_indian_model

coef(pima_indian_model) # 회귀 계수
summary(pima_indian_model)

# 로지 스틱 회귀 모델 예측치 생성
# pima_indian_model 모델을 이용하여 test 데이터를 검증해 주세요.
pred <- predict(pima_indian_model, newdata=test, type='response')
pred

# 예측치를 이항형으로 변환
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred

table(result_pred) # 예측치
table(test$class) # 정답 label
table(result_pred, test$class)
# result_pred   0    1
# 0             138  35
# 1             16   42

accuracy <- (138 + 42) / nrow(test)
accuracy # [1] 0.7792208

# ROC Curve를 이용한 모델 평가
# Receiver Operating Characteristic 패키지 설치
# install.packages("ROCR")
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, test$class)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)