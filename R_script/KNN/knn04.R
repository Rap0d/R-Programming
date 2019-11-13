library(ggplot2)
library(class)
library(dplyr)

data <- read.csv('food_list.csv', header = T)
head(data)
str(data)
summary(data)
dim(data)
colnames(data)
rownames(data)

tomato <- data.frame(ingredient = 'tomato', sweetness = 6, crunchiness = 4)

ggplot(data = data, aes(x = sweetness, y = crunchiness)) + geom_point(aes(color = class, shape = class), size = 5)

# k = 1로 테스트
trainX <- select(data, sweetness, crunchiness)
testX <- select(tomato, sweetness, crunchiness)
trainY <- data$class

tmt <- knn(train = trainX, test = testX, cl = trainY, k = 1, prob = T)
tmt

# 여러 항목 같이 확인하기(k = 3)
ingredient <- c('grape', 'green bean', 'orange', 'tomato')
sweetness <- c(8, 3, 7, 6)
crunchiness <- c(5, 7, 3, 4)

unknown <- data.frame(ingredient, sweetness, crunchiness)
unknown

testX <- unknown[, c('sweetness', 'crunchiness')]
res <- knn(train = trainX, test = testX, cl = trainY, k = 3, prob = T)
res
