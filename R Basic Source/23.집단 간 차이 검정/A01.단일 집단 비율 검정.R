# 연구 환경
# 작년 전화 고객을 대상으로 불만율을 조사했더니 불만율이 20%였다.
# 올해 150명의 고객을 대상으로 CS 교육을 시행하였더니 불만이 있는 사람은 14명이었다.
# 올해 불만율이 기존의 20%보다 불만율이 낮아 졌다고 볼 수 있는가?
#   참고 사항 : survey 컬럼(0은 불만, 1은 만족)

# 단일 표본의 빈도 수와 기술 통계량
data <- read.csv('one_sample.csv', header=T)
head(data)
survey <- data$survey

# 가설
# 귀무 가설 : 작년의 고객 불만율과 금년의 고객 불만율에 차이가 없다.
# 대립 가설 : 작년의 고객 불만율과 금년의 고객 불만율에 차이가 있다.

table( survey ) # 0 : 불만족(14), 1 : 만족(136) 
#   0   1 
#  14 136 

# Hmisc 패키지 : 빈도와 비율 기술 통계량 정보를 한 꺼번에 보여 줄수 있는 패키지 
install.packages('Hmisc')
library(Hmisc)

Hmisc::describe(survey)

# prettyR : 패키지를 이용한 빈도 수와 비율 계산
install.packages('prettyR')
library(prettyR)

freq( survey )
# Frequencies for survey 
#         1    0   NA
#       136   14    0
# %    90.7  9.3    0 
# %!NA 90.7  9.3 

# 이항 분포 비율 검정
# 136명의 만족 고객이 전체의 80% 이상의 만족율을 나타내는 지를 위해서 0.8을 지정한다.
binom.test(136, 150, p=0.8) # 또는binom.test(c(136, 14), p=0.8)   
#         Exact binomial test
# 
# data:  c(136, 14)
# number of successes = 136, number of trials = 150, p-value = 0.0006735
# alternative hypothesis: true probability of success is not equal to 0.8
# 95 percent confidence interval:
#  0.8483615 0.9480298
# sample estimates:
# probability of success 
# 0.9066667

0.0006735 > 0.05

# 풀이 하기
# 유의 확률 p-value(0.0006735) < 0.05이므로 귀무 가설을 기각한다.
# 즉, '작년과 올해의 불만율에 차이가 있다'라고 말할 수 있다.