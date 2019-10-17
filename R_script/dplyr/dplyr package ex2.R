library(dplyr)
setwd('../../R_script/191011_01/')
students <- read.csv("jumsu.csv")
head(students)
# 
# students에서 ban가 1인 경우만 출력하세요.
# 
ex1 <- filter(students, ban == 1)
ex1

# students에서 3반이 아닌 경우만 출력하세요.
# 
ex2 <- filter(students, ban != 3)
ex2

# 국어 점수가 50점을 초과한 경우만 출력하세요. 
# 
ex3 <- filter(students, kor > 50)
ex3

# 영어 점수가 80점 이하인 경우만 출력하세요.
# 
ex4 <- filter(students, eng <= 80)
ex4

# 1반이면서 국어 점수가 50점 이상인 경우만 출력하세요.
# 
ex5 <- filter(students, ban == 1 & kor >= 50)
ex5

# 국어 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우만 출력하세요.
# 
ex6 <- filter(students, eng >= 90 & kor >= 90)
ex6

# 영어 점수가 90점 미만이거나 수학 점수가 50점 미만인 경우
# 
ex7 <- filter(students, eng < 90 & math < 50)
ex7

# # %in% 기호를 사용하면 코드를 좀 더 간결하게 작성할 수 있다.
# # %in% 기호와 c() 함수를 이용해 조건 목록을 입력하면 된다.
# 
# # 1, 3, 5반 학생들 정보를 출력하시오.
# 
ex8 <- filter(students, ban %in% c('1','3', '5'))
ex8

# 1반 학생들 정보를 변수 ban1에 저장하시오.
# 
ban1 <- filter(students, ban == 1)
ban1

# 2반 학생들 정보를 변수 ban2에 저장하시오.
# 
ban2 <- filter(students, ban == 2)
ban2

# 변수 ban1의 국어 점수 평균을 구하시오.
# 
ex9 <- mean(ban1$kor)
ex9

# 변수 ban2의 영어 점수 평균을 구하시오.
# 
ex10 <- mean(ban2$eng)
ex10

# kor 컬럼만 추출하시오.
# 
ex11 <- select(students, kor)
ex11

# ban, kor, eng 컬럼을 추출하시오.
# 
ex12 <- select(students, eng)
ex12

# kor, eng 컬럼을 제외하고 나머지 컬럼만 추출하시오.
# 
ex13 <- select(students, -c('kor', 'eng'))
ex13

# 1반 학생들의 eng 컬럼만 추출하시오.
# 
ex14 <- select(ban1, eng)
ex14

# id, kor 추출하되, 앞부분 10행까지만 추출하시오.
# 힌트 : head() 함수도 사용할 수 있다.
# 
ex15 <- head(select(students, c('id', 'kor')), 10)
ex15

# 국어 점수를 이용하여 오름차순으로 정렬하시오.
# 
ex16 <- students %>% arrange(kor)
ex16

# 영어 점수를 이용하여 내림차순으로 정렬하시오.
# 
ex17 <- students %>% arrange(desc(kor))
ex17

# 반(ban)별 오름차순 정렬 후, 국어(kor) 점수별로 내림차순 정렬하시오.
# 
ex18 <- students %>% arrange(ban) %>% arrange(desc(kor))
ex18

# 총점 컬럼을 만들어 보세요.
# 총점(total) = kor + eng + math
# 
ex19 <- students %>% mutate(total = kor + eng + math)
ex19

# 평균 컬럼을 만들어 보세요.
# 평균(average) = total / 3 
# 
ex20 <- ex19 %>% mutate(average = round((total / 3), 2))
ex20
# result 컬럼을 만들어 보세요.
# result 컬럼은 수학 점수가 60이상이면 pass, 아니면 fail이라는 값을 저장해야 한다.
# 힌트 : ifelse 함수를 사용하면 된다.
# 
ex21 <- ex20 %>% mutate(result = (ifelse(students$math >= 60, 'pass', 'fail')))
ex21
# 총합 컬럼 기준으로 오름차순 정렬하시오
# 
ex22 <- ex21 %>% arrange(total)
ex22

# 국어 점수의 평균을 구한 후 mean_kor이라는 새로운 변수에 값을 할당해 보세요.
# 
mean_kor = round(mean(students$kor), 2)
mean_kor

# 반별로 국어 점수의 평균과 영어 점수의 총합 및 학생 수를 구해 보세요(힌트 : n() 함수)
ex23 <- ex21 %>% group_by(ban) %>% summarise(국어점수평균 = mean(kor), 영어점수총합 = sum(eng), 학생수 = n())
ex23
