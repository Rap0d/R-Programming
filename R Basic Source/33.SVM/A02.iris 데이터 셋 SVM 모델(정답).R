str(iris) # data.frame':	150 obs. of  5 variables:

# iris는 3가지의 품종으로 분류 되어 있다.
unique(iris$Species) 
length(unique(iris$Species))

set.seed(1234)
idx = sample(1:nrow(iris), 0.7*nrow(iris))
training = iris[idx, ]
testing = iris[-idx, ]
dim(training)  
dim(testing)  

library(kernlab)

# vanilladot 옵션은 단순 선형 커널을 의미한다.
model <- ksvm(Species ~ ., data = training, kernel = "vanilladot")

model # 모델에 대한 기본 정보 확인 
# Support Vector Machine object of class "ksvm" 
# 
# SV type: C-svc  (classification) 
# parameter : cost C = 1 
# 
# Linear (vanilla) kernel function. 
# 
# Number of Support Vectors : 22 
# 
# Objective Function Value : -1.0097 -0.2741 -12.6722 
# Training error : 0.009524 

# 모델 성능 평가 : 테스트 데이터셋에 대한 예측
pred <- predict(model, testing)

head(pred)

table(pred, testing$Species)

# 예측치와 실제 정답이 일치하는 지를 TRUE/FALSE 벡터로 만들어 본다.
agreement <- pred == testing$Species

table(agreement)
# agreement
# FALSE  TRUE 
# 1    44 
##################################################################
# 적절한 파라미터 찾기
# svm을 잘 사용하려면 적절한 파라미터 값을 찾아야 한다.
# install.packages('e1071')
library(e1071)

result <- tune(svm, Species ~ ., data=iris, gamma=2^(-1:1), cost=2^(2:4))
attributes(result)

result$best.model # 모델 정보 확인
# Call:
#   best.tune(method = svm, train.x = Species ~ ., data = iris, gamma = 2^(-1:1), cost = 2^(2:4))
# 
# Parameters:
#   SVM-Type:  C-classification 
# SVM-Kernel:  radial 
# cost:  4 8 16 
# gamma:  0.5 1 2 
# 
# Number of Support Vectors:  49

result$best.model['gamma'] # gamma 확인

result$best.model['cost'] # cost 확인
##################################################################