library(dplyr)
# 분석 06 : 직업별 월급 차이
# left_join 실습해보기
# help(left_join)
aa <- data.frame(col1=c('김', '이'), col2=c(100, 200))
aa

bb <- data.frame(col1=c('김', '박'), col3=c(300, 400))
bb

# 왼쪽 프레임은 데이터를 기준으로 병합한다.
# 존재하지 않는 컬럼은 NA로 채워진다
left_join(aa, bb, id = "col1")

right_join(aa, bb, id = "col1")

full_join(aa, bb, id = "col1")

anti_join(aa, bb, id = "col1")

class(welfare$code_job) # 직업 코드
head(welfare$code_job, 10)

library(readxl)
# 코드 북 파일 : Koweps_Codebook.xlsx
list_job <- read_excel('Koweps_Codebook.xlsx', sheet=2, col_names = TRUE)
head( list_job, 10)
dim( list_job ) # 149   2

welfare <- read.csv('welfare.csv', header=T)
welfare

# 양쪽 프레임에 code_job 컬럼이 있는지 확인 요망
welfare <- left_join(welfare, list_job, id = "code_job")
str(welfare)
colnames(welfare) # job 컬럼 추가되었는 가 확인
head( welfare[c('code_job', 'job')])

welfare %>% filter(!is.na(code_job)) %>% select(code_job, job) %>% head(20)

# 직업별 월급 평균 표 만들기
# 직업과 소득이 둘다 있는 경우에만 직업별로 그룹핑하여
# 평균 급여 구하기
job_income <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% 
    group_by(job) %>% summarise(mean_income = mean(income))

head(job_income)

# 월급을 내림차순으로 정렬하고, 상위 10개만 추출하기
job_income_top_10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)

job_income_top_10

# 직업 이름이 길어 보임.png
ggplot(data=job_income_top_10, aes(x=job, y=mean_income, fill=job)) + geom_col()

# x=reorder(job, mean_income) : x 축에 job를 그리되, mean_income 컬럼을 이용하여 정렬하세요.
# 컬럼을 이용한 정렬.png
# reorder(job, mean_income) : mean_income의 값이 높은 데이터의 job을 먼저 보여 주세요.
ggplot(data=job_income_top_10, 
	aes(x=reorder(job, mean_income), y=mean_income, fill=job)) + geom_col()

ggplot(data=job_income_top_10, 
	aes(x=reorder(job, mean_income), y=mean_income, fill=job)) 
	+ geom_col()

# coord_flip() : 직각 좌표계를 뒤집어 주는 함수(x -> y, y -> x)
# coord_flip() 막대 그래프를 오른쪽으로 90도 회전
# 보열줄 라벨 문자열이 긴 경우에 유용
# 막대 오른쪽 회전(coord_flip 함수).png
ggplot(data=job_income_top_10, 
	aes(x=reorder(job, mean_income), y=mean_income, fill=job)) + geom_col() + coord_flip()  + theme(legend.position = 'none') + labs(y='평균 소득', x ='직업', title='직업별 평균 소득')

# + theme(legend.title = element_blank())

# 풀어 봅시다 : 월급을 오름차순으로 정렬하고, 10개만 추출하기
# job_income_bottom_10