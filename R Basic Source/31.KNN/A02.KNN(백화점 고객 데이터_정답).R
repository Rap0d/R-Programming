# 최근접 이웃(Nearest Neighbors)을 사용한 데이터 분류(Classification)
## 컬럼 : 나이, 수입, 구매여부

saleinfo <- read.csv("saleinfo.csv", stringsAsFactors = FALSE)
saleinfo$age <- scale(saleinfo$나이)
saleinfo$income <- scale(saleinfo$월급)

str(saleinfo)
dim(saleinfo)
colnames(saleinfo)

library(class)

train_x <- saleinfo[,c(4, 5)]
train_x # 훈련용 입력

train_y <- saleinfo[,3]
train_y # 훈련용 출력

test_x <- data.frame(age=44, income=400)
test_x$age <- (test_x$age - mean(saleinfo$나이)) / sd(saleinfo$나이)
test_x$income <- (test_x$income - mean(saleinfo$월급)) / sd(saleinfo$월급)
test_x # 점검용 입력

knnpred1 <- knn(train=train_x, test=test_x, cl=train_y, k=5, prob = T)
knnpred1

knnpred2 <- knn(train=train_x, test=test_x, cl=train_y, k=6, prob = T)
knnpred2
