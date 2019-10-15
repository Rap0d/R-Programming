library(ggplot2)
library(dplyr)

filename = 'welfare.csv'
welfare <- read.csv(filename, header=T)
head(welfare)

class(welfare$gender) # "integer"
table(welfare$gender)
unique(welfare$gender)

welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)

table(is.na(welfare$gender))

welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female')
table(welfare$gender)
unique(welfare$gender)

mydata <- as.data.frame(table(welfare$gender))
colnames(mydata) <- c('성별', '빈도수')

ggplot(mydata, aes(x=성별, y=빈도수, color=성별, fill=성별)) + geom_bar(stat='identity')

class(welfare$income)
range(welfare$income) 
summary(welfare$income) # 12030 
table(is.na(welfare$income))

qplot(welfare$income, bins=50)

qplot(welfare$income, bins=50) + xlim(0, 1000)

# 값이 0이거나, 9999이면 결측치로 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

summary(welfare$income) # 12044

# 소득(income)이 있는 사람들 중에서 그룹핑 --> 평균 급여
gender_income <- welfare %>% filter(!is.na(income)) %>% group_by(gender) %>% summarise(mean_income = mean(income))
mode(gender_income) # "list"
class(gender_income) # "data.frame"

gender_income

ggplot(data=gender_income, aes(x=gender, y=mean_income, color=gender, fill=gender)) + geom_col() + labs(x='성별', y='평균 급여', title='성별 월급 평균')

colnames(welfare)
#  나이와 월급의 관계
class(welfare$birth)
summary(welfare$birth)

qplot(welfare$birth, bins=30)

welfare$age <- 2015 - welfare$birth + 1
range(welfare$age)
summary(welfare$age)

qplot(welfare$age, bins=30)

age_income <- welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income = mean(income))

ggplot(data=age_income, aes(x=age, y=mean_income)) + geom_line()
