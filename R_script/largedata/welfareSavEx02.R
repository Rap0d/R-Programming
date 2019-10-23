# 성별에 따른 월급 차이

library(ggplot2)
library(dplyr)

# welfareSavEx01 에서 만들어진 복지데이터 로드
welfare <- read.csv('welfare.csv')

class(welfare$gender)
table(welfare$gender)

# 데이터 전처리
welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)
welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female')

# 성별 빈도수 정리
## table함수를 통해 성별의 빈도를 구할 수 있음
mData <- as.data.frame(table(welfare$gender))
colnames(mData) <- c('Gender', 'Freq')
mData

ggplot(mData, aes(x = Gender, y = Freq, color = Gender, fill = Gender)) + geom_bar(stat = 'identity') + theme_minimal(base_family = 'AppleGothic') + labs(title = 'Gender Frequency', subtitle = 'Sub Title', caption = 'copyright etc.')

# 급여
class(welfare$income)
summary(welfare$income)

# 월급의 결측치는 분석에서 제외
qplot(welfare$income, bins = 50) + xlim(0, 1000)
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))

# 소득이 있는 사람들 중 성별 별 평균 급여
gender_income <- welfare %>% filter(!is.na(income)) %>% group_by(gender) %>% summarise(mean_income = mean(income))
gender_income

ggplot(gender_income, aes(x = gender, y = mean_income, color = gender, fill = gender)) + geom_bar(stat = 'identity') + theme_minimal(base_family = 'AppleGothic') + labs(title = 'Gender Income', subtitle = 'Sub Title', caption = 'copyright etc.')
