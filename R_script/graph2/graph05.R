getwd()
setwd('../R-Programming/R_data/191016/seoul_hospital/')

par(family = 'D2Coding')
par(cex = 0.7)
library(reshape2)
library(stringr)
library(dplyr)

getColor <- function(x) {
  mcolor <- rainbow(length(x))
  return (mcolor)
}
getPercent <- function(x) {
  res <- round(x/sum(x) * 100, 2)
  return (res)
}

filename = '2013_seoul_hospital.csv'

fullData <- read.csv(filename, header = T)
fullData

mcolnames <- fullData$표시과목
mcolnames

# 강서구 & 구로구 병원 현황
data1 <- as.matrix(data.frame(강서구 = fullData$강서구, 구로구 = fullData$구로구))
data1

barplot(data1, beside = T, col = getColor(mcolnames), legend = mcolnames, ylim = c(0, 50))

# 마포구 병원 현황 비율.png
data2 <- fullData$마포구
data2
pc <- getPercent(data2)
lbls <- paste(mcolnames, '\n', pc, '%')

pie(data2, labels = lbls, col = getColor(mcolnames))

# 병원현황02.png
par(mfrow = c(2,5))

data3 <- fullData[2:length(fullData)]
data3

for(idx in colnames(data3)) {
  barplot(data3[,idx], col = getColor(mcolnames), main = idx)
}

# 꺽은 선 그래프.png
par(mfrow = c(1,1))

data4 <- fullData[2:length(fullData)]
data4
mcolor2 <- rainbow(10)
mcolor2
par(cex = 0.7)

v <- c(1:length(colnames(data4)))

for(idx in v) {
  plot(data3[,idx], col = mcolor2[idx], type = 'o', axes = F, ylim = c(0, 350), xlab = '', ylab = '', cex = 0.7)
  par(new = T)
}

axis(side = 1, at = 1:length(mcolnames), label = mcolnames)
axis(side = 2, ylim = c(0, 350))
mcolor2
legend('topright', colnames(data4), cex = 1, col = mcolor2, bg = 'white', lty = 1, lwd = 3)
par(new = F)

# hospital01.png

data4

barplot(as.matrix(data4), beside = T, legend = mcolnames, col = getColor(data4), ylim = c(0, 350))

