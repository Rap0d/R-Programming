# stringsAsFactors = F : 문자열을 chr 형식으로 읽어 들이기
customers <- read.csv("customers.csv" , stringsAsFactors = F , header = T)
str(customers)

library(class) 
train <- customers[,-5]
train

label <- customers[,5]
label

# k=3으로 테스트
knnpred1 <- knn(train=train , test=train , cl=label , k=3 , prob=TRUE) 
knnpred1

table(knnpred1 == label)
sum(knnpred1 == label)/NROW(knnpred1 == label)*100

# k=4으로 테스트
knnpred2 <- knn(train=train , test=train , cl=label , k=4 , prob=TRUE) 
knnpred2

table(knnpred2 == label)
sum(knnpred2 == label)/NROW(knnpred2 == label)*100

test <- data.frame(아침=12 , 점심=20 , 저녁=50 , 주말=91)
knnpred3 <- knn(train , test , label , k=3 , prob=TRUE) 
# knnpred3 <- knn(train , test , label , k=3 , prob=FALSE) 
knnpred3
