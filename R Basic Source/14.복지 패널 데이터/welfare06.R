library(readxl)
library(dplyr)
library(ggplot2)

aa <- data.frame(col1=c('김', '이'), col2=c(100, 200) )
aa

bb <- data.frame(col1=c('김', '박'), col3=c(300, 400) )
bb

left_join(aa, bb, id='col1')

list_job <- read_excel('Koweps_Codebook.xlsx', sheet=2, col_names=TRUE )

welfare <- read.csv('welfare.csv', header=T)
colnames(welfare)
unique(welfare$code_job)

welfare <- left_join(welfare, list_job, id='code_job')
colnames(welfare) # job 컬럼 추가되었는 가 확인
str(welfare)
head(welfare[c('code_job', 'job')])  
  
# 직업별 월급 평균 구하기  
job_income <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% group_by(job) %>% summarise(mean_income = mean(income))

job_income

job_income_top_10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)

job_income_top_10

ggplot(data=job_income_top_10, aes(x=reorder(job, mean_income), y=mean_income, fill=job, color=job)) + geom_col() + coord_flip()

# 급여가 낮은 것 10개만 추출하여 오름차순으로 정렬하기
job_income_bottom_10

  
  
  