dataset <- read.csv('dataset.csv', header = T)
dataset

str(dataset)

names(dataset)

attributes(dataset)

x <- dataset$gender
y <- dataset$price

plot(x, y)
plot(y)

dataset['gender']
dataset[2]
dataset[3,]
dataset[,3]

dataset[c('job', 'price')]
dataset[c(1:3)]
dataset[-c(1:100)]

sort(unique(dataset$resident))
range(dataset$age, na.rm = T)
