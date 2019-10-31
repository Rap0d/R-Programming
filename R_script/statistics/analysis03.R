library(Hmisc)
library(prettyR)
library(reshape2)
library(dplyr)

cfData <- read.csv('mycf.csv')

par(family = 'AppleGothic')

##################################################
# 기본 통계량 조회
##################################################

# 앞 6줄만 조회해보세요.
head(cfData)
# 뒷 6줄만 조회해보세요.
tail(cfData)
# View 함수를 이용하여 전체 목록을 조회해보세요.
View(cfData)
# 구조를 확인하세요.
str(cfData)
# 요약 통계량을 조회해보세요.
summary(cfData)
##################################################
# 광고 집단 유형에 대한 기술 통계 분석
##################################################
# group 컬럼은 1이면 연예인을 내세운 광고이고, 
# 2이면, 일반인을 내세운 광고이다.

# factor 함수를 이용하여 요인형으로 변환하세요.
cfData$group2 <- factor(cfData$group, levels = c(1, 2), labels = c('연예인 CF', '일반인 CF'))

# 숫자 1("연예인 CF", 2("일반인 CF")으로 라벨을 붙이세요.
# 이 자료에 대한 빈도 및 비율을 출력하세요.
tableGroup <- table(cfData$group2)
tableGroup
propGroup <- prop.table(tableGroup)
propGroup
# 해당 요인에 대한 그래프를 그리시오.
barplot(propGroup, col = rainbow(nrow(propGroup)))
##################################################
# 광고의 관심 유무에 따른 기술 통계 분석
##################################################
# interest 컬럼은 광고의 관심도이다.
# 1이면 관심이 있고, 0이면 관심이 없다.는 의미이다.
# factor 함수를 이용하여 요인형으로 변환하세요.
cfData$interest2 <- factor(cfData$interest, levels = c(1, 0), labels = c('관심있다', '관심없다'))
# 이 자료에 대한 빈도 및 비율을 출력하세요.
tableInterest <- table(cfData$interest2)
tableInterest
propInterest <- prop.table(tableInterest)
propInterest
# 해당 요인에 대한 그래프를 그리시오.
barplot(tableInterest, col = rainbow(nrow(tableInterest)))
##################################################
# 변수 리코딩을 이용하여 성별을 한글로 보여 주도록 하시오.
# 나이가 40 이하이면 '청년층', 40 초과이면 '중년층'으로 리코딩하시오.
cfData$gender2[cfData$gender == 'M'] = '남'
cfData$gender2[cfData$gender == 'F'] = '여'
tableGender <- table(cfData$gender2)

cfData$age2[cfData$age <= 40] = '청년층'
cfData$age2[cfData$age > 40] = '중년층'
tableAge <- table(cfData$age2)
##################################################
# 기술 통계량 보고서를 작성하세요.
reportCF <- data.frame(성별 = tableGender, 연령층 = tableAge, 관심도 = tableInterest, 광고유형 = tableGroup)
reportCF

Hmisc::describe(cfData)
##################################################
# 참조 그림 : 집단 유형별 샘플수.png / 광고 관심 유무 사용자수.png