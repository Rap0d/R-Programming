# 분석 01 : 한국 복지 패널 데이터 준비하기

setwd('d:/rtest/hohoho')

# foreign 패키지 : 외부 통계 프로그램(SAS, SPSS 등등)에서 만든 파일을 R에서 읽어 오기 위하여 ...
install.packages('foreign')
install.packages('readxl')
install.packages('ggplot2')
install.packages('dplyr')

library(foreign)
library(ggplot2)
library(dplyr)
library(readxl) # 엑셀 파일 불러 오기

filename <- 'Koweps_hpc10_2015_beta1.sav'
raw_welfare <- read.spss(file = filename, to.data.frame = TRUE)
str(raw_welfare)
head(raw_welfare, 2)

# 코드 북 파일 : Koweps_Codebook.xlsx
# 필요한 컬럼만 다시 추출하기
welfare <- raw_welfare[c('h10_g3', 'h10_g4', 'h10_g10', 'h10_g11', 'h10_eco9', 'p1002_8aq1', 'h10_reg7')]
head(welfare)

# help(rename)
# 가독성 있게 컬럼 이름을 변경( colnames로도 가능)
welfare <- rename(welfare, gender=h10_g3, birth=h10_g4, marriage=h10_g10, religion=h10_g11, code_job=h10_eco9, income=p1002_8aq1, code_region=h10_reg7 )
head(welfare)
tail(welfare)
dim(welfare) # 16664     7
str(welfare)

write.csv(welfare, 'welfare.csv', row.names=F, quote=F)


# 분석 02 : 성별에 따른 월급 차이
class(welfare$gender)
table(welfare$gender) # 이상치(outlier) 확인

# 만일 결측치가 있다면 다음 문장 수행
welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)

# 결측치 확인 :  전부다 FALSE이면 결측치가 없다는 얘기
table(is.na(welfare$gender))

# 숫자 1은 male, 숫자 2는 female
welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female')

table(welfare$gender)
# female   male
# 9086   7578

qplot(welfare$gender)
# ggplot(factor(welfare$gender), aes(colour=c('red', 'blue')))

# 월급 관련 : 연속형 척도
class(welfare$income)

# 연속형 척도는 summary 함수를 이용하여 요약 통계 량을 확인하도록 한다.
summary(welfare$income)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#     0.0   122.0   192.5   241.6   316.6  2400.0   12030

# 월급은 결측치가 12030 정도 보이고 있다.
# 이것은 분석에서 제외하도록 한다.

qplot( welfare$income, bins=10 )
qplot( welfare$income, bins=30 )
qplot( welfare$income, bins=50 )
qplot( welfare$income, bins=50) +  xlim(0, 1000)

# 그래프를 살펴 보면 월급의 분포가 0~300만원 정도 사이에 많은 분포를 하고 있다.

summary(welfare$income)

# 값이 0이거나 9999이면 NA로 처리
welfare$income <- ifelse( welfare$income %in% c(0, 9999), NA, welfare$income)

table(is.na(welfare$income))

# 모름/무응답을 한 사람이 14명이다.
# 12044 - 12030

# 소득이 있는 항목들 중에서 성별로 그룹핑하여
# 평균 급여를 구하도록 한다.
gender_income <- welfare %>% filter(!is.na(income)) %>% group_by(gender) %>% summarise(mean_income = mean(income))

# 소득이 있는 사람 중에서 남자는 평균 312, 여자는 평균 163만원 정도의 소득이 있는 것으로 파악된다.
gender_income
class( gender_income)
# geom_col() : 집계 데이터에서 막대 그래프를 그려 주는 함수
ggplot(data=gender_income, aes(x=gender, y=mean_income)) + geom_col()

# 분석 03 : 나이와 월급의 관계
# 나이 정보가 없어서 birth 컬럼으로 파생 계산
class(welfare$birth)

# NA가 존재하지 않는다.
summary(welfare$birth)

qplot(welfare$birth)

welfare$age <- 2015 - welfare$birth + 1
welfare$age

summary(welfare$age)
# 2세부터 109세까지 나이가 분포 되어 있다.
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 2.00   28.00   50.00   48.43   70.00  109.00

qplot(welfare$age)

# 나이와 월급의 관계 분석
# 소득이 있는 사람에 한하여 나이별로 평균 소득 구하기
age_income <- welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income = mean(income))

