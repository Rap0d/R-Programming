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

# 교육 방법에 따라 시험 성적에 차이가 있는지 검정하시오.
# 힌트) 두 집단 평균 차이 검정
# 
# 조건1) 파일 : twomethod.csv
# 조건2) 변수 : method(교육 방법), score(시험 성적)
# 조건3) 모델 : 교육 방법(명목) -> 시험 성적(비율)
# 조건4) 전처리 : 결측치 제거
# 

# 귀무가설 : 교육 방법에 따라 시험 성적에 차이가 없다.

# 단계1: 실습파일 가져오기
# 
data <- read.csv('twomethod.csv')
str(data)
summary(data)

# 단계2: 두 집단 subset 작성(데이터 정제, 전처리)
# 데이터 전처리(score의 NA 값이 있는 것은 제외시킨다)
# 
nData <- subset(data, !is.na(data$score))
nData

# 단계3: 데이터 분리
# # 1) 교육 방법별로 분리
dMethod1 <- subset(nData, nData$method == 1)
dMethod2 <- subset(nData, nData$method == 2)

# # 2) 교육 방법에서 영업 실적 추출
dMeScore1 <- dMethod1$score
dMeScore2 <- dMethod2$score

# # 3) 기술 통계량
# 
summary(dMeScore1)
summary(dMeScore2)

# 단계4: 분포 모양 검정
# 
st1 <- shapiro.test(dMeScore1)
st2 <- shapiro.test(dMeScore2)
chk_test(st1)
# Shapiro-Wilk normality test
# 
# data:  dMeScore1
# W = 0.91363, p-value = 0.05618
# 
# p value :  0.05617919 
# 가설 채택 
chk_test(st2)
# Shapiro-Wilk normality test
# 
# data:  dMeScore2
# W = 0.97381, p-value = 0.5559
# 
# p value :  0.5559226 
# 가설 채택 

# 단계5: 가설 검정
# 두 집단 평균을 검정하기 위해 t.test() 함수를 사용한다.
#
tt1 <- t.test(dMeScore1, dMeScore2)
chk_test(tt1)
# Welch Two Sample t-test
# 
# data:  dMeScore1 and dMeScore2
# t = -5.6056, df = 43.705, p-value = 1.303e-06
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -17.429294  -8.209667
# sample estimates:
#   mean of x mean of y 
# 16.40909  29.22857 
# 
# p value :  1.302693e-06 
# 가설 기각  

# 귀무가설 기각
## 교육 방법에 따라 시험 성적에 차이가 있다.
