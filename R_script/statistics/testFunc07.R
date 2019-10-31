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

# 우리 나라 전체 중학교 2학년 여학생 평균 키가 148.5cm로 알려져 있는 상태에서 
# A 중학교 2학년 전체 500명을 대상으로 10%인 50명을 표본으로 선정하여 표본 평균 신장을
# 계산하고 모집단의 평균과 차이가 있는지를 각 단계별로 분석을 수행하여 검정하시오.
# 
# 파일 이름 : student_height.csv
# 
# 단계1: 데이터셋 가져오기
# 
# 단계2: 기술 통계량/결측치 확인
# 요구 사항 : height에서 결측치는 제거하고 실습하도록 하세요.
# 
# 단계3: 정규성 검정
# 정규 분포가 아니면 wilcox.test() 검정을 수행해야 한다.
# 
# 정규 분포(모수검정) - t.test()
# 비정규 분포(비모수검정) - wilcox.test()
# 
# 단계4: 가설 검정 - 양측 검정

data <- read.csv('student_height.csv')

str(data)
summary(data)
data <- subset(data, !is.na(data$height))
data

st <- shapiro.test(data$height)
chk_test(st)
# Shapiro-Wilk normality test
# 
# data:  data$height
# W = 0.88711, p-value = 0.0001853
# 
# p value :  0.0001852942 
# 가설 기각  

## data의 height 값이 정규성을 충족시키지 못하므로 wilcox 검정을 실시
wt <- wilcox.test(data$height, mu = 148.5)
chk_test(wt)
# Wilcoxon signed rank test with continuity correction
# 
# data:  data$height
# V = 826, p-value = 0.067
# alternative hypothesis: true location is not equal to 148.5
# 
# p value :  0.06700316 
# 가설 채택 

### 알려져 있는 우리나라 여학생 평균 신장 정보는 차이가 없다. 가 채택 됐다.
