students <- read.csv('students_height.csv', header = TRUE)

height <- students$키
range(height)
# help(hist)

# freq : 명시하지 않거나 freq=TRUE이면 빈도 수로 보여준다.
histinfo <- hist(height)
histinfo <- hist(height, freq=TRUE)

# FALSE이면 확률 밀도로 보여 준다.
histinfo <- hist(height, freq=FALSE)

histinfo
histinfo$breaks # 계급의 상하한값
histinfo$counts # 계급 구간의 갯수
histinfo$density # 계급 구간의 확률 밀도
histinfo$mids # 계급의 중앙값

# 확률 밀도의 총합
totalsum <- sum(histinfo$density)
totalsum

# 계급 * 확률 밀도의 총합 = 1.0
all_prop <- totalsum * 5
all_prop # 1.0

# breaks : 막대의 간격 조정
histinfo <- hist(height, breaks=10)
histinfo <- hist(height, breaks=20)

custom_brk <- seq(150, 190, 5)
histinfo <- hist(height, breaks=custom_brk)

mycolor <- rainbow(15)
histinfo <- hist(height, breaks=10, main='학생들의 키', 
	xlim=c(155, 190), col=mycolor, xlab='키(cm)', ylab='도수')