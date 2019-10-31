data <- read.csv('two_sample.csv', header=T)
head(data)

unique(data$method) # 1 2
unique(data$survey) # 1 0

# 두 집단의 subset 작성과 교차 분석 수행하기
method <- data$method # 교육 방법(1, 2) → NA 없음
survey <- data$survey # 만족도(1 : 만족, 0 : 불만족)

# "교육 방법"에 대한 빈도수 확인
table( method ) # 집단별 빈도 분석

table( survey ) # "만족도"에 대한 빈도수 확인

# 두 변수에 대한 교차 분석
# useNA='ifany'는 결측치까지 출력을 해주는 옵션이다.
table(method, survey, useNA = 'ifany')
tbl <- table(method, survey, useNA = 'always')

addmargins(tbl)

# 두 집단 비율의 차이를 검정해보도록 한다.
# c(110, 135)는 교육 방법에 대한 만족 수이고,
# c(150, 150)는 변량의 길이이다.

prop.test(c(110, 135), c(150, 150))
#         2-sample test for equality of 
#              proportions with continuity correction
#
# data:  c(110, 135) out of c(150, 150)
# X-squared = 12.824, df = 1, p-value = 0.0003422
# alternative hypothesis: two.sided
# 95 percent confidence interval:
#  -0.25884941 -0.07448392
# sample estimates:
#    prop 1    prop 2
# 0.7333333 0.9000000

0.0003422 > 0.05 # FALSE