dataA = c(1:5)
dataB = c(8, 6, 9, 10, 5)

result = cbind(dataA, dataB)
result

sortB = sort(dataB)
sortB

dataB # 원본은 변동 없음

rev_sort_b <- sort(dataB, decreasing = TRUE)
rev_sort_b

# 전체 데이터에서 dataB 컬럼에 대한 오름차순 정렬
order_b <- order(dataB)
order_b

sort_result <- result[order_b,]
sort_result

result

# 전체 데이터 셋에 대하여 dataA 컬럼에 대하여 역순으로 정렬해보세요.
ordering <- order(dataA, decreasing = TRUE)
ordering 

sort_result <- result[ordering,]
sort_result

somedata = c(1, 2, 2, 3)

# 동일한 값에 대해 평균을 내어 랭크를 매긴다. 
rank( somedata )

# ties.method : 동일한 값에 대한 랭크를 매기는 방법
## min : 최소값을 기준으로 랭크를 준다. 
rank( somedata, ties.method = 'min' )
## random : 동알한 값을 랜덤으로 랭크를 매긴다. 
rank( somedata, ties.method = 'random' )

help(rank)