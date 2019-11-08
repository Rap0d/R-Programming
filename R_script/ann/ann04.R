library(devtools)
library(party)
library(nnet)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

# setwd('R Basic Source/28.인공 신경망')

data <- read.csv('department_store.csv')
testing <- read.csv('department_testing.csv')

head(data)

mFormula <- card ~ .

model <- nnet(formula = mFormula, data = data, size = 10)
model

# plot.nnet(model)

model$fitted.values >= 0.5

pred <- predict(model, testing, type = 'class')
pred
