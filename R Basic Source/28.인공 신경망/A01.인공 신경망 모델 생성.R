# install.packages('devtools')
# install.packages("nnet")
library(nnet)
library(devtools)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

some <- read.csv('somedata.csv', header=T)
# some$y <- as.factor(some$y) # 분류 문제로 변경하기 위하여 ....
str(some)

# 시드 배정을 하지 않으면 매번 결과가 다를 수 있다.
set.seed(1234)
# help(nnet)
# 인공 신경망 모델 생성 
model = nnet(y ~ ., some, size = 1) # size는 은닉층 수
# weights:  5 # b 항목을 포함하여 가중치의 갯수가 5이다. 
# 출력 결과를 보면 기계 학습에 의하여 오차가 점진적으로 줄어 드는 것을 알 수 있다.
mode(model)
class(model)
plot.nnet(model)
model
# a 2-1-1 network with 5 weights
# inputs: x1 x2 
# output(s): y 
# options were - entropy fitting 
# entropy fitting은 로지스틱 분류를 의미한다. 

# 가중치(weights) 보기 
summary(model) 
# a 2-1-1 network with 5 weights
# options were - entropy fitting 

attributes(model) # 가진 속성들 확인하기

# 분류의 모델 적합값 확인하기
model$fitted.values

# 분류 모델의 예측치 생성과 분류 정확도
# type="class"을 지정하게 되면 예측 결과를 출력 변수 y의 범주로 분류한다.
pred <- predict(model, some, type="class") # 분류 모델의 예측치 생성 

# table 함수를 이용하여 분류가 정확히 되었는 지를 확인해보도록 한다.
table(pred, some$y) # 혼돈 matrix 생성   
# pred  no yes
# no    3   0
# yes   0   3