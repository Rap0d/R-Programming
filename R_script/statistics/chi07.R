# 직업 유형(job)에 따른 응답 정도(response)에 차이가 있는가를 단계별로 검정하시오.[동질성 검정]
# 
# # 귀무 가설 : 세 집단의 비율은 차이가 없다.
# 
# 파일 이름 : response.csv
# 
# 단계1: 파일 가져오기
# 
# 단계2: 코딩 변경 - 리코딩
# job : 1:학생, 2:직장인, 3:주부
# response : 1:무응답, 2:낮음, 3:높음
# 
# 단계3: 교차 분할표 작성
# 
# 단계4: 동질성 검정

library(ggplot2)
library(gmodels)

# 귀무 가설 채택 여부
## param : Table
chk_chi <- function(res) {
  chisq <- chisq.test(res)
  if(chisq$p.value > 0.05) {
    cat('p value : ', chisq$p.value, '\n')
    cat('귀무 가설 채택')
  } else {
    cat('p value : ', chisq$p.value, '\n')
    cat('귀무 가설 기각 ')
  }
}

data <- read.csv('response.csv', header = T)
head(data)

range(data$job)
range(data$response)

data$job2 <- factor(data$job, levels = c(1, 2, 3), labels = c('학생', '직장인', '주부'))
data$response2 <- factor(data$response, levels = c(1, 2, 3), labels = c('무응답', '낮음', '높음'))

tableData <- table(data$job2, data$response2)
tableData

CrossTable(tableData)
chk_chi(tableData)

# p value :  6.900771e-12 
# 귀무 가설 기각

## 따라서 세 집단의 비율은 차이가 있다라고 볼 수 있다.