# K 군집 분류

library(ggplot2)
library(corrgram)

nrow(diamonds)

idx <- sample(1:nrow(diamonds), 800)

# idx <- sample(1:nrow(diamonds), 0.7 * nrow(diamonds))

# training <- diamonds[idx,]
test <- diamonds[idx,]

dim(test)

data <- test[c('price', 'carat', 'depth', 'table')]

# ave : 평균 견적
hc <- hclust(dist(data), method = 'ave')
plot(hc)

km <- kmeans(data, centers = 7)
attributes(km)

data$cluster <- km$cluster
head(data)

refcol <- c('price', 'carat', 'depth', 'table')
cor(data[,refcol])

plot(data[,refcol])

corrgram(data[,refcol], upper.panel = panel.conf)

# carat, price scatter plot
plot(data$carat, data$price, col = data$cluster)

# 중심점
points(km$centers[, c('carat', 'price')], col = c(1:nrow(km$centers)), pch = 8, cex = 5)
