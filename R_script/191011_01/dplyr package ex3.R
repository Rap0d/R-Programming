# dplyr와 plyr의 순서 문제로 인해 detach가 선행 
detach("package:plyr", unload = TRUE)
detach("package:dplyr", unload = TRUE)

# plyr가 dplyr보다 빠르게 로드해야함 
library(plyr)
library(dplyr)

setwd('../../R_data/')
prog <- read.csv('progbook.csv', header = T)
prog

# between
# filter(prog, between(column, 하한값, 상한값))
# qty가 5이상 7이하 데이터를 조회

filter(prog, between(qty, 5, 7))

# top_n : 상위 n개만 가져오기
# top_n(prog, 4, qty)

# case_when
# mutate(result = case_when(조건1 ~ 내용1, 조건2 ~ 내용2, ..., T ~ 기타 등등))
# price가 12000이상은 high, 6000이상은 middle, 나머지는 low로 표현
ex0 <- prog %>% mutate(result = case_when(price >= 12000 ~ 'high', price >= 6000 ~ 'middle', T ~ 'low' ))
ex0

prog$name

# 프로그램별 판매 수량의 합과 총 판매 금액을 구하세요.
ex1 <- prog %>% group_by(name) %>% summarise(qsum = sum(qty, na.rm = T), psum = sum(qty*price, na.rm = T))
ex1

# 프로그램별 최대 판매 수량과 최소 판매 금액을 구하세요.
ex2 <- prog %>% group_by(name) %>% summarise(mxq = max(qty, na.rm = T), mip = min(qty*price, na.rm = T))
ex2

# 년도별, 프로그램 최대 판매 수량과 최소 금액을 구하세요.
ex3 <- prog %>% group_by(year) %>% summarise(mxq = max(qty, na.rm = T), mip = min(qty*price, na.rm = T))
ex3

# 프로그램 판매 수량의 합과 ////////////////////////////비율을 구하세요.
# 비율 : 판매수량/전체판매수량
ex4 <- ddply(prog, .(name), transform, sumqty = sum(qty), percent = qty/sum(qty))
ex4
