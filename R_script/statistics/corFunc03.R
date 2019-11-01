library(corrplot)
testData <- read.csv('시험 점수와 공부 시간1.csv')

res1 <- cor(testData)
res1

mode(res1)
class(res1)

round(res1, 3)

par(family = 'AppleGothic')
corrplot(res1, method = 'ellipse', addCoef.col = 'red')

testData2 <- read.csv('시험 점수와 공부 시간2.csv')

res2 <- cor(testData2)
par(family = 'AppleGothic')
corrplot(res2, method = 'ellipse', addCoef.col = 'red')

