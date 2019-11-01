library(Hmisc)
library(prettyR)
library(reshape2)
library(dplyr)
library(moments)

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

showinfo <- function(x1) {
  # 왜도
  cat('왜도 : ', skewness(x1), '\n')
  # 첨도
  cat('첨도 : ', kurtosis(x1), '\n')
  # 히스토그램을 작성한다.
  hist(x1, freq = F)
  # 비대칭도 통계량을 설명한다.
  # 밀도 분포 곡선을 그린다.
  lines(density(x1), col = 'blue')
  # 정규 분포 곡선도 같이 그려서 정규 분포 검정을 수행한다.
  curve(dnorm(x, mean(x1), sd(x1)), col = 'red', add=T)
}

# welfare.csv 파일을 이용하여
data <- read.csv('welfare.csv')
head(data)
summary(data)

# 문제 01 : birth 컬럼
# 히스토그램을 작성하고, 비대칭도 통계량(왜도/첨도/밀도 분포/정규 분포 곡선)에 대하여 살펴 보세요.
showinfo(data$birth)

# 문제 02 : 카이 제곱 검정 : 성별(gender)과 종교 유무(religion)
## 귀무 가설 : 성별과 종교 유무는 관계가 없다. 
ct <- chisq.test(data$gender, data$religion)
chk_test(ct)
# Pearson's Chi-squared test with Yates' continuity correction
# 
# data:  data$gender and data$religion
# X-squared = 189.26, df = 1, p-value < 2.2e-16
# 
# p value :  4.611076e-43 
# 가설 기각  
## 따라서 성별과 종교 유무는 관계가 없다고 볼 수 없다. 

# 문제 03 : 두 집단 평균 검정 : 성별(gender)과 월급(income)
## 귀무가설 : 성별과 월급의 평균은 차이가 없다.
## 두 집단 평균 검정 : t.test() 사용
tt <- t.test(data$gender, data$income)
chk_test(tt)
# Welch Two Sample t-test
# 
# data:  data$gender and data$income
# t = -88.642, df = 4633.1, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -245.4595 -234.8368
# sample estimates:
#   mean of x  mean of y 
# 1.470868 241.619016 
# 
# p value :  0 
# 가설 기각  
## 따라서 성별과 월급의 평균은 차이가 있다고 볼 수 있다. 

# 문제 04 : 
# birth 컬럼을 이용하여 age 컬럼을 만드세요.
# age 컬럼을 3그룹으로 나누세요.
# 세 집단 평균 검정 : 나이(age)과 월급(income)
## aov() 함수를 사용한다. 
data$birth
range(data$income)
boxplot(data$income)

data$age <- 2019 - data$birth + 1
head(data$age)
range(data$age)

data$age2[data$age < 40] <- '청년층'
data$age2[data$age < 60 & data$age >= 40] <- '중년층'
data$age2[data$age >= 60] <- '장년층'

table(data$age2)

data <- subset(data, !is.na(income))
table(is.na(data$income))

aovRes <- aov(income ~ age2, data = data)
summary(aovRes)
# Df    Sum Sq Mean Sq F value Pr(>F)    
# age2           2  14920288 7460144   242.2 <2e-16 ***
#   Residuals   4631 142658066   30805                   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
## Pr(>F)값은 <2e-16 이므로, 0.05보다 작다.
## 따라서 귀무가설이 기각되었으므로 나이 3개 그룹별 월급 평균 차이가 없다고 볼 수 없다. 

# 문제 05 : 
# stock_market.csv 파일을 이용하여 공분산 및 상관 계수를 구하여라.
# cor() 함수와 cov() 함수를 사용하지 않고 순수 R 코드를 이용하여 다시 풀어 보세요.
# 공분산 : 0.06384
# 상관 계수 : 0.9870298
stock <- read.csv('stock_market.csv', header = F)
head(stock)
summary(stock)

# 공분산 값
cvS <- cov(stock$V1, stock$V2)
cvS
# 피어슨 상관 계수
crS <- cor(stock$V1, stock$V2)
crS

## 따라서 피어슨 상관 계수가 0.987.. 이므로, V1과 V2의 관계가 있다고 볼 수 있다. 