getwd()
setwd('R Basic Source/06.data processing/')
data <- read.csv('mydata.csv', header=TRUE)
data

# 리코딩
# coupon ==> 1 : 할인쿠폰, 2 : 적립쿠폰
unique(data$coupon)

data$coupon2 <- factor(data$coupon, levels=c(1, 2), 
                       labels=c('할인쿠폰', '적립쿠폰'))

data$amount; data$coupon2

data

# tapply(a, b, func )
# b별로 그룹핑하여 a에 대하여 func 함수를 적용해주세요.
ta <- tapply(data$amount, data$coupon2, mean )
ta

barplot(ta, col=rainbow(2), main='쿠폰 유형별 사용 금액', 
        xlab='쿠폰 유형', ylab='평균 사용 금액')
# 파일 이름 : 쿠폰 유형별 평균 사용 금액.png


unique(data$gender)

data$gen2 <- factor(data$gender, levels = c('M', 'F'), labels = c('Male', 'Female'))
data$gen2

data$age

tg <- tapply(data$age, data$gen2, mean)
tg

barplot(tg, col=rainbow(2), main = '성별 유형별 나이의 평균', xlab = '성별', ylab = '나이')
