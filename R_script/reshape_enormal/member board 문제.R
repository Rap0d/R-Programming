# 변수 member에 member2.csv 파일 내용을 저장하세요.
# 변수 board에 board2.csv 파일 내용을 저장하세요.
setwd('../../R_data/191014/')
member <- read.csv('member2.csv')
board <- read.csv('board2.csv')
member
board
# ---------------------------------------------------------------------------------
#   변수 member
# 성별 컬럼을 이용하여 성별2 컬럼을 리코딩하시오.
# 1:남자, 2:여자
# 
sort(member$성별)
member$gender2[member$성별 == 1] <- 'Male'
member$gender2[member$성별 == 2] <- 'Female'
member$gender2

# 적립포인트 컬럼을 이용하여 적립포인트2 컬럼을 리코딩하시오.
# 포인트가 200이상이면 우수고객, 이하이면 일반고객이다.
sort(member$적립포인트)
member$vip[member$적립포인트 < 200] <- '일반고객'
member$vip[member$적립포인트 >= 200] <- '우수고객'
member$vip

member

# ---------------------------------------------------------------------------------
#   변수 board
# 조회수 컬럼을 이용하여 조회수2 컬럼을 리코딩하시오.
# 조회수2 컬럼 : 조회수가 3이상이면 '좋음', 3미만이면 '나쁨'으로 표현하도록 한다.
# 
sort(board$조회수)
board$good[board$조회수 >= 3] <- 'Good'
board$good[board$조회수 < 3] <- 'Bad'
board$good

# plyr 패키지의 join 함수를 이용하여 result 변수에 2개의 변수(member, board)를 병합하시오.
# 
library(plyr)
res <- join(member, board, by='아이디')
res

# 앞서 구한 result 변수와 ddply 함수를 이용하여 newdata 변수를 만드세요.
# newdata 변수에는 회원 이름별로 조회수의 평균과 적립 포인트의 토탈 금액을 구하시오.
newdata <- ddply(res, .(이름), summarise, 조회수평균 = mean(조회수, na.rm = T), 적립포인트총합 = sum(적립포인트, na.rm = T))
newdata

# newdata 변수를 이용하여 가로 막대 그래프를 그리시오.
# 단, 조회수의 평균은 수치 100*을 곱하여 그리도록 한다.
# 
library(ggplot2)
barplot(newdata$조회수평균 * 100, horiz = T)

# 일련 번호가 1이거나 3인 데이터만 조회하되, 이름 급여 작성 일자만 조회하시오.
# 단, 일련 번호의 역순으로 조회하시오.
res
filter(res, 일련번호 %in% c(1, 3)) %>% arrange(desc(일련번호)) %>% select(이름, 급여, 작성일자)

