# 귀무 가설 : 학생들의 평균 키는 145.0cm이다.

myheight <- read.csv('myheight.csv', header=T)

# install.packages('Hmisc')
library(Hmisc)

# install.packages('prettyR')
library(prettyR)

myheight$height # 키(신장) 정보
mean(myheight$height) # 키의 평균
unique(myheight$height)
range(myheight$height) # 키의 범위
# [1] 140 165

myheight5 <- subset( myheight, height != 999, c(height))
myheight5

mean(myheight5$height) # 키의 평균

range(myheight5$height) # 키의 범위
# [1] 140 165

describe( myheight5 ) # 기술 통계량 분석 결과 보기
# Description of myheight5 
#  Numeric 
#          mean median  var   sd valid.n
# height 149.77    150 23.5 4.85      30

describe( myheight5$height )
# Description of structure(list(x = c(148L, 150L, 149L,... 중략

#  Numeric 
#     mean median  var   sd valid.n
# x 149.77    150 23.5 4.85      30

# shapiro.test : 데이터 분포가 정규 분포를 이루고 있는 지를 검정해주는 분석 함수
shapiro.test(myheight5$height)
#         Shapiro-Wilk normality test
# 
# data:  myheight5$height
# W = 0.90777, p-value = 0.01308

# 유의 확률 p-value = 0.01308 < 0.05 이므로 귀무 가설을 기각한다.
# 즉, 모집단의 평균 값을 검정할 수 있다.


# help(t.test)
t.test( myheight5$height, mu = 145.0 )
#         One Sample t-test
# 
# data:  myheight5$height
# t = 5.3862, df = 29, p-value = 8.674e-06
# alternative hypothesis: true mean is not equal to 145
# 95 percent confidence interval:
#  147.9567 151.5766
# sample estimates:
# mean of x 
# 149.7667
# 부연 설명
# 유의 확률 p-value = 8.674e-06 < 0.05 이므로 귀무 가설을 기각한다.
# 학생들의 평균 키는 145.0와 차이가 있다.(동일하지 않다.)

t.test( myheight5$height, mu = 145.0, alter='greater', conf.level = 0.95 )
# 
#         One Sample t-test
# 
# data:  myheight5$height
# t = 5.3862, df = 29, p-value = 4.337e-06
# alternative hypothesis: true mean is greater than 145
# 95 percent confidence interval:
#  148.263     Inf
# sample estimates:
# mean of x 
# 149.7667
# 부연 설명
# 유의 확률 p-value = 4.337e-06 < 0.05 이므로 귀무 가설을 기각한다.
# 학생들의 평균 키는 145.0 보다 크다고 볼 수 있다.