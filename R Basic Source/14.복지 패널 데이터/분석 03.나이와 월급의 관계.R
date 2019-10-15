# 분석 03 : 나이와 월급의 관계
# 나이 정보가 없어서 birth 컬럼으로 파생 계산
class(welfare$birth)

# NA가 존재하지 않는다.
summary(welfare$birth)

qplot(welfare$birth, bins=30)
# 생일 정보.png

welfare$age <- 2015 - welfare$birth + 1
welfare$age

summary(welfare$age)
# 2세부터 109세까지 나이가 분포 되어 있다.
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 2.00   28.00   50.00   48.43   70.00  109.00

qplot(welfare$age, bins=30) # 나이 정보.png

# 나이와 월급의 관계 분석
# 소득이 있는 사람에 한하여 나이별로 평균 소득 구하기
age_income <- welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income = mean(income))

head(age_income)

ggplot(data=age_income, aes(x=age, y=mean_income)) + geom_line()
# 나이에 따른 월급의 변화.png