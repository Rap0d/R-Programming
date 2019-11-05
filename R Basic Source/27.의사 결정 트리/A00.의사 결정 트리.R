# iris 데이터 셋을 7대3으로 분류한다.
# party 패키지를 이용하여 의사 결정 트리를 실습해본다.
# 학습 데이터를 이용하여 모델을 생성한 다음 이것을 이용하여 검정 데이터를 이용하여 
# 정확도를 확인해보도록 한다.
set.seed(1234)

# 학습 데이터와 검증 데이터를 샘플링한다.
result = sample(1 : nrow(iris), nrow(iris) * 0.7) 
result # 전체 행의 70%를 샘플링
table(result)  # 7:3비율 데이터 생성

training = iris[result,] # 학습용 데이터
testing = iris[-result,] # 검정용 데이터  

dim(training)# [1] 105   5
dim(testing) # [1] 45  5

info_entropy <- function(x) { 
  factor_x <- factor(x) 
  # cat(factor_x, '\n')
  # cat(levels(factor_x), '\n')
  # cat(length(x), '\n')
  entropy <- 0 
  for(item in levels(factor_x)) {
    prob <- sum(x == item) / length(x) 
    entropy <- entropy - prob * log2(prob) 
  }
  return (entropy)
}
colnames(training)
info_entropy(unlist(training['Sepal.Length']))
info_entropy(unlist(training['Sepal.Width']))
info_entropy(unlist(training['Petal.Length']))
info_entropy(unlist(training['Petal.Width']))

# formula를 생성한다
myformula = Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width 
# 학습 데이터 이용하여 분류 모델을 생성한다.
# install.packages('party')
library(party)
model = ctree(formula=myformula, data=training) 

model     # 모델 결과 
# 분류 모델의 결과를 보면 Petal.Length과 Petal.Width이 가장 중요한 변수로 파악된다.
# 단, 표본에 의하여 추출이 된 결과이므로 실행 결과는 상황에 따라서 다를 수 있다.

# 분류 모델의 시각
plot(model, type="simple") # iris(간단히 보기).png
plot(model) # iris(트리 결과).png

# 그래프를 살펴 보면 Petal.Length(꽃잎의 길이)과 Petal.Width(꽃잎의 너비)가 가장 중요한 변수로 나타났다.

head(training) # 특정 범위에 있는 데이터들만 서브 셋팅하기
result = subset(training, Petal.Length > 1.9 & Petal.Width > 1.7)
table(result$Species) 
# setosa versicolor  virginica 
# 0          1         35 
 
# 분류 모델 예측치 생성 : 검정 데이터 이용 
# 분류 모델과 검정 데이터를 대상으로 predict() 함수를 이용하여 예측 값을 구한다.
pred = predict(model, testing) # 예측치 
pred # y 변수의 레벨(값) 예측

# 예측치와 실제 정답을 이용하여 빈도 분석 표를 만든다. 
# pred는 테스트 데이터를 이용하여 도출된 결과이다.
# test$Species는 붓꽃의 종류를 의미하는 실제 정답이다.
table(pred, testing$Species)

accuracy <- (11 + 21 + 10) / nrow(testing) # 정확도 구하기
round(100 * accuracy, 3)