head(age_income)

ggplot(data=age_income, aes(x=age, y=mean_income)) + geom_line()

# 분석 04 : 연령대에 따른 월급 차이
# 청년_young(30세 미만), 중년_middle(30세 이상), 노년_old(60세 이상)

# ageg : age group
welfare <- welfare %>% mutate(ageg=ifelse(age < 30, 'young', ifelse(age >= 60, 'old', 'middle')))

head(welfare[c('age', 'ageg')], 10)

table(welfare$ageg)
# middle    old  young
# 6049   6281   4334

qplot(welfare$ageg)

# 연령대별 소득
# 소득이 있는 사람들 중에서 연령대별로 그룹핑하여
# 평균 소득을 구하기
ageg_income <- welfare %>% filter(!is.na(income)) %>% group_by(ageg) %>% summarise(mean_income = mean(income))

ageg_income

help(scale_x_discrete)
# scale_x_discrete 함수의 limits 옵션으로 순서를 사용자 정의 순서로 바꿀 수 있다.
ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col() + scale_x_discrete(limits=c('young','middle','old'))

# 분석 05 : 연령대 및 성별 월급 차이
# 연령대 및 성별 월급의 평균
gender_income <- welfare %>% filter(!is.na(income)) %>% group_by(ageg, gender) %>% summarise(mean_income = mean(income))

gender_income

# 그래프 그리기
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) + geom_col() + scale_x_discrete(limits=c('young','middle','old'))

# dodge : 그룹핑 데이터 간격 안 띄
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) + geom_col(position = 'dodge') + scale_x_discrete(limits=c('young','middle','old'))

# dodge2 : 그룹핑 데이터 간격 띄우기
ggplot(data=gender_income, aes(x=ageg, y=mean_income, fill=gender)) + geom_col(position = 'dodge2') + scale_x_discrete(limits=c('young','middle','old'))

# 막대 마다 간격 넓히기
ggplot(data = gender_income,
        aes(x = interaction(gender, ageg),
            y = mean_income,
            fill = gender
       ))
        + geom_col() +
    scale_x_discrete(limits = c('female.young','male.young', 'female.middle','male.middle','female.old','male.old'))

# left_join 실습해보기
help(left_join)

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
# return all rows from x where there are not matching values in y, keeping just columns from x.

# 분석 06 : 직업별 월급 차이
class(welfare$code_job) # 직업 코드
head(welfare$code_job, 10)

library(readxl)
# 코드 북 파일 : Koweps_Codebook.xlsx
list_job <- read_excel('Koweps_Codebook.xlsx', sheet=2, col_names = TRUE)
head( list_job, 10)
dim( list_job ) # 149   2

# 양쪽 프레임에 code_job 컬럼이 있는지 확인 요망
welfare <- left_join(welfare, list_job, id = "code_job")
str(welfare)
head( welfare[c('code_job', 'job')])

welfare %>% filter(!is.na(code_job)) %>% select(code_job, job) %>% head(20)

# 직업별 월급 평균 표 만들기
# 직업과 소득이 둘다 있는 경우에만 직업별로 그룹핑하여
# 평균 급여 구하기
job_income <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% group_by(job) %>% summarise(mean_income = mean(income))

head(job_income)

# 월급을 내림차순으로 정렬하고, 상위 10개만 추출하기
job_income_top_10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)

job_income_top_10

ggplot(data=job_income_top_10, aes(x=job, y=mean_income)) + geom_col()

# x=reorder(job, mean_income) : x 축에 job를 그리되, mean_income 컬럼을 이용하여 정렬하세요
ggplot(data=job_income_top_10, aes(x=reorder(job, mean_income), y=mean_income)) + geom_col()

# coord_flip() : 직각 좌표계를 뒤집어 주는 함수(x -> y, y -> x)
# coord_flip() 막대 그래프를 오른쪽으로 90도 회전
# 보열줄 라벨 문자열이 긴 경우에 유용
ggplot(data=job_income_top_10, aes(x=reorder(job, mean_income), y=mean_income)) + geom_col() + coord_flip()

# 월급을 오름차순으로 정렬하고, 10개만 추출하기
# job_income_bottom_10

# 분석 07 : 성별 직업 빈도

# 남성 직업 빈도 상위 10개
# 빈도 수는 n() 함수를 사용하면 된다.
job_male <- welfare %>% filter(!is.na(job) & gender=='male') %>% group_by(job) %>% summarise(cnt = n()) %>% arrange(desc(cnt)) %>% head(10)

