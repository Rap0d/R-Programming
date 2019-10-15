abcCsv = read.csv("abc.csv", header=TRUE)

# 변수 변환(리코딩) 하기
summary(abcCsv$age)
 
# 조건식에 따른 새로운 컬럼 age2 추가하기
abcCsv$age2[abcCsv$age<=30] <- "청년층"
abcCsv$age2[abcCsv$age>30 & abcCsv$age<=45] <- "중년층"
abcCsv$age2[abcCsv$age>45] <- "장년층"
 
head(abcCsv)
 
head(abcCsv[c("age", "age2")])
 
# 청년층 = 1, 중년층 = 2, 장년층 = 3
abcCsv$age3[abcCsv$age<=30] <- 1
abcCsv$age3[abcCsv$age>30 & abcCsv$age<=45] <- 2
abcCsv$age3[abcCsv$age>45] <- 3
 
head(abcCsv[c("age", "age2", "age3")])
 
# total변수를 이용해 High 그룹과 Low 그룹으로 나누기
# High 그룹은 60이상이라고 가정한다.
abcCsv$abcCsvtotal[abcCsv$total >= 60] <- 'high' 
abcCsv$abcCsvtotal[abcCsv$total < 60] <- 'low'
 
# survey변수를 이용해 만족 그룹(Good)과 불만족 그룹(Bad)으로 나누기
# 만족 그룹(Good)은 3이상이라고 가정한다.
abcCsv$abcCsvsurvey[abcCsv$survey >= 3] <- 'Good'
 
abcCsv$abcCsvsurvey[abcCsv$survey < 3] <- 'Bad'

abcCsv