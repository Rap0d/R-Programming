library(reshape2)

par(family = 'D2Coding')

mydata <- read.csv('student_subject_score.csv', header = T)
mydata
colnames(mydata)

# 행 ~ 열
# dcast를 통해 data 변환
namesubject <- dcast(mydata, name ~ subject, value.var = 'jumsu')
namesubject

name <- namesubject[1]
name
class(name)

chartdata <- namesubject[2:7]
chartdata
class(chartdata)

# barplot 에는 matrix, vector만 들어올 수 있음
# 형변환 필요 
c1 <- as.matrix(chartdata)

myrow <- nrow(c1)
mycolor <- rainbow(myrow)

# barplot -> beside 값은 옆으로 펼질지에 대한 옵션
barplot(c1, beside = T, main = '과목별 학생 점수', col = mycolor, ylim = c(0, 100))

# t() 함수를 사용한 행렬 전치
# 학생별 과목 점수
c2 <- t(c1)

# 학생 이름도 t()함수를 통해 전치하여 넣음
colnames(c2) <- t(name)
barplot(c2, beside = T, main = '학생별 과목 점수', col = mycolor, ylim = c(0, 100))

namesubject

# 1번째 학생만 그려보기
c3 <- c1[1,]
c3
subject <- colnames(namesubject[2:7])
subject

# legend : 범례 
barplot(c3, beside = T, main = '개인의 과목 점수', col = mycolor, ylim = c(0, 100), legend = subject)


pie(c3, main = '개인의 과목 점수 파이 그래프')
