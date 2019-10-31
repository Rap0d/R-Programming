library(Hmisc)
library(prettyR)

coupData <- read.csv('mycoupon.csv')

par(family = 'AppleGothic')

# 풀어 봅시다.
# ############################################################
# # 쿠폰 01.기본 기술 통계
# ############################################################
# 앞 6행만 보여 주세요.
head(coupData)
# 뒷 6행만 보여 주세요.
tail(coupData)
# View 함수를 이용하여 데이터를 조회해 보세요.
View(coupData)
# 데이터의 구조(structure)를 확인하세요.
str(coupData)
# 기초 요약 통계량 정보를 확인해보세요.
summary(coupData)
# ############################################################
# # 쿠폰 02.쿠폰 유형 기술 통계
# ############################################################
# coupon 정보를 조회해보세요.
coupData$coupon
# factor() 함수를 이용하여 할인 쿠폰/적립 쿠폰이라는 레이블을 새롭게 만들어 보세요.
coupData$coupType <- factor(coupData$coupon, levels = c('1', '2'), labels = c('할인쿠폰', '적립쿠폰'))
# 쿠폰 유형별 분할표를 만들어 보세요.
coupTypeTable <- table(coupData$coupType)
coupTypeTable
# 분할표에 있는 쿠폰들의 유형에 대한 비율을 구해보세요.(prop.table)
propCoupType <- prop.table(coupTypeTable)
propCoupType
# 쿠폰 유형별 갯수에 대한 막대 그래프를 그려 보세요.
barplot(coupTypeTable, col = rainbow(nrow(coupTypeTable)), main = '쿠폰 유형별 갯수')
# ############################################################
# # 쿠폰 03.쿠폰 사용 분야 기술 통계 
# ############################################################
# # category 컬럼 정보를 조회해보세요.
coupData$category
# factor() 함수를 이용하여 category2 컬럼을 생성하시오.
# # 1 : food, 2 : beauty, 3 : travel, 4 : park라고 가정한다.
coupData$cate2 <- factor(coupData$category, levels = seq(1:4), labels = c('food', 'beauty', 'travel', 'park'))
coupData$cate2
# category 유형별 분할표를 만들어 보세요.
coupCateTable <- table(coupData$cate2)
# addmargins() 함수를 이용하여 소계 컬럼을 추가해 보세요.
coupCateTable <- addmargins(coupCateTable)
coupCateTable
# 분할표에 있는 항목들에 대한 비율을 구해보세요.(prop.table)
propCate <- prop.table(coupCateTable)
propCate
# 쿠폰 사용처에 대한 막대 그래프를 그려 보세요.
barplot(coupCateTable, col = rainbow(nrow(coupCateTable)), ylim = c(0, 30), main = '쿠폰 사용처')
# ############################################################
# 참조 그림 : 쿠폰 사용처.png / 쿠폰 유형별 갯수.png