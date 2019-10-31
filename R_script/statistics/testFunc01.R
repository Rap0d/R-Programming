# Hmisc 의 선행 패키지
# 필요한 패키지를 로딩중입니다: lattice
# 필요한 패키지를 로딩중입니다: survival
# 필요한 패키지를 로딩중입니다: Formula
# 필요한 패키지를 로딩중입니다: ggplot2
library(Hmisc)
library(prettyR)

# 집단간 차이 분석

df <- read.csv("one_sample.csv", header = T)
head(df)

survey <- df$survey

# 귀무 가설 : 작년의 고객 불만율과 금년의 고객 불만율에 차이가 없다.
table(survey)

describe(survey)
freq(survey)

# 첫번째 매개변수는 긍정 변수
# 두번째는 전체(긍정136+부정14)
# p는 80퍼 센트 이상인가?
# n만큼 시행했는데 x의 값이 n의 p퍼센트 이상이니?
binom.test(x=136, n=(14+136), p=0.8)
# Exact binomial test
# 
# data:  136 and (14 + 136)
# number of successes = 136, number of trials = 150, p-value = 0.0006735
# alternative hypothesis: true probability of success is not equal to 0.8
# 95 percent confidence interval:
#   0.8483615 0.9480298
# sample estimates:
#   probability of success 
# 0.9066667 

# probability of success : 점 추정 값.
# 0.9066667 

# 귀무가설을 기각 한다.
# P의 값 0.0006735
0.0006735 > 0.05
# [1] FALSE
# 결과 : 작년의 고객 불만율과 금년의 고객 불만율에 차이가 있다!

# 다른 방법
## x : success
## n : 시행 횟수
## p : 비율
## alternative : 대립 가설의 형태
### two.sided : 양측 검정
## conf.level : 신뢰도 구간
result <- binom.test(x=136, n=(14+136), p=0.8, alternative = 'two.sided', conf.level = 0.95)
names(result)

if(result$p.value > 0.05) {
  cat("귀무 가설 채택\n")
} else {
  cat("귀무 가설 기각\n")
}