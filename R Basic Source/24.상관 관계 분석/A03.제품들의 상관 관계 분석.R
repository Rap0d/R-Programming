# 제품의 친밀도, 적절성, 만족도 변수 등을 대상으로 변수들 간의 상관 계수를 통해서 상관 관계 분석을 해보도록 한다.
product <- read.csv("product.csv")

head( product )

# 기술 통계량
summary( product )

# 표준 편차 : 0에 가까울수록 관측 값이 균일하다.
sd( product$closeness)
sd( product$appropriacy)
sd( product$satisfaction)

# cor() : 상관 계수를 구해준다.
# 피어슨 상관 계수를 이용하여 변수들 간의 상관 관계를 살펴 보도록 한다.
cor(product$closeness, product$appropriacy)

cor(product$closeness, product$satisfaction)

cor(product$appropriacy, product$satisfaction)

cor(product$appropriacy + product$closeness, product$satisfaction)

# 전체 변수간의 상관 계수 보기
cor(product, method='pearson')
#             closeness appropriacy satisfaction
# closeness   1.0000000   0.4992086   0.4671450
# appropriacy   0.4992086   1.0000000   0.7668527
# satisfaction   0.4671450   0.7668527   1.0000000

# 위의 예시에서 appropriacy과 satisfaction 컬럼 간의 상관 계수가 가장 높은 것(0.7668527)으로 나타난다.
# 대각선은 자기 자신과의 상관 관계를 의미한다.

# 색상으로 표현하기
# 동일한 색상으로 그룹을 표시하고, 색의 농도로 상관 계수를 나타낸다.
# install.packages('corrgram')
library(corrgram)

# corrgram 함수를 이용하여 상관 계수와 색의 농도를 이용하여 시각화 해준다.
# 만족도에 가장 영향을 미치는 변수는 적절성(0.77)이다.

# 동일 색상으로 그룹화 표시
corrgram( product )
# savePlot('동일 색상으로 그룹화 표시.png', type="png")

# 위쪽에 상관 계수 수치 추가
# 소괄호 내의 값은 신뢰 구간이다.
corrgram( product, upper.panel=panel.conf )
# savePlot('위쪽에 상관 계수 추가.png', type="png")

# 아래 쪽에 상관 계수 추가
corrgram( product, lower.panel=panel.conf )
# savePlot('아래 쪽에 상관 계수 추가.png', type="png")

# 챠트에 밀도 곡선, 상관성, 유의 확률(별표) 추가
install.packages('PerformanceAnalytics')
library(PerformanceAnalytics)

# 상관성, p값(*), 정규 분포(모수 검정 조건) 시각화
chart.Correlation( product, histogram=, pch="+")
# chart.Correlation 실행 결과.png

# 세 변수 모두 대체적으로 정규 분포 형태를  가진다.
# 유의 수준 0.05에서 세 변수 모두 상관성이 있는 것으로 나타났다.
# 만족도 변수에 가장 영향을 끼치는 변수는 적절성(0.77)으로 나타난다.