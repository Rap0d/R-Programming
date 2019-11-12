
data <- read.csv('bodycheck.csv', header = T)
head(data)

data_dist <- dist(data[, -1])

hc <- hclust(data_dist)
hc
plot(hc)

# 분류
rect.hclust(hc, k = 3, border = c('red', 'blue', 'yellow'))

# 군집별 특성
group1 <- subset(data, 번호 == 10 | 번호 == 4 | 번호 == 8 | 번호 == 1 | 번호 == 15)
group2 <- subset(data, 번호 == 11 | 번호 == 3 | 번호 == 5 | 번호 == 6 | 번호 == 14)
group3 <- subset(data, 번호 == 2 | 번호 == 9 | 번호 == 13 | 번호 == 5 | 번호 == 12)

group1[2:5]
group2[2:5]
group3[2:5]

summary(group1[2:5])
summary(group2[2:5])
summary(group3[2:5])

ghc <- cutree(hc, k = 3)
ghc

data$ghc <- ghc
