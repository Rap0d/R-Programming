dataset <- read.csv('dataset.csv', header = T)
dataset

sum(dataset$price, na.rm = T)

price2 <- na.omit((dataset$price))
sum(price2)
length(price2)

# 기본 값을 0이라고 가정하고, 0으로 치환
dataset$price2 <- ifelse(!is.na(dataset$price), dataset$price, 0)

# 결측치를 비결측치의 평균으로 대체하기
mean_price <- round(mean(dataset$price, na.rm = T), 2)
dataset$price3 <- ifelse(!is.na(dataset$price), dataset$price, mean_price)

# 결과
dataset[c('price', 'price2', 'price3')]

# 이상치 보정
gender <- dataset$gender
table(gender)
pie(table(gender))

dataset <- subset(dataset, gender == 1 | gender == 2)
nrow(dataset)

dataset <- read.csv('dataset.csv', header = T)
dataset
length(dataset$price)
plot(dataset$price)

mybox <- boxplot(dataset$price)
mybox$stats

dataset2 <- subset(dataset, dataset$price > 2.1 & dataset$price < 7.9)
length(dataset2$price)

sort(dataset2$price)

# stem : 왼쪽 열이 1단위 / 오른쪽 열이 .단위의 갯수
stem(dataset2$price)

summary(dataset$age)
