library(Hmisc)
library(prettyR)
library(reshape2)
library(dplyr)
library(moments)

descData <- read.csv('descriptive.csv')

par(family = 'AppleGothic')

# descriptive.csv 데이터 셋을 대상으로 다음 조건에 맞게 빈도 분석 및 기술 통계량 분석을 수행하시오.
# 
# 조건1) 명목 척도 변수인 학교 유형(type), 합격 여부(pass) 변수에 대해 빈도 분석을 수행하고 결과를 
# 막대 그래프와 파이 차트로 시각화하세요.
# 
head(descData)
summary(descData)
tableType <- table(descData$type)
tablePass <- table(descData$pass)

barplot(tableType, col = rainbow(nrow(tableType)), main = '학교 유형 빈도수 그래프')
pie(tableType, col = rainbow(nrow(tableType)), main = '학교 유형 빈도수 그래프')

barplot(tablePass, col = rainbow(nrow(tablePass)), main = '합격 여부 빈도수 그래프')
pie(tablePass, col = rainbow(nrow(tablePass)), main = '합격 여부 빈도수 그래프')

# 조건2) 비율 척도 변수인 나이(age) 변수에 대해 요약치(평균, 표준 편차 등)을 구하시오.
# 
avgAge <- mean(descData$age)
sdAge <- sd(descData$age)

# 조건3) 나이 변수(age)에 대해 다음과 같은 함수(이름 : show_info)를 구현하시오.
# 실행 예시
# show_info(age)
# 
# 구현할 내용
# 왜도 통계량을 출력한다.
# 첨도 통계량을 출력한다.
# 히스토그램을 작성한다.
# 비대칭도 통계량을 설명한다.
# 밀도 분포 곡선을 그린다.
# 정규 분포 곡선도 같이 그려서 정규 분포 검정을 수행한다.
#
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

showinfo(descData$age)