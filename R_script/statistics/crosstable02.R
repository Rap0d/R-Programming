myCp <- read.csv('mycoupon.csv', header = T)

unique(myCp$category)

# 코딩 변경
myCp$category2 <- factor(myCp$category, levels = c(1, 2, 3, 4), labels = c('food', 'beauty', 'travel', 'park'))

mCateTable <- table(myCp$category2)

par(family = 'AppleGothic')
barplot(mCateTable, ylim = c(0, 25), col = rainbow(nrow(mCateTable)), main = '쿠폰 사용 분야별 인원수', xlab = '사용분야', ylab = '인원수', beside = T)

# 쿠폰 종류에 따른 사용 분야 : 교차 분할표
unique(myCp$coupon)

myCp$coupon2 <- factor(myCp$coupon, levels = c(1, 2), labels = c('할인쿠폰', '적립쿠폰'))
tableGroup2 <- table(myCp$coupon2, myCp$category2)
tableGroup2

# 행방향으로 비율
pctGroup <- prop.table(tableGroup2, 1)
pctGroup

# 소숫점 2자리 까지 표시
roundPctGroup <- round(pctGroup, 2)
roundPctGroup

mFrame <- data.frame(tableGroup2)
barplot(roundPctGroup, beside = T)
mFrame
ggplot(mFrame, aes(x = Var2, y = Freq, fill = Var1, col = Var1)) + geom_col(position = 'Dodge') + theme_minimal(base_family = 'AppleGothic')
