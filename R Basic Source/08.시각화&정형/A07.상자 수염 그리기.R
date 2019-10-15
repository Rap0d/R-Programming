v1 <- c(10, 12, 15, 11, 20)
v2 <- c(5, 7, 15, 8, 9)
v3 <- c(11, 20, 15, 18, 13)

boxstats <- boxplot(v1, v2, v3, col=c('blue', 'yellow', 'pink'), 
	names=c('Blue', 'Yellow', 'Pink'), horizontal=T)

# $stats
# $stats에서 v1을 살펴 보면 중앙값이 12이고, 최대 값은 20이다.
#      [,1] [,2] [,3]
# [1,]   10    5   11
# [2,]   11    7   13
# [3,]   12    8   15
# [4,]   15    9   18
# [5,]   20    9   20
# 
# $n : 각 그룹 마다 도수가 5이다.
# [1] 5 5 5
# 
# $conf : 신뢰 구간(confidence level)
#          [,1]     [,2]     [,3]
# [1,]  9.17361 6.586805 11.46701
# [2,] 14.82639 9.413195 18.53299
# 
# $out는 $group과 같이 보도록 할 것
# $out : 15라는 값이 이상치 정보인데 2그룹에 들어 있다.
# [1] 15
# 
# $group
# [1] 2
# 
# $names
# [1] "Blue"   "Yellow" "Pink"  


# v2를 살펴 보면 유독 큰 값이 15가 이상치이다.
boxstats <- boxplot(v1, v2, v3, col=c('blue', 'yellow', 'pink'), 
                    names=c('Blue', 'Yellow', 'Pink'))
