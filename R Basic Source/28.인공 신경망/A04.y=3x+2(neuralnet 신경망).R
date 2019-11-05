# install.packages("neuralnet")
library("neuralnet")

# 콘크리트의 강도 모델링
some <- read.csv("some.csv")

str(some)
dim(some) # 1030    9
head(some)

# 신경망은 0을 중심으로 데이터가 좁게 형성이 되어 있는 경우 잘 동작하는 
# 특징을 가지고 있으므로 min-max 알고리즘을 이용하여 정규화를 수행하면 좋다.
normalize <- function(x) { 
  return((x - min(x)) / (max(x) - min(x)))
}

# 전체 데이터 프레임에 정규화 적용
some_norm <- as.data.frame(lapply(some, normalize))
head(some_norm)

# some_norm$y <- some_norm$y1
some_norm$y <- some_norm$y2

some_norm <- some_norm[c('x', 'y')]

# 0과 1사이의 범위에 있는 지 확인한다.
summary(some_norm$y)

# 훈련과 테스트 데이터 생성
train_row = round(0.75 * nrow(some))
some_train <- some_norm[1:train_row, ]
some_test <- some_norm[(train_row+1):nrow(some), ]

head(some_test)
## 3단계 : 데이터로 모델 훈련 ----
# neuralnet 모델 훈련
library(neuralnet)

# 하나의 은닉 뉴런에 대한 단순한 ANN
myformula <- y ~ x
model <- neuralnet(formula = myformula, data = some_train, hidden = 5)

# 망(network) 시각화 : 콘크리트 망 시각화(hidden=5).png
plot(model)

# 결과 평가
model_result <- compute(model, some_test[1:1])
prediction <- model_result$net.result

df <- data.frame(predict=prediction, real=some_test$y)
head(df)

x <- seq(1:length(prediction))
plot( x=x, y=prediction, type='n', xlab='', ylab='값', ylim=c(0, 1))

points(x, prediction, pch=4, col='red' ) # pch=3 십자가 모양

points(x, some_test$y, pch=1, col='blue' ) # pch=1 내부가 비어 있는 원

legend('bottomright', legend=c('prediction', 'answer'), pch=c(4, 1))

cor(prediction, some_test$y)
