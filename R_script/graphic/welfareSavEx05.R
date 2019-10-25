# 직업별 월급 차이 

library(readxl)

df1 <- data.frame(col1 = c('kim', 'lee'), col2 = c(100, 200))
df2 <- data.frame(col1 = c('kim', 'park'), col3 = c(300, 400))

left_join(df1, df2, id = 'col1')
full_join(df1, df2, id = 'col1')

welfare <- read.csv('welfare.csv')
unique(welfare$code_job)

jobList <- read_excel('Koweps_Codebook.xlsx', sheet = 2, col_names = T)
jobList

data01 <- full_join(welfare, jobList, id = 'code_job')
data01

job_income <- data01 %>% filter(!is.na(job) & !is.na(income)) %>% group_by(job) %>% summarise(mean_income = mean(income))
job_income

job_top10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)
job_top10

# reorder 함수를 이용한 sort
## coord_flip : 긴 이름으로 인한 축 반전
ggplot(data = job_top10, aes(x = reorder(job, mean_income), y = mean_income, fill = job, col = job)) + geom_bar(stat = 'identity') + theme_minimal(base_family = 'AppleGothic') + coord_flip()

# job_income_bottom_10
job_bot10 <- job_income %>% arrange(mean_income) %>% head(10)
job_bot10
ggplot(data = job_bot10, aes(x = reorder(job, mean_income), y = mean_income, fill = job, col = job)) + geom_bar(stat = 'identity') + theme_minimal(base_family = 'AppleGothic') + coord_flip()

