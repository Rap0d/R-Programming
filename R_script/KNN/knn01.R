library(class)

data <- read.csv('likelyhood.csv', stringsAsFactors = F)
str(data)
summary(data)
dim(data)
colnames(data)

# 1~13행까지 8열만 빼고 training
trainX <- data[c(1:13), -8]
trainX

trainY <- data[c(1:13), 8]
trainY

testX <- data[c(14:14), -8]
testX

testY <- data[c(14:14), 8]
testY

# kSize : 최근접 이웃의 수를 명시하는 정수
kSize_1 <- floor(sqrt(nrow(trainX)))
kSize_1 <- ifelse(kSize_1 %% 2 == 0, kSize_1 + 1, kSize_1)
kSize_1

# K-Nearest Neighbor Algorithm
## 범주를 모르는 데이터에 대해 분류되어 있는 가장 유사한 예제 범주로 지정
## knn func : class Package
## prob : 확률값 표시 여부
knnPred_1 <- knn(train = trainX, test = testX, cl = trainY, k = kSize_1, prob = T)
knnPred_1

