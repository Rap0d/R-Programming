spam <- read.csv("spam_filter.csv" , header = T)
spam
colnames(spam)
str(spam)

# install.packages('e1071')
library(e1071)

training <- spam[c(1:16), ]
training

testing <- spam[c(17:nrow(spam)), ]
testing

model <- naiveBayes(메일종류~., data=training, laplace = 0)
model

pred <- predict(model, testing[c(1:12)])
pred

table(예측=pred, 정답=testing$메일종류)