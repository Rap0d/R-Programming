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

# 분산 분석(교육 방법에 따른 실기 시험 평균)
# 분산 분석은 T 검정과 동일하게 평균에 의한 차이 검정 방법이다.
# 차이점은 분산 분석일 경우 세 집단 이상의 평균 차이를 검정하는 것이다.
# 
# 파일 이름 : F01.분산 분석(교육 방법에 따른 평균_정답).R
# three_sample.csv
#
# 연구 환경
# 한국 교육 센터에서는 3가지의 교육 방법(집체 교육, 개별 교육, 혼합 교육)을 
# 이용하여 각 50명씩 실기 시험을 실시하였다.
# 세 집단간 실기 시험의 평균에 차이가 있는 지 검사한다.
# 
# 가설
# 귀무 가설
# 세 가지 교육 방법에 따른 실기 시험의 평균에 차이가 없다.
# 
# 연구 가설
# 세 가지 교육 방법에 따른 실기 시험의 평균에 차이가 있다.

data <- read.csv('three_sample.csv')
head(data)
summary(data)

# remove missing value, outlier
data <- subset(data, !is.na(score), c(method, score))
data <- subset(data, score < 70)

boxplot(data$score)
plot(data$score)

# recode
data$method2[data$method == 1] = '방법 1'
data$method2[data$method == 2] = '방법 2'
data$method2[data$method == 3] = '방법 3'

# check frequency 
table(data$method2)

# make data frame
x <- table(data$method2)
y <- tapply(data$score, data$method2, mean)
df <- data.frame(교육방법 = x, 성적 = y)
df

# bartlett test
## bartlett.test(종속변수 ~ 독립변수, data)
## 동질성 테스트
bart <- bartlett.test(score ~ method2, data)
chk_test(bart)

# 귀무 가설
## 세 가지 교육 방법에 따른 실기 시험의 평균에는 차이가 없다.

# aov
## Pr(>F) == p-value
res <- aov(score ~ method2, data)
names(res)
summary(res)

thsd <- TukeyHSD(res)
thsd$method2

plot(thsd)
