# install.packages('ggplot2')
library(ggplot2)
library(stringr)

help(options)
# 큰 숫자인 경우 e+05 형식 없애는 옵션
options(scipen = 25)

china_file <- '중국_방문객_정보.json'
china_visit <- fromJSON(china_file)
newdata <- china_visit[c('yyyymm', 'visit_cnt')]

newdata$mm <- str_sub(newdata$yyyymm, 5, 6) # 월만 추출하기
newdata$visit_cnt <- as.integer(newdata$visit_cnt)
colnames(newdata) <- c('년월', '방문자수', '월')
newdata

newdata$월 <- str_c(newdata$월, '월') 
# mycolor <- 'lightblue'
mycolor <- rainbow(nrow(newdata))
mycolor

ggplot(newdata, aes(x=월, y=방문자수)) + geom_bar(stat='identity', fill=mycolor, colour=mycolor) + ggtitle('월별 방문자수', substitute('2017년도 중국인 방문자수입니다.')) + theme(plot.title = element_text(hjust=0.5))
# 2017년 중국인 방문자수.png