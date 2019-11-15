mail <- read.csv("bayes_check.csv" , header = T)
mail
colnames(mail)
str(mail)

# install.packages('e1071')
library(e1071)

train_x <- mail[c(1:2), c(1:6)]
train_x

train_y <- mail[c(1:2), c(7:7)]
train_y

test_x <- mail[c(3:4), c(1:6)]
test_x

test_y <- mail[c(3:4), c(7:7)]
test_y

model <- naiveBayes(메일종류~., data=mail, laplace = 0)
model

pred <- predict(model, test_x)
pred

test_y

table(예측=pred, 정답=test_y)