letters <- read.csv("letterdata.csv")
str(letters) # 'data.frame':	20000 obs. of  17 variables:

unique(letters$letter)
length(unique(letters$letter)) # 26개의 알파벳

# 훈련 데이터와 테스터 데이터 구분
total_row <- nrow(letters)
train_row <- floor(0.8 * nrow(letters))
letters_train <- letters[1:train_row, ]
letters_test  <- letters[(train_row+1):total_row, ]

# 단순 선형 SVM을 훈련으로 시작
library(kernlab)

# vanilladot 옵션은 단순 선형 커널을 의미한다.
model <- ksvm(letter ~ ., data = letters_train,
                          kernel = "vanilladot")

class(model) # "ksvm"

# help(ksvm)

model # 모델에 대한 기본 정보 확인
# Support Vector Machine object of class "ksvm"
#
# SV type: C-svc  (classification)
# parameter : cost C = 1
#
# Linear (vanilla) kernel function.
#
# Number of Support Vectors : 7037
#
# Objective Function Value : -14 ... 중략
# Training error : 0.130062

# 모델 성능 평가 : 테스트 데이터셋에 대한 예측
prediction <- predict(model, letters_test)

head(prediction)

table(prediction, letters_test$letter)
# prediction   A   B    C   D   E  ... 중략
#                   A 144   0   0   0   0
#                   B   0 121   0   5   2
#                   C   0   0 120   0   4
#                   D   2   2   0 156   0
#                   E   0   0   5   0 127

# 예측치와 실제 정답이 일치하는 지를 TRUE/FALSE 벡터로 만들어 본다.
agreement <- prediction == letters_test$letter

table(agreement)
# FALSE  TRUE
# 643  3357

# 실제 개발자 프레이와 스레이트가 논문을 발표할 때에도 80% 정도의 인식 및 정확도로 보고 했었다.
prop.table(table(agreement)) # 비율 약 84% 정도
# agreement
# FALSE    TRUE
# 0.16075 0.83925

# 모델 성능 향상시키기
model_rbf <- ksvm(letter ~ ., data = letters_train, kernel = "rbfdot")

# 시간이 조금 많이 걸린다.
prediction_rbf <- predict(model_rbf, letters_test)

agreement_rbf <- prediction_rbf == letters_test$letter

table(agreement_rbf)
# agreement_rbf
# FALSE  TRUE
# 278  3722

# 단순히 커널의 변경만으로 문자 인식 모델의 정확도는 84%에서 93% 정도로 증가할 수 있다.
prop.table(table(agreement_rbf))
# agreement_rbf
# FALSE   TRUE
# 0.0695 0.9305
