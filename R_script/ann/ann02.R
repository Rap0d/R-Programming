library(devtools)
library(nnet)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

str(iris)
head(iris$Species)

species.ind <- class.ind(iris$Species)
iris <- cbind(iris, species.ind)
head(iris)

# 훈련 테스트 2:3
idx <- sample(1:nrow(iris), 2/3 * nrow(iris))
training <- iris[idx,]
testing <- iris[-idx,]

colnames(training)

x_data <- training[, c(1:4)]
y_data <- training[, c(6:8)]

# softmax : 다중 분류
model <- nnet(x = x_data, y = y_data, size = 30, softmax = T)

plot.nnet(model)
model

x_test <- testing[, c(1:4)]
pred <- predict(model, x_test, type = 'class')
head(pred)

table(pred, testing$Species)
