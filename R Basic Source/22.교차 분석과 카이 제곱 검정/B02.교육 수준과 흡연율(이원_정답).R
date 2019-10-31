# 귀무 가설 '교육의 수준과 흡연율은 연관성이 없다.'
smoke <- read.csv("smoke.csv", header=TRUE)
head(smoke)
unique(smoke$education) # [1] 1 2 3
unique(smoke$smoke) # [1]  1  2  3 NA

# 코딩 변경(변수 리코딩)
# education(독립변수) : 1:대졸, 2:고졸, 3:중졸
# smoke(종속변수): 1:과다흡연, 2:보통흡연, 3:비흡연
smoke$education2[smoke$education==1] <- "1.대졸"
smoke$education2[smoke$education==2] <- "2.고졸"
smoke$education2[smoke$education==3] <- "3.중졸"
smoke$smoke2[smoke$smoke==1] <- "1.과대흡연"
smoke$smoke2[smoke$smoke==2] <- "2.보통흡연"
smoke$smoke2[smoke$smoke==3] <- "3.비흡연"

# 교차 분할표 작성
mytable <- table(smoke$education2, smoke$smoke2)
mytable
# 1.과대흡연 2.보통흡연 3.비흡연
# 1.대졸        305        324      300
# 2.고졸        550        200      300
# 3.중졸        517        139      365

# 독립성 검정
addmargins(mytable)

library(ggplot2)

myframe <- as.data.frame( mytable )
colnames(myframe) <- c('학력', '흡연여부', '빈도수')
myframe

ggplot(data=myframe, aes(x=학력, y=빈도수, fill=흡연여부)) + geom_col(position = 'dodge2') + scale_x_discrete(limits=c('3.중졸','2.고졸','1.대졸'))

# install.packages('gmodels')
library(gmodels) # CrossTable() 함수 사용
CrossTable(smoke$education2, smoke$smoke2, chisq = TRUE)

# 검정 결과 해석
# 검정 결과 유의 확률 p-value의 값이 2.090326e-34 이므로 
# 귀무 가설을 기각한다./채택할 수 없다.
# 따라서, '교육의 수준과 흡연율은 연관성이 있다.'라고 볼 수 있다.

# Statistics for All Table Factors
#
# Pearson's Chi-squared test
# ------------------------------------------------------------
# Chi^2 =  163.9381     d.f. =  4     p =  2.090326e-34
