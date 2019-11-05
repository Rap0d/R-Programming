# mushrooms 데이터 셋을 7대3으로 분류한다.
# party 패키지를 이용하여 의사 결정 트리를 실습해본다.
# 학습 데이터를 이용하여 모델을 생성한 다음 이것을 이용하여 검정 데이터를 이용하여 
# 정확도를 확인해보도록 한다.
set.seed(1234)

mushrooms <- read.csv('mushrooms.csv', header=T)

colnames(mushrooms)
# type 컬럼 : 독의 유무(p-poison)
# cap_shape 컬럼 : 버섯의 모양

result = sample(1 : nrow(mushrooms), nrow(mushrooms) * 0.7) 
result  
table(result)   

training = mushrooms[result,] # 학습용 데이터
testing = mushrooms[-result,] # 검정용 데이터  

dim(training)
dim(testing)  

# formula를 생성한다
myformula = type ~ .
# 학습 데이터 이용하여 분류 모델을 생성한다.
# install.packages('party')
library(party)
model = ctree(formula=myformula, data=training) 

model 

# 분류 모델의 시각
plot(model, type="simple")  
plot(model)

# 그래프를 살펴 보면 odor(냄새)과 spore(홀씨 색상)가 가장 중요한 변수로 나타났다.

head(training) # 특정 범위에 있는 데이터들만 서브 셋팅하기

# 분류 모델 예측치 생성 : 검정 데이터 이용 
# 분류 모델과 검정 데이터를 대상으로 predict() 함수를 이용하여 예측 값을 구한다.
pred = predict(model, testing) # 예측치 
pred # y 변수의 레벨(값) 예측

# 예측치와 실제 정답을 이용하여 빈도 분석 표를 만든다. 
# pred는 테스트 데이터를 이용하여 도출된 결과이다.
# test$Species는 붓꽃의 종류를 의미하는 실제 정답이다.
table(pred, testing$type)

accuracy <- (1293 + 1142) / nrow(testing) # 정확도 구하기
round(100 * accuracy, 3)