# 분석 04 : 연령대에 따른 월급 차이
library(ggplot2)
library(dplyr)

welfare <- read.csv('welfare.csv', header=T)
welfare

colnames(welfare)
head(welfare)

welfare$age <- 2015 - welfare$birth + 1
range(welfare$age)

# 청년_young(30세 미만), 중년_middle(30세 이상), 노년_old(60세 이상)
# ageg : age generation 
welfare <- welfare %>% 
    mutate(ageg=ifelse(age < 30, 'young', 
                  ifelse(age >= 60, 'old', 'middle')))

head(welfare[c('age', 'ageg')], 10)
class(welfare$ageg)

unique(welfare$ageg)
table(welfare$ageg)
# middle    old  young
# 6049   6281   4334

# 연령대별 빈도수.png
chartdata <- as.data.frame(table(welfare$ageg))
colnames(chartdata) <- c('연령대', '빈도수')
ggplot(chartdata, aes(x=연령대, y=빈도수, col=연령대, fill=연령대)) + 
	geom_bar(stat='identity') + labs(title='연령대별 빈도수') + 
	scale_x_discrete(limits=c('young', 'middle', 'old'))

# 연령대별 평균 소득
# 소득이 있는 사람들 중에서 연령대별로 그룹핑하여
# 평균 소득을 구하기
ageg_income <- welfare %>% filter(!is.na(income)) 
	%>% group_by(ageg) 
	%>% summarise(mean_income = mean(income))

ageg_income

# help(scale_x_discrete) : 이산량에 대한 포지셔닝
# scale_x_discrete 함수의 limits 옵션으로 순서를 사용자 정의 순서로 바꿀 수 있다.
ggplot(data=ageg_income, aes(x=ageg, y=mean_income, col=ageg, fill=ageg)) 
	+ geom_col() + labs(title='연령대별 평균 급여') 
	+ scale_x_discrete(limits=c('young', 'middle', 'old'))
# 연령대별 평균 월급.png