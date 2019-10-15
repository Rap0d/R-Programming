# 분석 02 : 성별에 따른 월급 차이
class(welfare$gender)
table(welfare$gender) # 이상치(outlier) 확인
unique(welfare$gender)

# 만일 결측치가 있다면 다음 문장 수행
welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)

# 결측치 확인 :  전부다 FALSE이면 결측치가 없다는 얘기
table(is.na(welfare$gender))

# 숫자 1은 male, 숫자 2는 female
welfare$gender <- ifelse(welfare$gender == 1, 'male', 'female')

class(table(welfare$gender))
# female   male
# 9086   7578

table(welfare$gender)
unique(welfare$gender)

mydata <- as.data.frame(table(welfare$gender))
colnames(mydata) <- c('성별', '빈도수')

ggplot(mydata, aes(x=성별, y=빈도수, color=성별, fill=성별)) + geom_bar(stat='identity')
# 성별 빈도.png, 성별 빈도new.png

# 월급 관련 : 연속형 척도
class(welfare$income)

# 연속형 척도는 summary 함수를 이용하여 요약 통계 량을 확인하도록 한다.
summary(welfare$income)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#     0.0   122.0   192.5   241.6   316.6  2400.0   12030

# 월급은 결측치가 12030 정도 보이고 있다.
# 이것은 분석에서 제외하도록 한다.
# help(qplot)
qplot( welfare$income, bins=10 ) # histogram01.png
qplot( welfare$income, bins=30 ) # histogram02.png
qplot( welfare$income, bins=50 ) # histogram03.png
qplot( welfare$income, bins=50) +  xlim(0, 1000) # histogram04.png

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
mode(gender_income) # "list"
class(gender_income) # "data.frame"

# 소득이 있는 사람 중에서 남자는 평균 312, 여자는 평균 163만원 정도의 소득이 있는 것으로 파악된다.
gender_income

# help(ggplot)   help(geom_col)    help(ggtitle)
# geom_col() : 집계 데이터에서 막대 그래프를 그려 주는 함수

ggplot(data=gender_income, aes(x=gender, y=mean_income, color=gender, fill=gender)) + geom_col() + ggtitle('성별 월급 평균')
# 성별 월급 평균.png