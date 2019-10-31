# 귀무 가설 : 홍보 이벤트 전/후의 구매 비율은 차이가 없다.

mytooth <- read.csv('mytooth.csv', header=TRUE)
dim(mytooth)
str(mytooth)
head(mytooth)

# Hmisc 패키지 : 빈도와 비율 기술 통계량 정보를 한 꺼번에 보여 줄수 있는 패키지 
install.packages('Hmisc')
library(Hmisc)

describe(mytooth)
describe(mytooth$buy)

# buy : 구매 여부 컬럼(1 : 구매, 0 : 비구매)
mytable <- table(mytooth$buy) # 빈도 수 출력하기

result <- prop.table(mytable)
result

pctresult <- round(100 * result, 2)
pctresult

# 구매 여부 컬럼에 대한 빈도와 비율을 data frame으로 만들었다.
buytable <- data.frame(Freq=c(mytable), Prop=c(pctresult))
buytable

# prettyR 패키지
freq(mytooth)

freq(mytooth$buy)

# 일반 매장 구매 비율 10% 정도를 기준으로 검증을 실시한다.
# 여기서 10은 구매, 40은 비구매이다.
# 10이 전체의 10%라고 볼 수 있는 가?
binom.test(10, 50, p = 0.1, alternative = 'two.sided')
# 또는 binom.test(c(10, 40), p = 0.1, alternative = 'two.sided')
# Exact binomial test
# 
# data:  c(10, 40)
# number of successes = 10, number of trials = 50, p-value = 0.02969
# alternative hypothesis: true probability of success is not equal to 0.1
# 95 percent confidence interval:
#   0.1003022 0.3371831
# sample estimates:
#   probability of success 
# 0.2

0.02969 > 0.05 # FALSE
# p-value = 0.02969 < 0.05이므로, 귀무 가설을 기각한다.
# 따라서, 홍보 이벤트 전/후의 구매 비율은 차이가 있다.

# 단측 검정 : 구매 비율이 10%보다 높다고 볼 수 있는가?
binom.test(c(10, 40), p = 0.1, alternative = 'greater')
# Exact binomial test
# 
# data:  c(10, 40)
# number of successes = 10, number of trials = 50, p-value = 0.02454
# alternative hypothesis: true probability of success is greater than 0.1
# 95 percent confidence interval:
#   0.1127216 1.0000000
# sample estimates:
#   probability of success 
# 0.2 

# p-value = 0.02454 < 0.05이므로, 귀무 가설을 기각한다.
# 따라서, 이번 홍보 이벤트는 효과가 있었다.