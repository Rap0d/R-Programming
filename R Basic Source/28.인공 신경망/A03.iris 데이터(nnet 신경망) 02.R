# 데이터 셋 준비
iris
set.seed(1234)
idx = sample(1:nrow(iris), 0.7*nrow(iris)) # 7:3 비율로 나눌 색인 생성 
training = iris[idx, ] # 학습데이터(train data)
testing = iris[-idx, ] # 검정데이터(test data)
nrow(training) # 105(70%)
nrow(testing) # 45(30%)

# 인공 신경망 모델 생성 
model_net_iris1 = nnet(Species ~ ., training, size = 1) # 은닉층 1개
# model_net_iris1 
# a 4-1-3 network with 11 weights
# inputs: Sepal.Length Sepal.Width Petal.Length Petal.Width 
# output(s): Species 
# options were - softmax modelling
# softmax modelling은 다항 분류를 의미한다.

model_net_iris3 = nnet(Species ~ ., training, size = 3) # 은닉층 3개
model_net_iris3 
# a 4-3-3 network with 27 weights
# inputs: Sepal.Length Sepal.Width Petal.Length Petal.Width 
# output(s): Species 
# options were - softmax modelling 

# 여기서 두 모델 모두 출력값이 3개로 나타나는 이유는 출력 변수(Species)의 
# 범주가 3개(setosa, versicolor, virginica)이기 때문이다.

# 한편 입력 변수의 값들이 일정하지 않으면 과적합(overfitting)을 피하기 위해서 정규화 과정이 필요하다.  


# 가중치 망 보기 
# 은닉층의 노드 수가 많아지면 가중치의 갯수가 증가되기 때문에 컴퓨터는 더 많은 연산을 한다.
summary(model_net_iris1) # 11개 가중치 확인

summary(model_net_iris3) # 27개 가중치 확인

# 분류 모델 평가  
prediction <- predict(model_net_iris1, testing, type = "class") 
prediction
testing$Species
table(prediction, testing$Species)
# prediction setosa versicolor virginica
# setosa     11         21        13
testing

mysum <- 11 + 21 + 13
mysum

table(predict(model_net_iris3, testing, type = "class"), testing$Species)
#               setosa versicolor virginica
# setosa        11      0         0
# versicolor    0       20        0
# virginica     0       1         13
(11 + 20 + 13) / nrow(testing)