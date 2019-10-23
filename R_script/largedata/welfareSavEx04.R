# 연령대에 따른 월급 차이

library(ggplot2)

welfare <- read.csv('welfare.csv')

# 나이 컬럼 생성(2015년 기준자료)
welfare$age <- 2015 - welfare$birth + 1

mAge <- welfare$age

range(mAge)

# 연령대 나누기
welfare <- welfare %>% mutate(age_group = ifelse(mAge < 30, 'young', ifelse(mAge < 60, 'mid', 'old')))

head(welfare[c('age', 'age_group')])

unique(welfare$age_group)
table(welfare$age_group)

chart1 <- as.data.frame(table(welfare$age_group))
colnames(chart1) <- c('AgeGroup', 'Freq')

# scale_x_discrete : x 축 순서
ggplot(data = chart1, aes(x = AgeGroup, y = Freq, col = AgeGroup, fill = AgeGroup)) + geom_bar(stat = 'identity') + scale_x_discrete(limits = c('young', 'mid', 'old'))

age_group_income <- welfare %>% filter(!is.na(income)) %>% group_by(age_group) %>% summarise(mean_age_group_income = mean(income))

ggplot(data = age_group_income, aes(x = age_group, y = mean_age_group_income, fill = age_group, col = age_group)) + geom_bar(stat = 'identity')
