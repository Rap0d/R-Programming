person <- read.csv("personinfo.csv" , header = T)
colnames(person)
str(person)
person

person$age2[ person$age >= 10 & person$age < 20] <- '10대'
person$age2[ person$age >= 20 & person$age < 30] <- '20대'
person$age2[ person$age >= 30 & person$age < 40] <- '30대'
person$age2[ person$age >= 40 & person$age < 50] <- '40대'

person$age2 <- as.factor(person$age2)

person$age <- NULL # age 컬럼 없애기

training <- person[c(1:30), ]
training

testing <- person[c(31:nrow(person)), ]
testing

# install.packages('e1071')
library(e1071)

model <- naiveBayes(type~., data=training, laplace = 0)
# model <- naiveBayes(type~., data=training, laplace = 0.1)
model

# pred <- predict(model, training[c(1:5)])
pred <- predict(model, testing[c(1:5)])
pred

# table(예측=pred, 정답=training$type)
table(예측=pred, 정답=testing$type)
