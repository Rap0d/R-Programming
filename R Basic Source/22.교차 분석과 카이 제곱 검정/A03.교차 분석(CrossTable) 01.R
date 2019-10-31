mydata = read.csv("cross_table.csv", header=TRUE)

head(mydata) # 변수 확인

# 부모 학력 수준(level)에 대한 코딩 변경
mydata$level2[mydata$level == 1] <- '고졸'
mydata$level2[mydata$level == 2] <- '대졸'
mydata$level2[mydata$level == 3] <- '대학원졸'

# 자녀의 진학(pass) 여부에 대한 코딩 변경
mydata$pass2[mydata$pass == 1] <- 'pass'
mydata$pass2[mydata$pass == 2] <- 'fail'

head(mydata) # 변수 확인

level2 = mydata$level2 # 리코딩 변수 이용
pass2 = mydata$pass2  # 리코딩 변수 이용

# 부모 학력 수준(level2) -> 자녀의 대학 진학 여부(pass2)
level2 
pass2 # 자녀의 대학 진학 여부(pass2)

# 데이터프레임 생성
# 변수 모델링 : 부모 학력 수준(독립 변수:level2) -> 자녀 진학 여부(종속 변수:pass2)
# 형식 : data.frame(명목척도=level2, 명목척도=pass2)
result = data.frame(Level=level2, Pass=pass2) # 데이터 프레임 생성 - 데이터 묶음
dim(result) # 차원보기- 248   2
# [1] 248   2

# table 함수를 이용하여 교차 분할표를생성한다.
table(result)  # 빈도 보기
#           Pass
# Level      fail pass
#   고졸       40   49
#   대졸       27   55
#   대학원졸   23   31

# 패키지를 이용하여 교차 분할 표 생성하기
install.packages('gmodels')

library(gmodels)

CrossTable(x=level2, y=pass2, dnn=c('부모 학력', '자녀의 대학 진학 여부'))

myframe <- data.frame(학력=c('고졸', '대졸','대학원졸'), 합격율=c(0.551, 0.671, 0.574))
myframe

library(ggplot2)
ggplot(myframe, aes(x=학력, y=,합격율, fill=학력, color=학력)) + geom_col() + labs(title='부모 학력별 자녀 진학률')

0.396+0.364+0.240
