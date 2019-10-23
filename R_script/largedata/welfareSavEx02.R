# 성별에 따른 월급 차이

welfare <- read.csv('welfare.csv')

class(welfare$gender)

table(welfare$gender)

welfare$ gender <- ifelse(welfare$gender == 9, NA, welfare$gender)

welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female')

mData <- as.data.frame(table(welfare$gender))
colnames(mData) <- c('Gender', 'Freq')
mData
