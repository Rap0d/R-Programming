# install.packages("neuralnet") 
library(neuralnet)

data("iris")
set.seed(1234)
idx = sample(1:nrow(iris), 0.7*nrow(iris))
training_iris = iris[idx, ]
testing_iris = iris[-idx, ]
dim(training_iris) # 105   6
dim(testing_iris) # 45  6

# neuralnet 패키지의 출력 변수(y)는 0/1과 같이 수치형 이여야 한다. 
# 학습용 데이터
training_iris$Species2[training_iris$Species == 'setosa'] <- 1 
training_iris$Species2[training_iris$Species == 'versicolor'] <- 2 
training_iris$Species2[training_iris$Species == 'virginica'] <- 3
training_iris$Species <- NULL # 기존 칼럼 제거 
head(training_iris)

# 훈련용 데이터
testing_iris$Species2[testing_iris$Species == 'setosa'] <- 1 
testing_iris$Species2[testing_iris$Species == 'versicolor'] <- 2 
testing_iris$Species2[testing_iris$Species == 'virginica'] <- 3
testing_iris$Species <- NULL # 기존 칼럼 제거 
head(testing_iris)

# 데이터 정규화 : 연산시 0과 1사이의 값으로 변환하여 속도 향상을 기대할 수 있다.
# 학습 데이터와 검정 데이터의 칼럼을 대상으로 0과 1사이의 값으로 정규화 한다.
normalization <- function(x){
  return (( x - min(x)) / (max(x) - min(x)))
}
training_nor <- as.data.frame(lapply(training_iris, normalization))
summary(training_nor) # 0과 1사이의 칼럼과 확인

testing_nor <- as.data.frame(lapply(testing_iris, normalization))
summary(testing_nor) 

# 인공 신경망 모델 생성 : 은닉 노드 1개 
# 형식) neuralnet(formula, data, hidden) 
model_net = 
    neuralnet(Species2 ~ Sepal.Length+Sepal.Width+Petal.Length+ Petal.Width, 
                data=training_nor, hidden = 1)
class(model_net)
plot(model_net) # 인공 신경망 시각화.png 

# 은닉층 노드 수 : 1개
# 입력층에서 4개의 입력 변수에 대한 가중치와 경계값(bias) 가중치가 은닉층으로 전달되고, 
# 은닉층의 결과에 대한 가중치와 경계값 가중치가 출력층으로 전달되는 과정을 볼 수 있다.

# help(compute)
# 분류 모델 성능 평가
# (1) 모델의 예측치 생성 : compute()함수 이용 
model_result <- compute(model_net, testing_nor[c(1:4)])
model_result
model_result$net.result # 분류 예측값 보기  

# 분류 정확도 구하는 요령
# 모델의 예측치(model_result$net.result)와 검정 데이터의 y 변수를
# 이용하여 피어슨의 상관 계수를 구하면 된다.로 
# 즉 예측된 꽃의 종과 실제 관측치(testing_nor) 사이의 상관 관계를 측정한다. 
cor(model_result$net.result, testing_nor$Species2)
# 0.9591815561

# 분류 모델 성능 향상 : 은닉층 노드 2개 지정, backprop 속성 적용 
model_net2 = 
    neuralnet(Species2 ~ Sepal.Length+Sepal.Width+Petal.Length+ Petal.Width,
           data=training_nor, hidden = 2, 
           algorithm="backprop", learningrate=0.01 ) 

# (2) 분류모델 예측치 생성과 평가 
model_result2 <- compute(model_net2, testing_nor[c(1:4)])

cor(model_result2$net.result, testing_nor$Species2)  
# 0.9589408419

# 분류 모델의 성능을 향상 시키기 위한 방법
# 은닉층의 노드(hidden)를 증가시키기
# 역전파 알고리즘 등의 적용
# learningrate 조정하기