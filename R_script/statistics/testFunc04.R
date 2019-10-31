library(ggplot2)
library(gmodels)

# 귀무 가설 채택 여부
## param : test result
chk_test <- function(res) {
  print(res)
  cat('p value : ', res$p.value, '\n')
  if(res$p.value > 0.05) {
    cat('가설 채택', '\n')
  } else {
    cat('가설 기각 ', '\n')
  }
}

# 두 집단의 평균 검정
# 교육 만족도
## 두 가지 교육 방법에 따른 시험의 평균에는 차이가 없다.
# 연구 환경 
# 한국 교육 센터에서는 2가지 교육 방법(집체 교육, 개별 교육)을 이용하여 수업을 진행하고 있다.
# 1개월동안 교육을 받은 교육생 각 150명을 대상으로 실기 시험을 실시하였다.
# 두 집단간 실기 시험의 평균에 차이가 있는 지 검사한다.
#
# 가설
# 귀무 가설
# 두 가지 교육 방법에 따른 실기 시험의 평균에 차이가 없다.
# 
# 연구 가설 
# 두 가지 교육 방법에 따른 실기 시험의 평균에 차이가 있다.

data <- read.csv('two_sample.csv')
str(data)
summary(data)

res <- subset(data, !is.na(score), c(method, score))
# 교육방식
unique(res$method)
# 점수
range(res$score)
res

# data 분리
method01 <- subset(res, method == 1)
method02 <- subset(res, method == 2)

method01_score <- method01$score
method02_score <- method02$score

mean(method01_score)
mean(method02_score)

vt <- var.test(method01_score, method02_score)
# F test to compare two variances
# 
# data:  method01_score and method02_score
# F = 1.2158, num df = 108, denom df = 117, p-value = 0.3002
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#   0.8394729 1.7656728
# sample estimates:
#   ratio of variances 
# 1.215768 

tt <- t.test(method01_score, method02_score)
# Welch Two Sample t-test
# 
# data:  method01_score and method02_score
# t = -2.0547, df = 218.19, p-value = 0.0411
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.48296687 -0.01005133
# sample estimates:
#   mean of x mean of y 
# 5.556881  5.803390 

chk_test(tt)
# p value :  0.04110187 
# 귀무 가설 기각 

ttag <- t.test(method01_score, method02_score, alternative = 'greater')
chk_test(ttag)
# p value :  0.9794491 
# 귀무 가설 채택

ttal <- t.test(method01_score, method02_score, alternative = 'less')
chk_test(ttal)
# p value :  0.02055094 
# 귀무 가설 기각 