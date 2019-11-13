data <- read.csv('saleinfo.csv', stringsAsFactors = F)

head(data)
str(data)
summary(data)
dim(data)
colnames(data)
rownames(data)

# 파일 이름 : saleinfo.csv
# 쇼핑몰 고객 정보를 담고 있는 엑셀 파일과
# KNN을 이용하여 고객의 구매 여부를 예측해보세요.
# 
# 컬럼 : 나이,월급,구매여부
# 나이와 월급 정보를 이용하여 구매 여부를 파악하는 예시이다.
# 나이와 월급은 Z 표준화 변환을 수행하여 테스트 하도록 한다.
# 테스트할 데이터 정보는 다음과 같다.
test_x <- data.frame(age=44, income=400)

data$age <- scale(data$나이)
data$income <- scale(data$월급)

# 표준화 변환 공식 Z = (X - mu) / sigma
data$age2 <- (data$나이 - mean(data$나이)) / sd(data$나이)
data$age2

train_x <- data[,c(4, 5)]
train_x

train_y <- data[,c(3)]
train_y

kSize_1 <- floor(sqrt(nrow(data)))
kSize_1 <- ifelse(kSize_1 %% 2 == 0, kSize_1 + 1, kSize_1)
kSize_1

knnPred_1 <- knn(train = train_x, test = test_x, cl = train_y, k = kSize_1, prob = T)
knnPred_1

