setwd('../06.data processing/')

member <- read.csv('member.csv', header = T)
member

board <- read.csv('board.csv', header = T)
board

# col name 확인 
colnames(member)
colnames(board)

help(merge)

# merge 함수의 사용, 기본 옵션은 inner join
result <- merge(member, board, by = '아이디')
result

# merge 함수의 all 옵션, ouuer join
result <- merge(member, board, by = '아이디', all = T)
result

library(plyr)
# join 함수의 기본값은 left outter join
result <- join(member, board, by = '아이디')
result

# full : 기본값과 같음, inner : inner join
result <- join(member, board, by = '아이디', type = full)
result
result <- join(member, board, by = '아이디', type = inner)
result

# groupping을 할 수 있는 tapply 함수
tapply(member$급여, member$성별, mean)

# 성별로 적립 포인트의 합
tapply(member$적립포인트, member$성별, sum)

help(ddply)
# ddply(대상, 그룹핑할 컬럼, summarise, 데이터1, 데이터2)
# summarise : 그룹핑한 컬럼만 따로 빼서 출력 
result <- ddply(member, .(성별), summarise, meanData = mean(급여), sumData = sum(급여))
result

# ddply(대상, 그룹핑할 컬럼, transform, 데이터1, 데이터2)
# transform : 기존 테이블에 그룹핑한 컬럼 추가
# transform의 예제는 대부분 percent 구하는 것 
# percent : 해당 그룹 내에서의 비율
result <- ddply(member, .(성별), transform, meandata = mean(급여), sumData = sum(급여), percent = 급여/sum(급여))
result
