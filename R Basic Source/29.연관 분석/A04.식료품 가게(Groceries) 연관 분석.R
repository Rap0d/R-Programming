# 연관 규칙을 사용하기 위한 패키지
# install.packages('arules')
library(arules)

# Groceries 데이터 셋 가져 오기
data("Groceries")
str(Groceries)
Groceries
# transactions in sparse format with
#  9835 transactions (rows) and
#  169 items (columns)
# items은 열(column)을 의미한다.
# transactions은 행(row)을 의미한다.

mode(Groceries)#"S4"
class(Groceries)
# [1] "transactions"
# attr(,"package")
# [1] "arules"

# help(as)
# data frame 형으로 변환
Groceries.df <- as(Groceries, 'data.frame')

str( Groceries.df)
# 'data.frame':   9835 obs. of  1 variable:
#  $ items: Factor w/ 7011 levels "{abrasive cleaner,n…

head( Groceries.df)
#   items
# 1 {citrus fruit,semi-finished bread,margarine,ready soups}
# 2 {tropical fruit,yogurt,coffee}
# 3 {whole milk}
# 4 {pip fruit,yogurt,cream cheese ,meat spreads}
# 5 {other vegetables,whole milk,condensed milk,long life bakery product}
# 6 {whole milk,butter,yogurt,rice,abrasive cleaner}

# 출력 결과의 2 항목을 보면 적도 과일(tropical fruit)을 구입할 때 yogurt랑 coffee를 구입했다.

tail( Groceries.df)
# help(apriori)
# 지지도 : 0.001, 신뢰도 : 0.8 적용 규칙 발견
rules = apriori(Groceries, parameter=list(supp=0.001, conf=0.8))
# ... 중략
# writing ... [410 rule(s)] done [0.00s].

mode(rules)
class(rules)

# 발견된 규칙 확인하기
# LHS :  left-handed side
# 하나의 규칙은 A상품(LHS_왼쪽에 있는 것) → B상품(RHS_오른쪽에 있는 것) 형식으로 표현이 된다.
inspect(head(rules))
inspect(rules)
#     lhs                                 rhs            support     confidence lift      count
# [1] {liquor,red/blush wine}          => {bottled beer} 0.001931876 0.9047619  11.235269 19
# [2] {curd,cereals}                   => {whole milk}   0.001016777 0.9090909   3.557863 10
# [3] {yogurt,cereals}                 => {whole milk}   0.001728521 0.8095238   3.168192 17
# [4] {butter,jam}                     => {whole milk}   0.001016777 0.8333333   3.261374 10
# [5] {soups,bottled beer}             => {whole milk}   0.001118454 0.9166667   3.587512 11
# [6] {napkins,house keeping products} => {whole milk}   0.001321810 0.8125000   3.179840 13

# install.packages('arulesViz')
library(arulesViz)

# 규칙을 구성하는 왼쪽 -> 오른쪽의 item 빈도수 보기
# grouped : 좌측을 lhs, 우측을 rhs 형식으로 보여 준다.
# help(plot) : arulesViz 패키지에 들어 있는 plot 함수이다.
plot(rules, method='grouped')
# 그래프에서 원의 크기는 지지도(support)를 의미하고, 색상은 향상도(lift)를 의미한다.
# RHS(규칙을 구성하는 오른쪽)의 빈도수가 가장 많은 것은 "whole milk"(전지유:지방을 제거하지 않은 우유)이다.
# 두 번째로 많은 것은 "other vegetables"로 나타났다.
# 연관 규칙 시각화 결과.png

# 최대 길이 3이내로 규칙을 생성해보기
# maxlen = lhs 수와 rhs의 수를 합친 길이
rules = apriori(Groceries, parameter=list(supp=0.001, conf=0.8, maxlen=3))
head(inspect(rules))
#  규칙을 구성하는 lhs와 rhs의 길이를 합쳐서 3이하의 규칙만 생성하면 29개로 현저하게 줄어 든다.

# 신뢰도(confidence)를 기준으로 내림차순 정렬
# help(sort) : arules 패키지에 들어 있는 함수이다.
rules <- sort(rules, descreasing=T, by='confidence')
inspect(head(rules))
# lhs                                           rhs                support     confidence lift     count
# [1] {rice,sugar}                               => {whole milk}       0.001220132 1          3.913649 12   
# [2] {canned fish,hygiene articles}             => {whole milk}       0.001118454 1          3.913649 11   
# [3] {root vegetables,butter,rice}              => {whole milk}       0.001016777 1          3.913649 10   
# [4] {root vegetables,whipped/sour cream,flour} => {whole milk}       0.001728521 1          3.913649 17   
# [5] {butter,soft cheese,domestic eggs}         => {whole milk}       0.001016777 1          3.913649 10   
# [6] {citrus fruit,root vegetables,soft cheese} => {other vegetables} 0.001016777 1          5.168156 10   

plot(rules, method='graph', control=list(type='items'))
# Groceries 연관 규칙 시각화.png
# whole milk(전지유)와 other vegetables 단어를 중심으로 연관어가 형성이 되어 있는 것을 확인할 수 있다.

# 특정 상품(item)으로 서브 셋 작성과 시각화
# 오른쪽 item이 전지분유(whole milk)인 규칙만 서브 셋으로 작성
# help(subset)
wmilk <- subset(rules, rhs %in% 'whole milk')
wmilk # set of 18 rules
inspect(wmilk) # 규칙 확인
plot(wmilk, method="graph") # 연관 네트워크 그래프 01.png

# 오른쪽 item이 other vegetables인 규칙만 서브 셋으로 작성
oveg <- subset(rules, rhs %in% 'other vegetables') # lhs : 왼쪽 item
oveg # set of 10 rules
inspect(oveg) # 규칙 확인
plot(oveg, method="graph") #  연관 네트워크 그래프 02.png
plot(oveg, method="scatterplot") # 지지도와 신뢰도를 산점도로 보여 주기

# 오른쪽 item이 vegetables 단어가 포함된 규칙만 서브 셋으로 작성
veg <- subset(rules, rhs %pin% 'vegetables') # 포함 문자
veg # set of 10 rules
inspect(veg) # 규칙 확인

# 왼쪽 item이 butter or yogurt인 규칙만 서브 셋으로 작성
butter_yogurt <- subset(rules, lhs %in% c('butter','yogurt')) # lhs : 왼쪽 item
butter_yogurt # set of 4  rules
inspect(butter_yogurt) # 규칙 확인
plot(butter_yogurt, method="graph") 
#  연관 네트워크 그래프 03.png