# 붓꽃 데이터를 훈련:검증 = 2:1으로 분리한다.
# hidden 노드를 10개로, softmax 분류하도록 한다.
# table 함수를 통해 검증데이터와 모형결과 정확도를 확인한다.
# plot.nnet 함수를 통해 신경망 모형을 확인한다.
# ================================================================
#  01. 환경설정 및 데이터 불러오기
# ================================================================
# library(reshape2)
library(nnet)
library(devtools) # 시각화 R 코드 함수 다운로드
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

data(iris)
# ================================================================
# nnet 종속변수 입력을 위한 종속변수 변환
species.ind <- class.ind(iris$Species)
iris <- cbind(iris, species.ind)
# ================================================================
#  02. 훈련 및 검증 데이터 분리
# ================================================================
train.idx  <-  sample(1:150,100)

training <- iris[train.idx, ]
head(training)
testing <- iris[-train.idx, ]
# ================================================================
#  03. 신경망 모형 적합
# ================================================================
x_data <- training[,c(1:4)]
y_data <- training[,c(6:8)]
model <- nnet(x = x_data, y = y_data, size=10, softmax=TRUE)
plot.nnet(model) # 파일 이름 : 신경망 모형 시각화.png
model
# a 4-10-3 network with 83 weights
# input layer(4), hidden layer(10), output layer(3)
# w와 b의 총갯수는 83이다.
# options were - softmax modelling 
# ================================================================
# 검증 데이터 예측 및 모형 평가
# ================================================================
# 훈련데이터
prediction <- predict(model, x_data, type="class")

# 예측 값과 실제 정답을 혼돈 매트릭스로 비교한다.
table(prediction, training$Species)

# 검증데이터
x_test <- testing[,c(1:4)]
prediction <- predict(model, x_test, type="class")
table(prediction, testing$Species)

# 좀더 많은 공부를 하려면 다음 패키지를 ...
# install.packages('NeuralNetTools')
# library(NeuralNetTools)
# 첨부 파일 : NeuralNetTools.pdf