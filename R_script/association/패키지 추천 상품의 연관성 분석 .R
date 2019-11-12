# install.packages('arules')
library(arules)

# install.packages('arulesViz')
library(arulesViz)

# 단계 : 실습 데이터 읽기
tran <- read.transactions('mybasket.csv', format='basket', sep=',')

tran # 행과 컬럼 구조를 알려 준다.

summary(tran) # 데이터들의 기술 분석 결과를 보여 준다.
# clothes가 386건, snack이 373건으로 가장 많이 거래가 되었다.

# transactions as itemMatrix in sparse format with
#  786 rows (elements/itemsets/transactions) and
#  10 columns (items) and a density of 0.3049618 
# 
# most frequent items:
# clothes   snack    deco  bakery  frozen (Other) 
#     386     373     358     337     318     625 
# 
# element (itemset/transaction) length distribution:
# sizes
#   1   2   3   4   5   6   7   8   9 
# 209 166 147 101  57  48  33  18   7 
# 
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#    1.00    1.00    3.00    3.05    4.00    9.00 
# 
# includes extended item information - examples:
#    labels
# 1 alcohol
# 2  bakery
# 3 clothes

# 개괄적인 현황을 플로팅을 통하여 그림으로 보여 준다.
image( head(tran) )
image(tran)
# savePlot('개괄적인 현황.png', type='png')

# 단계 : 알고리즘 적용
myframe <- as(tran, 'data.frame')
myframe

# apriori 알고리즘을 이용하여 rules 객체에 저장
rules <- apriori(tran, parameter=list(supp=0.2, conf=0.1))
sink('mybasket.csv.txt')
inspect( rules )
sink()

# 제품은 희소 행렬에 알파벳 순으로 정렬이 되어 있다.
# alcohol은 39.57%, bakery는 42.87% 정도 거래 되었다.
itemFrequency(tran)

itemFrequencyPlot(tran, support = 0.1)

itemFrequencyPlot(tran, topN = 10, ylim=c(0, 0.5), col=rainbow(10))

# 정렬
inspect(sort(rules, by = "lift", decreasing = FALSE))

inspect(sort(rules, by = "lift", decreasing = TRUE))

inspect(sort(rules, by = c("lift", "support"), decreasing = c(TRUE, FALSE)))

# 안되는 듯..
inspect(sort(rules, by = c("lift", "support"), decreasing = c(TRUE, TRUE)))

# 슬라이싱
inspect(sort(rules, by = "lift")[1:5])

# 필터링
subset_rules <- subset(rules, items %in% "frozen")

inspect(rules) # 원본 갯수 확인
inspect(subset_rules) # 필터링된 것 갯수 확인

filter01 <- subset(rules, rhs %in% 'frozen') 
filter01 
inspect(filter01) # 규칙 확인
plot(filter01, method="graph")
plot(filter01, method="scatterplot") 

# %pin% : ~ 가 포함된 규칙만....
filter02 <- subset(rules, rhs %pin% 'o') # 알파벳 o가 포함되어 있는 ....
filter02 # set of 10 rules
inspect(filter02) # 규칙 확인

filter03 <- subset(rules, lhs %in% c('snack','frozen')) 
filter03 # set of 4  rules
inspect(filter03) # 규칙 확인
plot(filter03, method="graph") 

# 지지도와 신뢰도, 향상도에 대한 산포도 그래프
plot(rules, method='scatterplot')
# savePlot('패키지 추천 산포도 그래프.png', type='png')

# 가로축(조건 : X 아이템)과 세로축(결과 : Y 아이템)
plot(rules, method='grouped')
# savePlot('패키지 추천 매트릭스 그래프.png', type='png')

# 각 규칙별로 어떠한 아이템들이 연관되어 있는가를 보여 주는 네트워크 그래프
plot(rules, method='graph', control=list(types='items'))
# savePlot('패키지 추천 네트워크 그래프.png', type='png')

# 팝업창을 띄워 준다.
plot(rules, method='graph', interactive= TRUE, control = list(type='items'))
# savePlot('패키지 추천 네트워크 팝업 그래프.png', type='png')

# CSV 파일에 규칙 쓰기
write(rules, file = "myrules.basket.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# 규칙들을 데이터 프레임으로 변환
rules_df <- as(rules, "data.frame")
str(rules_df)
rules_df


# 단계 : 연관 규칙 해석
# 단일 item에서 발생 확률이 가장 높은 아이템은 ?
# 단일 item에서 발생 확률이 가장 낮은 아이템은 ?
# 가장 발생 가능성이 높은 <2개 상품 간>의 연관 규칙?
# 가장 발생 가능성이 높은 <2개 상품 이상에서> <3개의 상품으로>의 연관 규칙?
