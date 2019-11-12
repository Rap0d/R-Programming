library(arules)

data <- read.transactions('tran.txt', format = 'basket', sep = ',')
data

# transactions 객체 조회 
inspect(data)

# transactions 객체 시각화
image(data)

# 트랜잭션 객체를 대상으로 연관 규칙을 발견해 주는 함수
## support : 지지도
## confidence : 신뢰도
### return : rules 객체
rule <- apriori(data, parameter = list(supp = 0.1, conf = 0.1))

sink('tran_res.txt')
inspect(rule)
sink()

library(arulesViz)
# 연관성 규칙에 대한 데이터를 시각화하기 위한 패키지

par(family = 'D2Coding')
# 좌측을 연관 규칙의 조건(LHS)과 결과(RHS)를 우측으로한 그래프
plot(rule, method = 'grouped')
# 지지도와 신뢰도를 산점도
plot(rule, method = 'scatterplot')

