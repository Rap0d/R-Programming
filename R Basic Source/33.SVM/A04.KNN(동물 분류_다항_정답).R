zoo <- read.csv("zoo_data2.csv" , header=T , stringsAsFactors = F)
str(zoo)
dim(zoo) 

animals <- c('고양이' , '강아지' , '너구리' , '토끼' , '참새' , '제비' , '곰')

len <- length(unique(zoo$type))
for(idx in 1:len){
  zoo$type2[zoo$type == (idx-1)] <- animals[idx]
}

zoo$type2 <- as.factor(zoo$type2)
colnames(zoo[-17])
training <- zoo[-17]
colnames(training)

testing <- read.csv("zoo_testing2.csv" , header=T , stringsAsFactors = F)
str(testing)
dim(testing)

len <- length(unique(testing$type))
for(idx in 1:len){
  testing$type2[testing$type == (idx-1)] <- animals[idx]
}

testing$type2 <- as.factor(testing$type2)
colnames(testing[-17])
testing <- testing[-17]

# install.packages('kernlab')
library(kernlab)

# model <- ksvm(type2 ~ ., data = training, kernel = "vanilladot")
model <- ksvm(type2 ~ ., data = training, kernel = "rbfdot")

predictions <- predict(model, testing)

head(predictions)

table(predictions, testing$type2)

agreement <- predictions == testing$type2

table(agreement)

prop.table(table(agreement)) 
