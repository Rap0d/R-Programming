# 다음과 같은 벡터를 칼럼으로 갖는 데이터프레임을 생성하시오.
# name <- c('김구', '유관순', '이순신', '김유신', '홍길동')
# age <- c(55, 45, 45, 53, 15) #연령
# gender <- c(1, 2, 1, 1, 1) #1:남자, 2: 여자
# job <- c('연예인', '주부', '군인', '직장인', '학생')
# sat <- c(3, 4, 2, 5, 5) # 만족도
# grade <- c('C', 'C', 'A', 'D', 'A')
# total <- c(44.4, 28.5, 43.5, NA, 27.1) #총구매금액(NA:결측치)  
# 
name <- c('김구', '유관순', '이순신', '김유신', '홍길동')
age <- c(55, 45, 45, 53, 15) #연령
gender <- c(1, 2, 1, 1, 1) #1:남자, 2: 여자
job <- c('연예인', '주부', '군인', '직장인', '학생')
sat <- c(3, 4, 2, 5, 5) # 만족도
grade <- c('C', 'C', 'A', 'D', 'A')
total <- c(44.4, 28.5, 43.5, NA, 27.1)

ex01 <- data.frame(name = name, age = age, gender = gender, job = job, sat = sat, grade = grade, total = total)
ex01

# 문제01) 위 7개의 벡터를 칼럼으로 갖는 members 데이터프레임을 생성하세요.
# 
members <- ex01
members

# 문제02) gender 변수를 이용하여 막대 그래프를 그리시오.
# 
plot(factor(members$gender, labels=c('Male', 'Female'), ordered=T))

# 문제03) members에서 홀수 행만 선택해서 members2에 저장하세요.
# 
members2 <- members[seq(1, length(members), 2),]
members2

# 문제04) 전체 데이터에서 60%만 샘플링하여 mysampling에 저장하세요.
# 
members
0.6*nrow(members)
sam <- sample(0.6*nrow(members))
sam
mysampling <- members[sam,]
mysampling

# 문제05) 다음 물음에 답하시오.
# 나이가 50이상이 사람들을 조회하시오.
# grade가 'A'또는 'D'인 사람들의 name, age, grade만 조회하시오.
# 만족도의 평균 보다 높은 만족도를 보인 사람들을 조회하시오.
#
subset(members, age >= 50)
subset(members, grade == 'A' | grade == 'D', c(1, 2, 6))
subset(members, sat > mean(members$sat))
