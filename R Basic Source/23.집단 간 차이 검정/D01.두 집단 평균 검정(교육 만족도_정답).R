# 귀무 가설\
# 두 가지 교육 방법에 따른 실기 시험의 평균에 차이가 없다.

# 독립 표본 평균 계산
data <- read.csv('two_sample.csv', header=T)
head(data)
summary(data) # score의 NA 갯수 : 73개

# 점수(score)가 NA가 아닌 것 중에서 method(교육 방법), score 컬럼을 읽어 온다.
result <- subset(data, !is.na(score), c(method, score))

# 정제된 데이터를 대상으로 subset 생성
result

# 데이터 분리
method01 <- subset(result, method == 1 )
method02 <- subset(result, method == 2 )

method01_score <- method01$score
method02_score <- method02$score

length( method01_score ) # 기술 통계량
length( method02_score )
mean( method01_score )
mean( method02_score )

# 동질성 검정
# 동질성 검정은 두 집단의 분포가 동일한지를 검정하는 방법이다.
# 즉, 동일한 분포를 갖는 모집단에서 추출된 것인지를 검정하는 방법 이다
# 모집단에서 추출된 표본을 대상으로 분산 동질성 검정을 수행한다.
# 동질성 검정은 stats 패키지에서 제공하는 var.test() 함수를 이용할 수 있다.

# 동질성 검정의 귀무 가설 : 두 집단간 분포의 모양이 동질적이다.

var.test( method01_score, method02_score )
#         F test to compare two variances
#
# data:  method01_score and method02_score
# F = 1.2158, num df = 108, denom df = 117, p-value = 0.3002
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#  0.8394729 1.7656728
# sample estimates:
# ratio of variances
# 1.215768

# 풀이 하기
# 검정 통계량은 p-value(0.3002) > 0.05이므로 귀무 가설을 채택한다.
# 귀무 가설을 채택하므로 두 집단간의 분포 형태가 동질하다고 볼 수 있다.

# 두 집단 평균 차이 검정 수행하기
# 양측 검정
t.test( method01_score, method02_score )
#         Welch Two Sample t-test
#
# data:  method01_score and method02_score
# t = -2.0547, df = 218.19, p-value = 0.0411
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -0.48296687 -0.01005133
# sample estimates:
# mean of x mean of y
#  5.556881  5.803390

# 풀이 하기
# 검정 통계량은 p-value(0.0411) < 0.05이므로, 귀무 가설을 기각한다.
# 즉, 두 집단간의 평균에 차이가 있는 것으로 나타났다.

# 단측 검정(크다)
t.test( method01_score, method02_score, alter='greater', conf.int=TRUE, conf.level=0.95 )
#         Welch Two Sample t-test
#
# data:  method01_score and method02_score
# t = -2.0547, df = 218.19, p-value = 0.9794
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#  -0.4446915        Inf
# sample estimates:
# mean of x mean of y
#  5.556881  5.803390

# 단측 검정(작다)
t.test( method01_score, method02_score, alter='less', conf.int=TRUE, conf.level=0.95 )
#         Welch Two Sample t-test
#
# data:  method01_score and method02_score
# t = -2.0547, df = 218.19, p-value = 0.02055
# alternative hypothesis: true difference in means is less than 0
# 95 percent confidence interval:
#         -Inf -0.04832672
# sample estimates:
# mean of x mean of y
#  5.556881  5.803390

# 독립 표본 t-검정 결과 정리 및 기술