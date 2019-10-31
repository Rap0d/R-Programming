mycf <- read.csv("mycf.csv", header=TRUE)
str(mycf)
unique(mycf$group)
unique(mycf$interest)

mycf$group2 <- factor(mycf$group, levels=c(1, 2),
                      labels=c("연예인 CF", "일반인 CF"))

mycf$interest2 <- factor(mycf$interest, levels=c(1, 0),
                         labels=c("관심있음", "관심없음"))

# table() 함수를 이용하여 교차 분할표를 작성한다.
crosstable <- table(mycf$group2, mycf$interest2)

addmargins(crosstable)
#             관심있음 관심없음  Sum
#   연예인 CF     1339      150 1489
#   일반인 CF     1121      390 1511
#   Sum           2460      540 3000

# help(prop.table)
prop.table(crosstable, 1) # 행단위로 비율
prop.table(crosstable, 2) # 열단위로 비율

propct <- prop.table(crosstable, 1)

rpropct <- round(propct, 2) # 소수 2째자리까지 반올림
rpropct
#             관심있음 관심없음
#   연예인 CF     0.90     0.10
#   일반인 CF     0.74     0.26

addmargins(rpropct, 1)
#             관심있음 관심없음
#   연예인 CF     0.90     0.10
#   일반인 CF     0.74     0.26
#   Sum           1.64     0.36

myframe <- data.frame(crosstable)
myframe

library(ggplot2)
ggplot(myframe, aes(x=Var2, y=Freq, fill=Var1, color=Var1)) + geom_col(position='dodge') + labs(x='집단 유형', y='광고 관심도', title='집단 유형별 광고 관심도') + theme(plot.title = element_text(hjust=0.5))


# mycolor <- rainbow(2)
# barplot(crosstable, main="집단 유형별 광고 관심도", xlab="집단 유형",
#         ylab="광고 관심도", beside=TRUE, ylim=c(0, 1400), col=mycolor)
# 
# legend('topright', '', rownames(rpropct), fill=mycolor, cex=0.8, bg='white')
# 집단 유형별 광고 관심도.png
