data = read.csv("three_sample.csv", header=TRUE)
head(data)

# 데이터 정제 및 전처리
method = data$method
survey = data$survey

unique( method )  # 교육 방식 3가지
# survey 0이면 불만족, 1이면 만족
unique( survey ) # 1 0

method ; survey

# 빈도 분석을 위한 기술 통계량을 구해 본다.
# 비율 검정을 위한 데이터 셋을 대상으로 필요한 기술 통계량을 계산한다.
table(method, useNA="ifany")
# 3그룹 모두 관찰치 50개이다.

# 교육 방법과 만족도 교차 분할표
table(method, survey, useNA="ifany")
#         survey
# method  0  1
#         1 16 34 # 방법 1(불만족 16, 만족 34)
#         2 13 37 # 방법 2(불만족 13, 만족 37)
#         3 11 39 # 방법 3(불만족 11, 만족 39)

# 세 집단 비율의 차이를 검정하기 위하여 prop.test() 함수를 사용한다.
# c(34,37,39) : 방법1, 방법2, 방법3에 대한 만족도 숫자이다.
# c(50,50,50) : 세가지 교육 방법에 대한 변량의 길이이다.

prop.test(c(34,37,39), c(50,50,50))
#         3-sample test for equality of proportions without continuity correction
# data:  c(34, 37, 39) out of c(50, 50, 50)
# X-squared = 1.2955, df = 2, p-value = 0.5232
# alternative hypothesis: two.sided
# sample estimates:
# prop 1 prop 2 prop 3
#   0.68   0.74   0.78

# p-value = 0.5232 > 0.05이므로, 귀무 가설을 채택한다.
# 세 교육 방법에 따른 집단간 만족도에 차이가 없다.