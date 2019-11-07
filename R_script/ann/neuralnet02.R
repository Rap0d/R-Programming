library(neuralnet)

normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

data <- read.csv('R Basic Source/28.인공 신경망/concrete.csv')
head(data)
summary(data)
str(data)
dim(data)

# Normalization 
conNorm <- as.data.frame(lapply(data, normalize))
head(conNorm)
summary(conNorm)

idx <- sample(1:nrow(data), 0.7 * nrow(data))

training <- conNorm[idx, ]
testing <- conNorm[-idx, ]

mFormula <- strength ~ .
model <- neuralnet(formula = mFormula, data = training, hidden = rep(5,5))
model

plot(model)

colnames(testing)
testingX <- testing[1:8]
modelRes <- compute(model, testingX)
pred <- modelRes$net.result

# 회귀는 수치 값 예상이므로 상관 계수로 평가
cor(pred, testing$strength)

model2 <- neuralnet(formula = mFormula, data = training, hidden = c(2,3))
model2

# plot(model2)

colnames(testing)
testingX <- testing[1:8]
modelRes2 <- compute(model2, testingX)
pred2 <- modelRes2$net.result
cor(pred2, testing$strength)

