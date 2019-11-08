library(devtools)
library(party)
library(nnet)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

# setwd('R Basic Source/28.인공 신경망')

data <- read.csv('zoo_data.csv')
testing <- read.csv('zoo_testing.csv')

data$type2[data$type == 0] <- 'A'
data$type2[data$type == 1] <- 'B'
data$type2[data$type == 2] <- 'C'
data$type2[data$type == 3] <- 'D'
data$type2[data$type == 4] <- 'E'
data$type2[data$type == 5] <- 'F'
data$type2[data$type == 6] <- 'G'

testing$type2[testing$type == 0] <- 'A'
testing$type2[testing$type == 1] <- 'B'
testing$type2[testing$type == 2] <- 'C'
testing$type2[testing$type == 3] <- 'D'
testing$type2[testing$type == 4] <- 'E'
testing$type2[testing$type == 5] <- 'F'
testing$type2[testing$type == 6] <- 'G'

type.ind <- class.ind(data$type2)
data <- cbind(data, type.ind)
names(data)
xData <- data[,c(1:16)]
yData <- data[,c(19:25)]

model <- nnet(x = xData, y = yData, size = 10, softmax = T)
model

# plot(model)
xTest <- testing[,c(1:16)]
pred <- predict(model, xTest, type = 'class')
pred

mTable <- table(pred, testing$type2)
mTable

acc <- (mTable[1,1] + mTable[2,2] + mTable[3,3] + mTable[4,4] + mTable[5,5] + mTable[6,6] + mTable[7,7]) / sum(mTable)
round(100 * mean(acc), 4)