############################################################
# 쿠폰 01.기본 기술 통계 분석
############################################################
# 해당 데이터 파일(csv 파일)을 로딩한다.
mycoupon <- read.csv("mycoupon.csv", header=T)

head(mycoupon) # 데이터 정보를 조회한다.
tail(mycoupon)
View(mycoupon)

# 데이터 파일에 대한 내부 구조 정보를 조회한다.
str(mycoupon)

summary(mycoupon)
############################################################
# 쿠폰 02.쿠폰 유형 기술 통계 분석
############################################################
mycoupon$coupon
mycoupon$coupon2 <- factor(mycoupon$coupon,
	levels=c(1, 2),
	labels=c("할인_쿠폰", "적립_쿠폰"))

coupon02 <- table(mycoupon$coupon2)
coupon02 

prop.table( coupon02 )

plot(mycoupon$coupon2, xlab="쿠폰 유형", ylab="샘플 갯수", 
	main="쿠폰 유형별 갯수", ylim=c(0, 70), col=rainbow(2))

# 파일 이름 : 쿠폰 유형별 갯수.png
############################################################
# 쿠폰 03.쿠폰 사용 분야 기술 통계 분석
############################################################
mycoupon$category

mycoupon$category2 <- factor(mycoupon$category,
				levels=c(1, 2, 3, 4),
				labels=c("food", "beauty", "travel", "park"))

mycatetable02 <- table(mycoupon$category2)
addmargins(mycatetable02) 

myproptable02 <- prop.table(mycatetable02)
pctproptable02 <- round(myproptable02, 2)
addmargins( pctproptable02 )

plot(mycoupon$category2, xlab="사용처", ylab="사용 빈도", 
     main="쿠폰 사용처", col=rainbow(4), ylim=c(0, 30))
