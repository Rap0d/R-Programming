descriptive <- read.csv('descriptive.csv')

head(descriptive)
dim(descriptive)
str(descriptive)

# 명목 척도
summary(descriptive)
length(descriptive)
table(descriptive)

descriptive <- subset(descriptive, descriptive$gender == 1 | descriptive$gender == 2)
genderTable <- table(descriptive$gender)
descriptive
genderTable

barplot(genderTable)

# prop.table() : 비율 구하는 함수
genderProp <- round(prop.table(genderTable) * 100, 2)
genderProp

resiUni <- unique(descriptive$resident)
barplot(resiUni)

# 서열 척도 : level(학력 수준)
unique(descriptive$level)
length(descriptive$level)
summary(descriptive$level) # 의미 없음
table(descriptive$level)

tableLevel <- table(descriptive$level)
barplot(tableLevel)

# 등간 척도 : survey(설문 조사)
survey <- descriptive$survey
survey


# 비율 척도 : cost(비용)
length(descriptive$cost)
summary(descriptive$cost)
mean(descriptive$cost)

## 산점도
plot(descriptive$cost)
## boxplot
costBox <- boxplot(descriptive$cost)
costBox
### 결과의 stats에서 1, 5번째가 이산치
## 이산치 제거
descriptive <- subset(descriptive, descriptive$cost >= 2 & descriptive$cost <= 10)
descriptive

cost <- descriptive$cost

sort(cost)
sort(cost, decreasing = T)
mean(cost)
median(cost)
### quantile : 사분위수 구하는 함수
quantile(cost, 1/4)
quantile(cost, 2/4)
quantile(cost, 3/4)
quantile(cost, 4/4)
## 이산치가 제거된 box
newBox <- boxplot(cost)
newBox
## age별 cost 산점도 그래프
plot(descriptive$age, descriptive$cost)

hist(cost)

# 연속형인 'cost' 컬럼을 범주화(코딩 변경)
# low(4.0 미만), middle(4.0이상 6.0미만), high(6.0이상)
descriptive$cost2[descriptive$cost < 4.0] = "low"
descriptive$cost2[descriptive$cost >= 4.0 & descriptive$cost < 6.0] = "middle"
descriptive$cost2[descriptive$cost >= 6.0] = "high"
unique(descriptive$cost2)

tableCost <- table(descriptive$cost2)
tableCost
barplot(tableCost)

# age 컬럼을 이용하여 age2 코딩 변경
range(descriptive$age)
descriptive$age2[descriptive$age < 50] = "중년"
descriptive$age2[descriptive$age >= 50 & descriptive$age < 60] = "장년"
descriptive$age2[descriptive$age >= 60] = "노년"
unique(descriptive$age2)

# 왜첨도 패키지
# install.packages('moments')
library(moments)
# 왜도
skewness(cost)
# 첨도
kurtosis(cost)

kurt <- kurtosis(cost)
ifelse(kurt == 3.0, '정규분포', ifelse(kurt > 3.0, '뾰족', '완만'))

hist(cost, freq = F)

lines(density(cost), col = 'blue')

x <- seq(0, 8, 0.1)
curve(dnorm(x, mean(cost), sd(cost)), col = 'red', add=T)

dnorm(x, mean(cost), sd(cost))

# install.packages('Hmisc')
## 전체 데이터 셋에 포함된 모든 변수들을 대상으로 기술 통계량을 제공
## 빈도와 비율 데이터를 일괄적으로 제공
library(Hmisc)

Hmisc::describe(descriptive)
Hmisc::describe(descriptive$cost2)

# install.packages('prettyR')
library(prettyR)
prettyR::freq(descriptive)
