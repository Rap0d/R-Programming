bmidata <- read.csv("bmi.csv")
str(bmidata) #

unique(bmidata$label) # fat normal thin  
length(unique(bmidata$label)) # 3개의 종류

# 훈련 데이터와 테스터 데이터 구분
total_row <- nrow(bmidata)
train_row <- floor(0.9 * nrow(bmidata)) # 90%
training <- bmidata[1:train_row, ]
testing  <- bmidata[(train_row+1):total_row, ]

library(kernlab)

# vanilladot 옵션은 단순 선형 커널을 의미한다.
model <- ksvm(label ~ ., data = training, kernel = "vanilladot")

class(model) # "ksvm"

# help(ksvm)

model # 모델에 대한 기본 정보 확인 

# 모델 성능 평가 : 테스트 데이터셋에 대한 예측
predictions <- predict(model, testing)

head(predictions)

table(predictions, testing$label)
# predictions fat  normal thin
#            fat    751  13      0
#         normal    9    582     17
#           thin    0    7       621

# 예측치와 실제 정답이 일치하는 지를 TRUE/FALSE 벡터로 만들어 본다.
agreement <- predictions == testing$label

table(agreement)

prop.table(table(agreement)) # 

# 모델 성능 향상시키기
model_rbf <- ksvm(label ~ ., data = training, kernel = "rbfdot")

# 시간이 조금 많이 걸린다.
predictions_rbf <- predict(model_rbf, testing)

agreement_rbf <- predictions_rbf == testing$label

table(agreement_rbf)
# 단순히 커널의 변경만으로 문자 인식 모델의 정확도는 84%에서 93% 정도로 증가할 수 있다.
prop.table(table(agreement_rbf))

prop.table(table(agreement))

# ggplot2을 이용한 그래프 그리기 
colnames(bmidata)
mygraph <- ggplot(bmidata, aes(x=height, y=weight))
mygraph + geom_point(aes(color=factor(label)), size=2)

# 일반 plotting으로 그래프 그리기
par(new=T)
height <- bmidata$height
weight <- bmidata$weight
label <- bmidata$label

plot(height, weight)
points(height[label=='thin'], weight[label=='thin'], pch=3, col='red' )
points(height[label=='normal'], weight[label=='normal'], pch=3, col='blue' ) 
points(height[label=='fat'], weight[label=='fat'], pch=3, col='green' ) 
# bmi 산점도 그래프.png

par(mfrow=c(1, 1))