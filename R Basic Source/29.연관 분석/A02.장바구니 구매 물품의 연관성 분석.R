# install.packages("arules")
library(arules)

tran = read.transactions("tran.txt", format="basket", sep=",")
tran

inspect(tran) # transaction 데이터 보기

image(tran)

# 규칙 발견
# 지지도와 신뢰도가 높을 수록 발견되는 규칙의 수는 적어진다.
rule= apriori(tran, parameter = list(supp=0.3, conf=0.1)) # 16개 규칙
rule= apriori(tran, parameter = list(supp=0.1, conf=0.1)) # 35개 규칙


sink('tran_result.txt')
inspect(rule) # 연관 규칙 결과 확인하기
sink()
#      lhs            rhs    support   confidence lift  count
# … 중략
# [12] {맥주}      => {고기} 0.1666667 0.5000000  0.750 1
# … 중략
# [30] {라면,맥주} => {우유} 0.1666667 1.0000000  1.200 1
# … 중략

# 부연 설명
# 맥주 → 고기의 조합의 거래는 [12]번에서 확인할 수 있다.
# 지지도는 0.1666667인데, [16]번이나 [18]번에 비하여 값이 적다.
# 즉, 해당 조합으로 판매되는 경우의 수가 다른 것보다 상대적으로 적다는 의미이다.
# 맥주를 구매하는 사람은 대체적으로 고기를 잘 사지 않는다.

# 라면, 맥주 → 고기의 조합의 거래는 [30]번에서 확인할 수 있다.

# install.packages('arulesViz')
library(arulesViz)

# 조건(LHS) 이름 앞의 숫자는 그 조건으로 되어 있는 연관 규칙의 수를 의미한다. 
# 조건(LHS)에 "+"와 함께 표시된 숫자는 표시가 생략된 물품 수를 의미한다.

plot(rule, method='grouped')

plot(rule, method='scatterplot')