# install.packages('readxl')
# install.packages('dplyr')

library(readxl)
library(dplyr)

filename <- '서울시 대기 환경 정보(2017년9~12월).xlsx'
examdata <- read_excel(filename)

# View(dustdata)
str(examdata)

head(examdata)

# 필요한 컬럼만 추출하기
dustdata <- examdata[c('날짜', '측정소명', '미세먼지')]

# 컬럼 이름 변경
colnames(dustdata) <- c('yyyymmdd', 'area', 'finedust')
dustdata

# 성북구와 중구만 필터링하기
dustdata_anal <- dustdata %>% filter(area %in% c('성북구', '중구'))
head(dustdata_anal)


# yyyymmdd에 따른 데이터 수 파악
count(dustdata_anal, yyyymmdd) %>% arrange(desc(n))

# area에 따른 데이터 수 파악
count(dustdata_anal, area) %>% arrange(desc(n))

# 성북구와 중구 데이터를 별도로 분리하기
area01 <- subset(dustdata_anal, area == '성북구')

area02 <- subset(dustdata_anal, area == '중구')

# 미세먼지에 대한 기초 통계량 확인하기
# install.packages('psych')
library(psych)

describe(area01$finedust)

describe(area02$finedust)

# 미세 먼지 농도에 대한 boxplot을 이용한 데이터 분포 확인하기
boxplot(area01$finedust, area02$finedust, main='finedust compare', xlab='AREA', names=c('성북구', '중구'), ylab='FINEDUST_PM', col=c('blue', 'green'))


t.test(data=dustdata_anal, finedust ~ area, var.equal = T )
# Two Sample t-test
# 
# data:  finedust by area
# t = 2.8347, df = 242, p-value = 0.004975
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   2.085657 11.586474
# sample estimates:
#   mean in group 성북구   mean in group 중구 
# 42.74590             35.90984 

# p-value의 값이 0.004975이므로 0.05보다 작다.
# 즉, 귀무 가설을 기각한다.
# 따라서, 미세 먼지의 평균에는 차이가 난다 는 것을 확인할 수 있다.

