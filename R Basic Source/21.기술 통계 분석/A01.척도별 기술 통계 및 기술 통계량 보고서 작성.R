# 척도별 기술 통계량 구하기
descriptive = read.csv("descriptive.csv", header=TRUE)
head(descriptive) # 데이터셋 확인

# 데이터 셋을 구성하는 칼럼을 단위로 기술 통계량을 통해서 
# 데이터의 특성을 살펴 보기 위하여 다음 함수들을 사용해본다..
dim(descriptive) # 차원보기
length(descriptive) # 열 길이
length(descriptive$survey) # 컬럼 관찰치  
str(descriptive) # 데이터 구조보기 
summary(descriptive) # 요약 통계량

# 명목 척도 변수의 기술 통계량
length(descriptive$gender) # 명목 척도
summary(descriptive$gender)  # 명목 척도는 의미가 없다.
table(descriptive$gender)  # 성별 빈도수 - outlier 확인(0, 5)

# 성별 항목에서 이상치(outlier)들을 제거한다.
descriptive = subset(descriptive,descriptive$gender==1 | descriptive$gender==2) 

tablegender = table(descriptive$gender) # 빈도수 저장
tablegender 

# 막대 차트를 이용하여 범주형 데이터를 시각화한다. 
barplot(tablegender, col=rainbow(length(tablegender))) 

propgender =  prop.table(tablegender) # 빈도수 비율 계산
round( 100 * propgender, 2) # 백분율 적용(소수점 2자리)

# 서열 척도 변수의 기술 통계량 
length(descriptive$level)  # 학력 수준 - 서열
summary(descriptive$level) # 명목 척도와 함께 의미없음
table(descriptive$level)   # 빈도 분석 - 의미 있음

tablelevel = table(descriptive$level)     # 각 학력수준에 빈도수 저장
barplot(tablelevel, col=rainbow(length(tablelevel)))

# 등간 척도 변수의 기술 통계량
survey = descriptive$survey
survey # 만족도(survey) 변수

unique(survey)
summary(survey) # 만족도(5점 척도) -> 2.605(평균)
tablesurvey = table(survey)     # 빈도수
tablesurvey

hist(survey) # 등간 척도 시각화 -> 히스토그림

# 비율 척도 변수의 기술 통계량  
length(descriptive$cost)
summary(descriptive$cost)  # 요약통계량 - 의미 있음(mean)
mean(descriptive$cost)     # NA
descriptive$cost

# 결측치 및 outlier를 제거하기 위하여 그래프를 그려 본다.
plot(descriptive$cost)
# boxplot(descriptive$cost)

# cost가 2이상이고, 10이하인 데이터만 의미가 있다고 볼 수 있다.
# subset()함수를 이용하여 연속형 변수의 이상치를 제거하는 예문이다.
descriptive = subset(descriptive,descriptive$cost >= 2 & descriptive$cost <= 10) # 총점기준
descriptive
tablecost= descriptive$cost
tablecost

# -- cost 변수의 대표값 
mean(tablecost)    # 평균 : 5.354
median(tablecost)   # 중위수 :  5.4   
sort(tablecost)    # 오름차순 
sort(tablecost, decreasing=T)  # 내림차순  
quantile(tablecost, 1/4)  # 1 사분위수 : 25%, 4.6
quantile(tablecost, 2/4) # 2 사분위수 - 50%, 5.4
quantile(tablecost, 3/4)  # 3 사분위수 : 75%, 6.2
quantile(tablecost, 4/4) # 4 사분위수 - 100%, 7.9

# cost 변수의 산포도
var(tablecost)     # 분산 : 1.296826
sd(tablecost) # 표준편차는 분산의 양의 제곱근 : 1.138783 
sqrt(var(tablecost))     # 1.138783 
min(tablecost)     # 최소값
max(tablecost)     # 최대값
range(tablecost)   # 범위(min ~ max)

# 연속형(등간/비율척도) 시각화 : 히스토그램 의미없음
table(descriptive$cost) # cost 빈도수
hist(descriptive$cost)  

# 연속형 -> 범주화(리코딩) : 1,2,3
# 생활비(cost 컬럼) 수준은 응답자 마다 서로 다른 값으로 입력되기 때문에 1만원에서 3만원 사이는 숫자 1, 
# 4만원에서 6만원 사이는 숫자 2, 7만원 이상 숫자는 3으로 범주화하여 다음과 같이 리코딩한다.
descriptive$cost2[descriptive$cost >=1 & descriptive$cost <=3] =1
descriptive$cost2[descriptive$cost >=4 & descriptive$cost <=6] =2
descriptive$cost2[descriptive$cost >=7] =3
length(descriptive$cost2)

table(descriptive$cost2)
barplot(table(descriptive$cost2), col=rainbow(3))