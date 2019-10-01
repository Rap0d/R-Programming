# Factor 관련 함수에 관한 스크립트 
# Factor 형
# 이 유형은 여러 번 중복으로 나오는 데이터들을 각 값으로 모아서 대표 값을 출력해 주는 형태이다.

getwd()

setwd('/Users/seungheonchang/Documents/Workspace/_3_rProgramming/R-Programming')
mytxt <- read.csv('R_Script/191001_01/factor_test.txt')

mytxt

# str : structure
str(mytxt)


# data.frame : table
# obs, variables : 각각 행 / 열 

# factor
# levels : 취할 수 있는 값 
# labels : 식별할 수 있도록 임의로 지정한 값 
# A,        B,      O,      AB          : levels
# '에이형', '비형', '오형', '에이비형'  : labels

summary(mytxt)

# level 별 label 붙여 새로운 열 만들기 
mytxt$blood2 <- factor(mytxt$blood, levels=c('A', 'B', 'AB', 'O'), labels=c('A형', 'B형', 'AB형', 'O형'))

mytxt$sex2 <- factor(mytxt$sex, levels=c('남', '여'), labels=c('male', 'female'))
