
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

# 영업 사원 교육 효과 분석
# 두 집단의 평균이 서로 동일한지를 검증하는 것은 두 집단 평균 차이 분석이라고 한다.
# 두 그룹 간의 평균을 기준으로 차이에 의미를 부여하는 방법이다.  
# 영업 사원들의 실적을 향상 시키기 위하여 어떠한 교육이 더 좋을까?
#   
#   파일 이름 : 영업 사원 교육 효과 분석.R
# 관련 정보
# 항목	설명
# 예제 데이터	2가지 교육 방법별로 교육을 이수한 영업 사원들의 영업 실적으로 조사한 데이터
# 파일 이름	mymethod.csv

# 가설	귀무 가설 : 
#   변수명	id : ID 번호
# method : 영업 역량 강화(1 : 집체 교육, 2 : 멘토링 교육)
# pefrormance : 영업 사원들의 영업 실적(단위 : 억원)
# 단, 입사 6개월 이내 인력은 교육을 받았지만 영업 실적 조사에서 제외하도록 한다
# performance의 값이 99으로 표시되어 있다.

# 분석 문제	교육 방법별로 교육을 이수한 사람들의 빈도 수와 영업 실적 평균 값을 구하세요.
# 실제 영업 실적 비교 대상자만의 데이터를 별도로 추출하세요.
# 두 교육 방법별 영업 실적 데이터 간에 분포 모양이 비슷한지를 검정하세요.(var.test 분석 함수 사용)
# 두 집단 간의 영업 실적에 차이가 있는 지 검증하세요.
# 첨부된 문서를 이용하여 보고 또는 논문 제출을 위한 문서를 작성해보세요.
# 관련 지식	-
#   검증 방법	var.test, t.test

# 귀무가설 : 두 집단간 영업 실적에 차이가 없다.

data <- read.csv('mymethod.csv')
head(data)
str(data)
summary(data)


data$method2 <- factor(data$method, levels = c(1, 2), labels = c('집체교육', '멘토링교육'))
data$method2[data$performance == 99] <- NA
data$performance[data$performance == 99] <- NA
data$performance
meanPerformance <- mean(data$performance, na.rm = T)
meanPerformance
tableMethod <- table(data$method2)
tableMethod

realData <- subset(data, performance != 99)
realData

metM01 <- subset(realData, method == 1)
metM02 <- subset(realData, method == 2)

mean01 <- mean(metM01$performance)
mean02 <- mean(metM02$performance)

mean01;mean02

# 분포 모양이 비슷한가?
vt <- var.test(metM01$performance, metM02$performance)
vt
chk_test(vt)

# par(mfrow = c(1:2))
qqnorm(metM01$performance, col = 'blue')
qqline(metM01$performance, lty = 1, col = 'blue')
par(new = T)
qqnorm(metM02$performance, col = 'red')
qqline(metM02$performance, lty = 1, col = 'red')

# t.test()
tt <- t.test(metM01$performance, metM02$performance)
tt
chk_test(tt)
