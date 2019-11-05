weather <- read.csv('weather.csv', header=T)
str(weather)
unique(weather$RainTomorrow)

weather$RainTomorrow <- as.character(weather$RainTomorrow)

# y 변수(RainTomorrow)의 로짓 변환 : 더미 변수 생성
# 내일 비온다(1)/비 안온다(0)
weather$RainTomorrow[weather$RainTomorrow == 'Yes'] <- 1
weather$RainTomorrow[weather$RainTomorrow == 'No'] <- 0

# RainTomorrow 컬럼을 숫자 형식으로 변경하여 로지스틱 회귀 분석을 위한 환경을 마련한다.
weather$RainTomorrow <- as.numeric(weather$RainTomorrow)

unique(weather$RainTomorrow)

str(weather) # RainTomorrow 컬럼이 숫자형인지 확인한다.
dim(weather) # 366  11

train_row <- round(0.7 * nrow(weather))
train_row # 전체의 70%에 해당하는 행

training <- weather[1:train_row, ] # 366 * 0.7 = 256.2 → 256개 
testing <- weather[(train_row+1):nrow(weather), ] # 366 * 0.3 = 109.8 → 110개
dim(training)
dim(testing)

# 로지스틱 회귀 모델 생성
# family = 'binomial'은 종속 변수가 이항형일 경우 지정해주는 속성값이다. 
model <- glm(RainTomorrow ~ ., data=training, family = 'binomial' )
model
summary(model)

# 로지 스틱 회귀 모델에 대하여 예측치를 생성한다.
# model 모델을 이용하여 testing 데이터를 검증해 주세요.
# type='response'은 0.0에서 1.0 사이의 값으로 만들어 준다.
pred <- predict(model, newdata=testing, type='response')
pred <- predict(model, newdata=testing)
mode(pred) # "numeric"
class(pred) # "numeric"
pred # 1에 가까울수록 비 올 확률이 높다.

# 예측치를 이항형으로 변환
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred

table(result_pred)

# 모델 평가 : 분류 정확도 계산
# table(예측값, 실제 정답)
table(result_pred, testing$RainTomorrow)

accuracy <- (90+7)/(90+7+1+9) # 정확도 
accuracy

install.packages("ROCR") 
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, testing$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main='ROC Curve 그래프') # ROC Curve 그래프.png