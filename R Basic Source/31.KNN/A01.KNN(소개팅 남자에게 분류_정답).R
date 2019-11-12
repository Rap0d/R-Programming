# 최근접 이웃(Nearest Neighbors)을 사용한 데이터 분류(Classification)
## 컬럼 : "말이 많은 정도","책을 좋아하는 정도","여행을 좋아하는 정도",학교성적,키,"피부가 좋은 정도","근육질의 정도",호감LABEL

likelyhood <- read.csv("likelyhood.csv", stringsAsFactors = FALSE)
str(likelyhood)
dim(likelyhood)
colnames(likelyhood)

library(class)

# likelyhood 컬럼(8번째)은 종속 변수
train_x <- likelyhood[c(1:13), -8]
train_x # 훈련용 입력

train_y <- likelyhood[c(1:13), 8]
train_y # 훈련용 출력

test_x <- likelyhood[c(14:14),-8]
test_x # 점검용 입력

test_y <- likelyhood[c(14:14),8]
test_y # 점검용 출력

k_size_1 <- ceiling(sqrt(nrow(likelyhood)))
k_size_1

knnpred1 <- knn(train=train_x, test=test_x, cl=train_y, k=k_size_1, prob = F)
knnpred1

table(knnpred1, test_y)
