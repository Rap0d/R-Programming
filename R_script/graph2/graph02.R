par(family = 'D2Coding')
std <- read.csv('R_data/191015/students_height.csv')
std
traffic <- read.csv('R_data/191015/교통 사고 데이터.csv')
traffic

h <- std$키
num <- std$번호
range(h)

histinfo <- hist(h)
histinfo <- hist(h, freq = T)
histinfo

# density의 합 // 확률 밀도의 총 합
totalsum <- sum(histinfo$density)
totalsum

# 계급 * 확률 밀도의 총합 
all_prop <- sum(totalsum * 5)
all_prop

histinfo <- hist(h, breaks = 10)
histinfo <- hist(h, breaks = 20)

custom_brk <- seq(150, 190, 5)
custom_brk

histinfo <- hist(h, breaks = custom_brk)

histinfo <- hist(h, breaks = 10, main = '학생들의 키', col = rainbow(50), xlab = 'Height', ylab = 'Frequency', xlim = c(155, 190))

# 경상자 수로 히스토그램 생성
vict <- table(traffic$경상자수)
vict

victinfo <- hist(vict)

