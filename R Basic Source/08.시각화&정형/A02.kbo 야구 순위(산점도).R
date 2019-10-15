baseball <- read.csv('kbo.csv')
baseball
str(baseball)
dim(baseball)

avg <- baseball$AVG # 타율
hr <- baseball$HR # 홈런

# x, y를 이용하여 산점도 그래프 그리기
plot( x=avg, y=hr, main='batting average', xlab='타율', ylab='홈런', 
      col='red', xlim=c(0.30, 0.38), ylim=c(0, 45))

meanhr <- mean(hr)

abline(a=meanhr, b=0, col='blue')
# abline(h=meanhr, col='blue')

text(x=0.305, y=meanhr + 2, labels='홈런 평균')

# 타율의 평균을 수직선으로 그려보기
meanavg <- mean(avg)

# lty=2(dashed), 3(dotted), 
abline(v = meanavg, col='pink', lty=4, lwd=5)

colnames(baseball)

# 선수들의 R과 RBI를 이용하여 산점도 그리기
# 그래프의 상한 값 : 최대 값 + 10
# 그래프의 하한 값 : 최소 값 - 10
R <- baseball$R
RBI <- baseball$RBI

plot( R, RBI, main='r and rbi', xlab='R', ylab='RBI', col='blue', 
      xlim=c(min(R) - 10, max(R) + 10 ), ylim=c(min(RBI) - 10, max(RBI) + 10 ) )

meanrbi <- mean(RBI)
abline(a=meanrbi, b=0, col='lightblue')
text(x=55, y=meanrbi + 5, labels='평균 rbi')