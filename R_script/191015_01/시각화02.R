setwd('R_data/191015/')
baseball <- read.csv('kbo.csv')
baseball
str(baseball)
dim(baseball)

par(family = 'D2Coding')

avg <- baseball$AVG
hr <-baseball$HR

# 산점도(scatter plot)
# lab : label
# lim : limit(하한, 상한)
plot(x = avg, y = hr, main = 'scatter plot', xlab = '타율', ylab = '홈런', xlim = c(0.30, 0.38), ylim = c(0, 45))

meanhr <- mean(hr)

# abline : 선 긋기, a : y절편, b : 기울기
abline(a = meanhr, b = 0, col = 'blue')

# plot안에 text 넣어보기
text(x = 0.305, y = meanhr + 2, labels = '홈런 평균', col = 'blue')

meanavg <- mean(avg)

abline(v = meanavg, col = 'pink', lty = 4, lwd = 5)
text(x = meanavg + 0.005, y = 0, labels = '타율 평균', col = 'pink')

colnames(baseball)

R <- baseball$R
RBI <- baseball$RBI

plot(R, RBI, main = 'r and rbi', xlab = 'R', ylab = 'RBI', xlim = c(min(R) - 10, max(R) + 10), ylim = c(min(RBI) - 10, max(RBI + 10)))

meanrbi <- mean(RBI)
abline(a = meanrbi, b = 0, col = 'lightblue')
text(x = 55, y = meanrbi + 5, labels = '평균 RBI')
