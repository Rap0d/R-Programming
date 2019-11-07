library(neuralnet)

data <- read.csv('some.csv')

str(data)
head(data)
dim(data)

# scale() : 표준화 변환
# min-max 정규화 : 제일 큰 값을 1, 작은값을 0으로 만드는 정규화
# 10 20 30

normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

a <- data.frame(data = c(123,41,23,45,245,3,4))
lapply(a, normalize)

# norm : normalization
dataNorm <- as.data.frame(lapply(data, normalize))
dataNorm$y <- dataNorm$y2

dataNorm <- dataNorm[c('x', 'y')]
head(dataNorm)
summary(dataNorm)

# 3:1로 데이터 분리

trainRow <- round(0.75 * nrow(data))
training <- dataNorm[1:trainRow,]
testing <- dataNorm[(trainRow + 1):nrow(data),]

model <- neuralnet(formula = y ~ ., training, hidden = c(2,3,4))
model

plot(model)

modelRes <- compute(model, testing[1:1])
attributes(modelRes)

pred <- modelRes$net.result
pred

df <- data.frame(pred = pred, real = testing$y)

x <- seq(1 : length(pred))
plot(x = x, y = pred, type = 'n', xlab = '', ylab = 'value', ylim = c(0, 1))

points(x, pred, pch = 4, col = 'red')

points(x, testing$y, pch = 4, col = 'blue')

cor(pred, testing$y)
