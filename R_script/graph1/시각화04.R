data <- read.csv('R_data/191015/야구성적.csv', header = T)
dim(data)
colnames(data)
str(data)

par(family = 'D2Coding', cex = 0.5)

chartdata <- data$연봉대비출루율
chartdata
range(chartdata)

mycolor <- rainbow(50)
xlabel <- data$선수명

barinfo <- barplot(chartdata, main = '연봉 대비 출루율\n밥값 여부 계산', col = mycolor, names.arg = xlabel, las = 2, ylim = c(0, 50))

barinfo

title(ylab = '연봉 대비 출루율', col.lab = 'red')
title(xlab = '선수명', col.lab = 'blue')

aver <- mean(data$연봉대비출루율)

abline(h = aver, col = 'red', lty = 'dotted')

text(x = 3, y = aver + 1, col = 'black', labels = paste(round(aver, 2), '%(평균 출루율)'))

text(x = barinfo * 1.01, y = chartdata + 1, col = 'black', labels = paste(chartdata, '%'))

# 홈런 개수가 평균 홈런 개수보다 많은 선수들의 막대 그래프 
avghr <- mean(data$홈런)
data2 <- data[c('선수명', '홈런')]
library(dplyr)
res <- filter(data2, 홈런 >= avghr)
res
xname <- res$선수명

avginfo <- barplot(res$홈런, main = '평균 홈런 개수보다 많은 선수', col = mycolor, names.arg = xname, las = 2, ylim = c(0, 50))

abline(h = avghr, col = 'blue', lty = 'dotted')