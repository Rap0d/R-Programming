mushrooms <- read.csv("mushrooms.csv", header=TRUE, stringsAsFactors = FALSE)
dim(mushrooms)
colnames(mushrooms)

mushrooms$type <- factor(mushrooms$type)
str(mushrooms$type)
unique(mushrooms$type)
table(mushrooms$type)

set.seed(1234)
idx <- sample(1:nrow(mushrooms), 0.7*nrow(mushrooms))
training <- mushrooms[idx, ]
testing <- mushrooms[-idx, ]

# install.packages('e1071')
library(e1071) 
# model <- naiveBayes(formula = type ~ ., data = mushrooms)
model <- naiveBayes(formula = type ~ ., data = mushrooms, laplace = 0.1 )

# 학습된 나이브 베이즈 모델로 예측
pred <- predict(model, testing)
attributes(pred)
head(pred)

# 정 분류율 및 오 분류율 계산
# 정오 분류표(confusion matrix) 작성
mytable <- table(pred, testing$type)
mytable            

#정분류율
accuracy <- sum(mytable[row(mytable) == col(mytable)])/sum(mytable) 
accuracy # [1] 0.9433962