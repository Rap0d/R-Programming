# dplyr package : c++ 언어로 개발되어 처리 속도 개선
getwd()
setwd('../../R Basic Source/06.data processing/')
install.packages('dplyr')
library(dplyr)

data <- read.csv('2013년_프로야구선수_성적.csv')
data
str(data)

# filter 함수를 통해 120 경기 이상 뛴 선수 조회
data2 <- filter(data, 경기 >= 120)
data2

data[c('경기', '득점')]
# 경기 >= 120, 득점 >= 80
data3 <- filter(data, 경기 >= 120 & 득점 >= 80)
data3

# 포지션이 '1루수', '3루수'
data4 <- filter(data, 포지션 == '1루수' | 포지션 == '3루수')
data4

# %in% : in 연산자
data4 <- filter(data, 포지션 %in% c('1루수', '3루수'))
data4

# 선수명, 포지션, 팀 
data5 <- select(data, c(선수명, 포지션, 팀))
data5
colnames(data)

data6 <- select(data, 순위:타수)
data6

# 포지션이 1루수 또는 3루수인 선수들의 선수명, 포지션, 득점
data7 <- select(data4, c(선수명, 포지션, 팀))
data7

# %>% : 여러개의 문장을 조합하여 사용하고자 할때
# select나 filter안에 있는 data 변수를 빼야한다. 
result <- data %>% filter(포지션 %in% c('1루수', '3루수')) %>% select(c(선수명, 포지션, 팀))
result

# 홈런, 타점을 제외하고 select
data8 <- select(data, -c(홈런, 타점))
data8

# 선수이름, 팀, 경기, 타수 조회
# 타수가 400 이상
data9 <- filter(data[c('선수명', '팀', '경기', '타수')], 타수 >= 400)
data9

data10 <- data %>% arrange(홈런)
data10

data11 <- data %>% arrange(desc(홈런))
data11

# caution : select와 arrange의 순서 주의. 
# 정렬 후 select해야함
# select를 먼저 하면 뒤에서 select된 컬럼 이외의 컬럼을 사용할 수 없음 
data12 <- data %>% arrange(desc(홈런)) %>% select(c('선수명', '팀', '경기', '타수')) %>% filter(타수 >= 400)
data12

# mutate 함수
# 컬럼의 연산을 통해 컬럼 생성
data13 <- data %>% select(선수명, 팀, 경기, 타수) %>% mutate(결과 = 경기 * 타수)
data13

data
# 선수명, 팀, 경기, 타수, 루타의 합
# 루타의 합 = 1루타 + 2루타 + 3루타
# 루타의 합에 대해 오름차수 정렬 
data14 <- data %>% mutate(루타의합 = (안타 + X2루타 + X3루타)) %>% arrange(루타의합) %>%  select(선수명, 팀, 경기, 타수, 루타의합)
data14

# 팀별 평균 경기 수
# group_by로 팀별로 그룹핑을 한 뒤 경기의 평균값을(mean) 정렬(arrange) 별도 컬럼으로 생성(summarise)
data[c('팀', '경기')]
data16 <- data %>% group_by(팀) %>% summarise(arrange=mean(경기, na.rm = T))
data16

# 경기와 타수의 각각의 평균 구하기
data17 <- data %>% group_by(팀) %>% summarise_each(list(mean), 경기, 타수)
data17

# n()함수 : 개수 확인(도수), 직관적이지 못하니 확인
data18 <- data %>% group_by(팀) %>% summarise_each(funs(mean, n()), 경기, 타수)
data18

# %>%

