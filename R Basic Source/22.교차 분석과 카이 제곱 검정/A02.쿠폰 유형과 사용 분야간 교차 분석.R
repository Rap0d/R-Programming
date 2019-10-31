# 해당 데이터 파일(csv 파일)을 로딩한다.
mycoupon <- read.csv("mycoupon.csv", header=T)

mycoupon$category2 <- factor(mycoupon$category,
                levels=c(1, 2, 3, 4),
                labels=c("food", "beauty", "travel", "park"))

mycatetable <- table(mycoupon$category2)
mycatetable
#   food beauty travel   park
#     24     21     18     19

# category 변수 그래프 그리기
myylimit = c(0, 25)
mycolor = rainbow(length(mycatetable))
mychart1 = barplot( mycatetable , beside=T, main="쿠폰 사용 분야별 인원수",
    xlab="쿠폰 사용 분야", ylab="인원수", ylim = myylimit, col=mycolor )
 # 쿠폰 사용 분야별 인원수.png

mycoupon$coupon2 <- factor(mycoupon$coupon, levels=c(1, 2), labels=c("할인_쿠폰", "적립_쿠폰"))
mycoupon$coupon2

# 쿠폰 유형(coupon)별 사용 분야(category) 분석
twogrouptable <- table(mycoupon$coupon2, mycoupon$category2)

twogrouptable
#             food beauty travel park
#   할인_쿠폰    8     11     11   13
#   적립_쿠폰   16     10      7    6

addmargins(twogrouptable)
#             food beauty travel park Sum
#   할인_쿠폰    8     11     11   13  43
#   적립_쿠폰   16     10      7    6  39
#   Sum         24     21     18   19  82

# 분할표에 있는 유형에 대한 비율을 구한다.
pccgroup <- prop.table(twogrouptable, 1)

pccgroup
#            food      beauty   travel      park
#   할인_쿠폰 0.1860465 0.2558140 0.2558140 0.3023256
#   적립_쿠폰 0.4102564 0.2564103 0.1794872 0.1538462

roundccgroup <- round(pccgroup, 2)

addmargins( roundccgroup )
#            food beauty travel park  Sum
#   할인_쿠폰 0.19   0.26  0.26 0.30 1.01
#   적립_쿠폰 0.41   0.26  0.18 0.15 1.00
#   Sum     0.60   0.52  0.44 0.45 2.01

mycolor = rainbow( length(na.omit(unique(mycoupon$category2)))  )
# 쿠폰 유형(coupon)별 사용 분야(category) 그래프 그리기
plot(mycoupon$coupon2, mycoupon$category2, xlab="쿠폰 유형",
    ylab="사용 분야", main="쿠폰 유형별 사용 분야", las=2, col=mycolor)

# 쿠폰 유형별 사용 분야.png
