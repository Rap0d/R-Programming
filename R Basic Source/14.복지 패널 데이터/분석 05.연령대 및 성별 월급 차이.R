# 분석 05 : 연령대 및 성별 월급 차이
# 연령대 및 성별 월급의 평균
welfare <- read.csv('welfare.csv', header=T)
welfare

colnames(welfare)
head(welfare)

welfare$age <- 2015 - welfare$birth + 1
range(welfare$age)

gender_income$gender <- as.factor(gender_income$gender)
unique(welfare$gender)
welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female') 
unique(welfare$gender)

welfare <- welfare %>% 
  mutate(ageg=ifelse(age < 30, 'young', ifelse(age >= 60, 'old', 'middle')))

gender_income <- welfare %>% filter(!is.na(income)) %>% 
    group_by(ageg, gender) %>% summarise(mean_income = mean(income))

class(gender_income)
mode(gender_income)
gender_income

# 연령대 성별 01.png
# geom_col() : 기본 값은 누적 그래프이다.
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) + 
  geom_col() + scale_x_discrete(limits=c('young','middle','old'))

# dodge : 그룹핑 데이터 간격 띄우지 않기
# 연령대 성별 02.png
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) +
    geom_col(position = 'dodge') + 
    scale_x_discrete(limits=c('young','middle','old'))

# dodge2 : 그룹핑 데이터 간격 띄우기
# 연령대 성별 03.png
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) +
   geom_col(position = 'dodge2') +
      scale_x_discrete(limits=c('young','middle','old'))

# 막대 마다 간격 넓히기
ggplot(data = gender_income,
       aes(x = interaction(gender, ageg),
           y = mean_income,
           fill = gender
       )) + geom_col() +
    scale_x_discrete(limits = c('female.young','male.young', 
                                'female.middle', 'male.middle', 
                                'female.old', 'male.old'))
# 연령대 성별 04.png