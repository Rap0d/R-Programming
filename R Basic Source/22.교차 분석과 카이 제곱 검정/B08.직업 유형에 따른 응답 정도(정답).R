직업유형에 따른 응답정도에 차이가 있는가를 단계별로 검정하시오.[동질성 검정]

단계1: 파일 가져오기
setwd("c:/Rwork/Part-III")
response <- read.csv("response.csv", header=TRUE)

단계2: 코딩 변경 - 리코딩
job : 1:학생, 2:직장인, 3:주부
response : 1:무응답, 2:낮음, 3:높음
# job2 칼럼 추가
result$job2[result$job==1] <- "1.학생"
result$job2[result$job==2] <- "2.직장인"
result$job2[result$job==3] <- "3.주부"
# response2 칼럼 추가
result$response2[result$response==1] <- "1.무응답"
result$response2[result$response==2] <- "2.낮음"
result$response2[result$response==3] <- "3.높음"

단계3: 교차 분할표 작성
table(result$job2, result$response2)

단계4: 동일성 검정
chisq.test(result$job3, result$response3) #p-value = 6.901e-12
# 귀무가설 : 세 집단의 비율은 동일하다.

단계5: 검정결과 해석
<해설> 귀무가설 기각 : 세 집단 간의 응답율이 서로 다르다고 할 수 있다.