job_male

ggplot(data=job_male, aes(x=reorder(job, cnt), y=cnt)) + geom_col() + coord_flip()

# 여성 직업 빈도 상위 10개
job_female <- welfare %>% filter(!is.na(job) & gender=='female') %>% group_by(job) %>% summarise(cnt = n()) %>% arrange(desc(cnt)) %>% head(10)

job_female

ggplot(data=job_female, aes(x=reorder(job, cnt), y=cnt)) + geom_col() + coord_flip()

# 분석 08 : 종교 유무에 따른 이혼율
class(welfare$religion)
table(welfare$religion)

welfare$religion <- ifelse(welfare$religion == 1, 'yes', 'no')
table(welfare$religion)
# no  yes
# 8617 8047

qplot(welfare$religion)

# 이혼 여부 관련 변수 만들기
class(welfare$marriage)
table(welfare$marriage)

# 값 : 1(marriage), 3(divorce), 이외(NA)
welfare$group_marriage <- ifelse( welfare$marriage == 1, 'marriage', ifelse( welfare$marriage == 3, 'divorce', NA))

str(welfare)
head(welfare$group_marriage, 10)

table(welfare$group_marriage)
# divorce marriage
# 712     8431

table(is.na(welfare$group_marriage))
# FALSE  TRUE
# 9143  7521

712 + 8431 # 9143

# 결혼 유무(결측치 제외)에 따라서 [종교 유무, 이혼 유무] 상태로 그룹핑한다.
# 빈도수 구하기
# tot_group : 종교 그룹 내의 총합
# pct : 종교 그룹 내에서의 이혼 유뮤에 대한 비율
religion_marriage <- welfare %>% filter(!is.na(group_marriage)) %>% group_by(religion, group_marriage) %>% summarise(cnt = n()) %>% mutate(tot_group=sum(cnt)) %>% mutate(pct = round(100 * cnt/tot_group, 1))

religion_marriage

4213 / 4541

# 종교 유무별 이혼의 비율 추출
divorce <- religion_marriage %>% filter(group_marriage == 'divorce') %>% select(religion, pct)

divorce
# religion   pct
# no         8.3
# yes        7.2

ggplot(data=divorce, aes(x=religion, y=pct, fill=divorce$religion)) + geom_col()

# 년령대, 이혼 유무에 따라서 그룹핑
ageg_marriage <- welfare %>% filter(!is.na(group_marriage)) %>% group_by(ageg, group_marriage) %>% summarise(cnt = n()) %>% mutate(tot_group=sum(cnt)) %>% mutate(pct = round(100 * cnt/tot_group, 1))

ageg_marriage

# young 그룹은 제외하고, 이혼한 항목만 추출하기
ageg_divorce <- ageg_marriage %>% filter( ageg != 'young' & group_marriage == 'divorce') %>% select(ageg, pct)

ageg_divorce
# ageg     pct
#     1 middle   8.9
# 2 old      6.6

ggplot(data=ageg_divorce, aes(x=ageg, y=pct)) + geom_col()

# 분석 09 : 지역별 연령대 비율
str(welfare)
table(welfare$code_region)

list_region <- data.frame(code_region=c(1:7), region=c('서울','수도권','경상남도','경상북도','전라남도','전라북도','경기도'))

list_region

welfare <- left_join(welfare, list_region, id='code_region')
str(welfare)
welfare$region

welfare %>% select(code_region, region) %>% head(20)

# 지역별, 년령대 별로 그룹화하여 빈도수와 비율을 구하시오
# 비율은 해당 지역에 대하여 해당 년령대의 비율이다.
region_ageg <- welfare %>% group_by(region, ageg) %>% summarise(cnt = n()) %>% mutate(tot_group=sum(cnt)) %>% mutate(pct = round(100 * cnt/tot_group, 1))

region_ageg

32.4 + 42.2 +25.4

ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg)) + geom_col() + coord_flip()

# 지역별 ob의 비율이 낮은 거 부터 추출
list_order_old <- region_ageg %>% filter(ageg=='old') %>% arrange(pct) %>% select(region, pct)

list_order_old

ggplot(data=list_order_old, aes(x=reorder(region, pct), y=pct, fill=region, colour=region)) + geom_col() + coord_flip()

