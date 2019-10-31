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

# 국내에서 생산된 노트북과 A회사에서 생산된 노트북의 평균 사용 시간에 차이가 없다. 

data <- read.csv('one_sample.csv', header = T)
head(data)
str(data)

time <- data$time

head(time)
range(time)
# na.omit()
time2 <- na.omit(time)
mean(time2)

res <- shapiro.test(time2)

chk_test(res)
# p value :  0.7242303 
# 귀무 가설 채택

hist(time2)

# 정규분포 그래프 함수
# 직선 주위에 많이 쏠려 있으면 정규 분포에 가깝다.
qqnorm(time2)
qqline(time2, lty = 1, col = 'blue')

# t test
# mu : 모집단의 평균값(비교할 대상의 평균값)
t.test(x = time2, mu = 5.2)

# One Sample t-test
# 
# data:  time2
# t = 3.9461, df = 108, p-value = 0.0001417
# alternative hypothesis: true mean is not equal to 5.2
# 95 percent confidence interval:
#   5.377613 5.736148
# sample estimates:
#   mean of x 
# 5.556881 

# 방향성을 갖는 단측 검정
## greater 옵션 : 기준치보다 큰지 아닌지 확인
ttest01 <- t.test(x = time2, mu = 5.2, alternative = 'greater', conf.level = 0.95)
# One Sample t-test
# 
# data:  time2
# t = 3.9461, df = 108, p-value = 7.083e-05
# alternative hypothesis: true mean is greater than 5.2
# 95 percent confidence interval:
#   5.406833      Inf
# sample estimates:
#   mean of x 
# 5.556881
# -> 노트북 사용 시간이 5.2시간보다 크다고 할 수 있다. 

# 108 : 자유도
abs(qt(ttest01$p.value, 108)) < 3.9461






