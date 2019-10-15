welfare <- read.csv('welfare.csv', header=T)
welfare
colnames(welfare)

welfare$age <- 2015 - welfare$birth + 1

range(welfare$age)

library(dplyr)

# ageg : age generation 
welfare <- welfare %>% mutate(ageg = ifelse(age < 30, 'young', ifelse(age >= 60, 'old', 'middle')))

unique(welfare$ageg)
table(welfare$ageg)

library(ggplot2)

chartdata <- as.data.frame(table(welfare$ageg))
colnames(chartdata) <- c('연령대', '빈도수')
ggplot(chartdata, aes(x=연령대, y=빈도수, col=연령대, fill=연령대)) +  geom_bar(stat='identity') + labs(title='연령대별 빈도수') + scale_x_discrete(limits=c('young', 'middle', 'old'))

# 연령대별 평균 소득
ageg_income <- welfare %>% filter(!is.na(income)) %>% group_by(ageg) %>% summarise(mean_income = mean(income))

ageg_income

ggplot(data=ageg_income, aes(x=ageg, y=mean_income, col=ageg, fill=ageg)) + geom_col() + labs(title='연령대별 평균 급여') + scale_x_discrete(limits=c('young', 'middle', 'old'))








