# install.packages('plyr')
library(plyr)
library(dplyr)

programming <- read.csv('progbook.csv', header=T)
programming 

programming$qty
result <- filter( programming, between(qty, 5, 7))
result

# x : 처리할 데이터, n : 추출할 숫자, wt : 정렬할 컬럼
programming$qty
sort(programming$qty)
result <- top_n(programming, 4, qty)
result

result <- top_n(programming, 2, price)
result

# price이 적은 것 하위 2개
result <- programming %>% top_n(-2, price)
result

result <- programming %>% mutate( result = case_when( price >= 12000 ~ "high", price >= 6000 ~ "middle", TRUE ~ "low"))

result

# 프로그램별 판매 수량의 합과 총 판매 금액을 구하세요.
result1 <- ddply(programming, 'name', summarise, sum_qty=sum(qty), sum_price=sum(price))
result1 

result2 <- programming %>% group_by( name ) %>% summarise(sumqty=sum(qty), sumprice=sum(price))
result2

# 프로그램별 최대 판매 수량과 최소 판매 금액을 구하세요.
result1 <- ddply(programming, 'name', summarise, max_qty=max(qty), min_price=min(price))
result1 

result2 <- programming %>% group_by( name ) %>% summarise(max_qty=max(qty), min_price=min(price))
result2

# 년도별, 프로그램 최대 판매 수량과 최소 금액을 구하세요.
result1 <- ddply(programming, c('year', 'name'), summarise, max_qty=max(qty), min_price=min(price))
result1

result2 <- programming %>% group_by( year, name ) %>% summarise(max_qty=max(qty), min_price=min(price))
result2

# 프로그램 판매 수량의 합과 비율을 구하세요.
# 비율 : 판매수량/전체판매수량
result1 <- ddply(programming, 'name', transform, sum_qty=sum(qty), pct_qty=(100*qty)/sum(qty))
result1
#########################################################