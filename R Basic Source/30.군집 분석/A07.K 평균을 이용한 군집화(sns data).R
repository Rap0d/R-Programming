############################################################
# k-평균(k-mean)을 활용한 군집화
############################################################
teens <- read.csv("snsdata.csv")

# 개인 신상 정보 컬럼 4개와 관심 선호도 컬럼 36개를 이용하여 군집 분류하기
str(teens)
# 4개의 개인적인 속성과 36개의 관심 영역
# 'data.frame':	30000 obs. of  40 variables:
# 이하 생략

# gender 변수의 결측 데이터 확인
table(teens$gender)
# F     M
# 22054  5222

table(teens$gender, useNA = "ifany")
#  F      M   <NA>
#  22054  5222  2724

# 결측치가 너무 많은 경우 모두 삭제해 버리면 데이터 분석의 의미가 퇴색될 수 있다.
# 그래서, 다음과 같이 dummy 변수 형태로 바꾸고자 한다.
# 성별의 결측치를 dummy 변수 형태로 처리한다.
# gender 컬럼이 F이면 1, 나머지 컬럼은 0으로 변경
teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)
teens$female
table(teens$female)

unique(teens$gender) # M    F    <NA>
# 결측치는 1로, 나머지는 0으로 dummy 변수 처리
teens$no_gender <- ifelse( is.na(teens$gender), 1, 0)
teens$no_gender
# 2724개의 결측치가 있다.
table(teens$no_gender, useNA = 'ifany')

# gender 컬럼 확인
table(teens$gender, useNA = 'ifany')

# age 변수 확인하기
summary(teens$age)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#   3.086  16.312  17.287  17.994  18.259 106.927    5086

# summary 함수의 결과를 보면 결측 데이터가 5086개이다.
# 그리고, 13 <= 고등학생 나이 < 20 라고 한다면 최소 나이가 3.086세 이고,
# 최대 나이가 106.927세인 것은 이상치(outlier)가 있다는 의미이다.

# age 이상치(outliers) 제거
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)

summary(teens$age)

# 집단(cohort)별 나이 평균
# 나이는 연속형 척도이므로 알수 없는 값에 데이터를 임의로 넣을 수 없다.
mean(teens$age) # doesn't work
mean(teens$age, na.rm = TRUE)

# 각 개인에 대한 예측된 나이 계산
# help(ave) : 해당 그룹 내의 요소들의 평균을 구해주는 함수
df <- data.frame(A=c(1, 2, 3, 4), B=c('a', 'a', 'b', 'b'))
df

# B로 그룹화시켜서 B에 대한 A의 평균을 구하시오.
ave(df$A, df$B)

# 결측치에 평균 값을 넣기 위하여 다음과 같이 코딩한다.
# 졸업 년도별로 평균 나이를 구하도록 한다.
ave_age <- ave(teens$age, teens$gradyear,
                 FUN = function(x){ mean(x, na.rm = TRUE) } )

# 나이 컬럼 중에서 NA인 항목들에 대하여 값을 치환하기
teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

# 제거한 결측치에 대한 요약 결과 확인
summary(teens$age)

# 훈련용 데이터 셋 준비
# 선호도 컬럼 : 1번째 부터 4번째 컬럼을 제외한 나머지 컬럼
interests <- teens[5:40] # 36개의 관심 영역에 대한 컬럼

# 같은 크기의 범위를 위하여 표준화나 z점수 일반화를 한다.
interests_z <- as.data.frame(lapply(interests, scale))

# K 값은 편의상 5로 정의했다.  help(kmeans)
teen_clusters <- kmeans(interests_z, 5)

names(teen_clusters)
# [1] "cluster"  "centers"  "totss"  "withinss" "tot.withinss" "betweenss"
# [7] "size"   "iter"    "ifault"

# 모델 성능 평가하기
teen_clusters$size # 군집의 크기 확인
#  247   563  1088  5513 22589

# 군집의 중앙점(centers) 확인
# 행은 군집을 의미한다.
# 수치는 관심 목록에 대한 평균 값을 의미한다.
# 예를 들어서 basketball의 4번째 그룹은 값이 0.4869295이다.
# 이 값은 랜덤이므로 실행시마다 다를 수 있다.
# z 점수로 평준화가 되었기 때문에 음수가 나올수 있다.
teen_clusters$centers

## 5단계 : 모델 성능 향상
# 본래 데이터 프레임에 군집ID(cluster ID) 적용
teens$cluster <- teen_clusters$cluster

# 관심 있는 컬럼에 대하여 처음 5개 데이터만 확인하기
teens[1:5, c("cluster", "gender", "age", "friends")]

# help(aggregate)
# stats 패키지의 aggregate() 함수를 사용하면 군집의 통계학적인 정보를 확인할 수 있다.
# 군집별(cluster) 평균(mean) 나이(age)
aggregate(data = teens, age ~ cluster, mean)

# 군집별 여성 비율
aggregate(data = teens, female ~ cluster, mean)

# 군집별 친구 수의 평균
aggregate(data = teens, friends ~ cluster, mean)

# 군집을 살펴 보면 각 그룹의 주요 관심 분야를 목록화할 수 있다.
# cluster4를 예를 들면 basketball, football, soccer, volleyball 등이 주요 관심 목록이다.
# 이러한 표를 고려하여 다섯 부류의 청소년들의 차이를 구분하면 된다.
# Princesses(공주), Brains(영리한 학생), Criminals(범죄자)
# Atheletes(운동 선수), Basket Case(무기력한 학생)