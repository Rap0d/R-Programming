# 부모의 학력 수준은 자녀의 대학 진학 여부와 독립성이 없다.
mydata = read.csv("cross_table.csv", header=TRUE)

# 부모 학력 수준(level)에 대한 코딩 변경
mydata$level2[mydata$level == 1] <- '고졸'
mydata$level2[mydata$level == 2] <- '대졸'
mydata$level2[mydata$level == 3] <- '대학원졸'

# 자녀의 진학(pass) 여부에 대한 코딩 변경
mydata$pass2[mydata$pass == 1] <- 'pass'
mydata$pass2[mydata$pass == 2] <- 'fail'

head(mydata) # 변수 확인

mylevel <- mydata$level2
mypass <- mydata$pass2

library(gmodels)

CrossTable(mylevel, mypass, chisq = TRUE)

# ....중략
# 
# Statistics for All Table Factors
# 
# 
# Pearson's Chi-squared test 
# ------------------------------------------------------------
# Chi^2 =  2.766951     d.f. =  2     p =  0.2507057 

# 0.2507057 > 0.05 #TRUE : 귀무 가설을 채택한다.
