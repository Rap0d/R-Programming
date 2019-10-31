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

# 대학에 진학한 남학생과 여학생을 대상으로 진학한 대학에 대해서 만족도에 차이가 있는가를 검정하시오.
# 
# 힌트) 두 집단 비율 차이 검정
# 
# 파일명 : two_sample.csv
# 변수명 : gender(1,2), survey(0,1)
# 
# 단계1: 실습 데이터 가져오기
# 
data <- read.csv('two_sample.csv', header = T)
str(data)
summary(data)
table(is.na(data))

# 단계2: 두 집단 subset 작성
# # 데이터 정체/전처리
# 
data <- subset(data, !is.na(data$survey))

dataMale <- subset(data, data$gender == 1)
dataFemale <- subset(data, data$gender == 2)

table(dataMale$survey)
table(dataFemale$survey)

# # 교차테이블 확인
# 
CrossTable(data$gender, data$survey)

# 단계3: 두 집단 비율 차이 검증
pt <- prop.test(c(138, 107), c(36 + 138, 19 + 107), conf.level = 0.95)
chk_test(pt)
