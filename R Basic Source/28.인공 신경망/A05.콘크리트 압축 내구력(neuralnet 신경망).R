# install.packages("neuralnet")
library("neuralnet")

# 콘크리트의 강도 모델링
concrete <- read.csv("concrete.csv")
str(concrete)
dim(concrete) # 1030    9
head(concrete)
head(concrete[, c('water', 'superplastic', 'coarseagg')])

# 신경망은 0을 중심으로 데이터가 좁게 형성이 되어 있는 경우 잘 동작하는 
# 특징을 가지고 있으므로 min-max 알고리즘을 이용하여 정규화를 수행하면 좋다.
normalize <- function(x) { 
  return((x - min(x)) / (max(x) - min(x)))
}

# 전체 데이터 프레임에 정규화 적용
concrete_norm <- as.data.frame(lapply(concrete, normalize))
head(concrete_norm)

# 0과 1사이의 범위에 있는 지 확인한다.
summary(concrete_norm$strength)

# 원래 데이터의 최소값, 최대값 비교
summary(concrete$strength)

# 훈련과 테스트 데이터 생성
train_row = round(0.75 * nrow(concrete))
concrete_train <- concrete_norm[1:train_row, ]
concrete_test <- concrete_norm[(train_row+1):nrow(concrete), ]

head(concrete_test)
## 3단계 : 데이터로 모델 훈련 ----
# neuralnet 모델 훈련
library(neuralnet)

# 하나의 은닉 뉴런에 대한 단순한 ANN
myformula <- strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age
concrete_model <- neuralnet(formula = myformula, data = concrete_train)

# 망(network) 시각화 : # 콘크리트 망(network) 시각화.png
plot(concrete_model)

# 모델 성능 평가 help(compute)
testing_x <- concrete_test[1:8]
model_results <- compute(concrete_model, testing_x)

# 강도값 예측
attributes(model_results)
predicted_strength <- model_results$net.result

# 분류 문제가 아니라 모델의 정확도(수치 예상하기 문제)를 확인하는 예제이다.
# 따라서 콘크리트의 강도와 실제 값의 상관 관계를 확인해야 한다.
cor(predicted_strength, concrete_test$strength)

# 모델 성능 향상 ----
# hidden 옵션은 히든 레이어를 의미하는 데
# 만약 hidden = c(5,2)라고 하면 1번째 히든 레이어는 5개의 노드
# 2번째 히든 레이어는 노드가 2개가 된다.
# 5개 은닉 뉴런인 복잡한 뉴런망
concrete_model2 <- neuralnet(formula = myformula, data = concrete_train, hidden = 5)

# 망(network) 시각화 : 콘크리트 망 시각화(hidden=5).png
plot(concrete_model2)

# 결과 평가
model_results2 <- compute(concrete_model2, concrete_test[1:8])
predicted_strength2 <- model_results2$net.result
cor(predicted_strength2, concrete_test$strength)