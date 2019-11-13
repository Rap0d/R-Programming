# 파일 이름 : customers.csv
# 쇼핑몰에서 회원의 구매 시간대별 소비 지수를 조사한 데이터 셋이 있다.
# 이 정보를 이용하여 해당 구매 고객에 대한 성별을 판단해 보는 
# KNN 모델을 만들어 보세요.
# 이 모델에 대하여 다음 데이터를 이용하여 성별을 예측해보도록 하세요.
# 남자 또는 여자일 확률도 구해 보세요.

data <- read.csv('customers.csv', stringsAsFactors = F)

head(data)
str(data)
summary(data)
dim(data)
colnames(data)
rownames(data)

test <- data.frame(아침 = 12, 점심 = 20, 저녁 = 50, 주말 = 91)

data$mo <- scale(data$아침)
data$lu <- scale(data$점심)
data$di <- scale(data$저녁)
data$we <- scale(data$주말)

trainX <- data[,c(6:9)]
trainX

trainY <- data[,c(5)]
trainY

kSize_1 <- floor(sqrt(nrow(data)))
kSize_1 <- ifelse(kSize_1 %% 2 == 0, kSize_1 + 1, kSize_1)
kSize_1

knnPred_1 <- knn(train = trainX, test = test, cl = trainY, k = kSize_1, prob = T)
knnPred_1
