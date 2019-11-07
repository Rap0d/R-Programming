library(devtools)
library(nnet)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

data <- read.csv('somedata.csv')
str(data)
summary(data)
dim(data)

model <- nnet(y ~ ., data, size = 10)

plot.nnet(model)

model

attributes(model)
model$n
model$fitted.values >= 0.5
# [,1]
# 1  TRUE
# 2  TRUE
# 3  TRUE
# 4 FALSE
# 5 FALSE
# 6 FALSE

pred <- predict(model, data, type = 'class')
pred

table(pred, data$y)
