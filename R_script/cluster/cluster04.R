data <- read.csv('interview.csv', header = T)

data$합격여부2[data$합격여부 == '합격'] <- 1
data$합격여부2[data$합격여부 == '불합격'] <- 0

data <- data[,-9]

dist <- dist(data[,-1])
hc <- hclust(dist)

plot(hc)

rect.hclust(hc, k = 3, border = c('red', 'blue', 'green'))

group1 <- subset(data, no %in% (c(9, 3, 11, 5, 14) + 100))
group2 <- subset(data, no %in% (c(13, 2, 6, 1, 4) + 100))
group3 <- subset(data, no %in% (c(15, 8, 10, 7, 12) + 100))

group1[2:9]
group2[2:9]
group3[2:9]

ghc <- cutree(hc, k = 3)
ghc

data$ghc <- ghc
data
