# 나이와 월급의 상관 관계

library(ggplot2)

getwd()
setwd('../../R_script/largedata/')
setwd('Documents/_2_WorkSpace/_2_R-Programming/R-Programming/R_data/191023/')
welfare <- read.csv('welfare.csv')

# 태어난 연도 히스토그램
qplot(welfare$birth, bins = 30)

# 나이 컬럼 생성(2015년 기준자료)
age <- 2015 - welfare$birth + 1
welfare$age <- age
summary(age)

# 나이 히스토그램
qplot(welfare$age, bins = 30)

# 월급 
age_income <- welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income = mean(income))
age_income

# geon_line : 꺾은선 그래프
ggplot(data = age_income, aes(x = age_income$age, y = age_income$mean_income)) + geom_line()+ labs(title = 'Age and Income')
