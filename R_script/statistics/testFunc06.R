
library(ggplot2)
library(gmodels)
library(prettyR)

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

# 중소 기업에서 생산한 HDTV 판매율을 높이기 위해서 프로모션을 진행한 결과 
# 기존 구매 비율 보다 15% 향상되었는지를 각 단계별로 분석을 수행하여 검정하시오.
# 
# 파일 이름 : hdtv.csv
#
# 연구가설(H1) : 기존 구매 비율과 차이가 있다.
# 귀무가설(H0) : 기존 구매 비율과 차이가 없다.
# 
# 조건) 구매 여부 변수 : buy (1: 구매하지 않음, 2: 구매)
# 단계1: 데이터셋 가져오기
# 
# 단계2: 빈도수와 비율 계산
# install.packages('prettyR')
# library(prettyR)
# table() 함수 및 freq() 등의 함수 사용해보기
# 
# 단계3: 가설 검정
# binom.test()
# 양측 및 단측 검정 수행해보기

data <- read.csv('hdtv.csv')
str(data)
summary(data)
# View(data)

data$buy2 <- factor(data$buy, levels = c(1, 2), labels = c('구매하지 않음', '구매'))
data$buy2

table(data$buy2)
freq(data$buy2)

bt <- binom.test(10, 50, p = 0.15, conf.level = 0.95)
chk_test(bt)
bt <- binom.test(10, 50, p = 0.15, alternative = c('greater'), conf.level = 0.95)
chk_test(bt)
