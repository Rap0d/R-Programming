# 변수 member에 member2.csv 파일 내용을 저장하세요.
# 변수 board에 board2.csv 파일 내용을 저장하세요.
# ---------------------------------------------------------------------------------
# 변수 member
# 성별 컬럼을 이용하여 성별2 컬럼을 리코딩하시오.
# 1:남자, 2:여자
# 
# 적립포인트 컬럼을 이용하여 적립포인트2 컬럼을 리코딩하시오.
# 포인트가 200이상이면 우수고객, 이하이면 일반고객이다.
# ---------------------------------------------------------------------------------
# 변수 board
# 조회수 컬럼을 이용하여 조회수2 컬럼을 리코딩하시오.
# 조회수2 컬럼 : 조회수가 3이상이면 '좋음', 3미만이면 '나쁨'으로 표현하도록 한다.
# 
# plyr 패키지를 이용하여 2개의 변수(member, board)를 병합하시오.
# 
# newdata 변수에 회원 이름별로 조회수의 평균과 적립 포인트의 토탈 금액을 구하시오.
# 
# newdata 변수를 이용하여 가로 막대 그래프를 그리시오.
# 단, 조회수의 평균은 수치 100*을 곱하여 그리도록 한다.
# 
# 일련 번호가 1이거나 3인 데이터만 조회하되, 이름 급여 작성 일자만 조회하시오.
# 단, 일련 번호의 역순으로 조회하시오.

member = read.csv("member2.csv", header=TRUE)
board = read.csv("board2.csv", header=TRUE)

member$성별2[member$성별 == 1] <- "남자"
member$성별2[member$성별 == 2] <- "여자"

member$적립포인트2[member$적립포인트 >= 200] <- "우수고객"
member$적립포인트2[member$적립포인트 < 200] <- "일반고객"

board$조회수2[board$조회수 >= 3] <- "좋음"
board$조회수2[board$조회수 < 3 ] <- "나쁨"

library( plyr )
result <- join(member, board, by='아이디')

result

newdata <- ddply(result, .(이름), summarise, 
	조회수평균 = 100 * mean(조회수), 적립포인트토탈 = sum(적립포인트)
)
newdata

newname <- newdata['이름']
newname

mychart <- newdata[c('조회수평균','적립포인트토탈')]
class(mychart)
mychart <- as.matrix(mychart)

barplot( mychart, beside=T, horiz=T, main='차트 그리기', col=rainbow(4) )

install.packages('dplyr')
library(dplyr)

result %>% arrange( desc(일련번호)) %>% filter( 일련번호 %in% c(1, 3)) %>% select(일련번호, 이름, 급여, 작성일자) 
