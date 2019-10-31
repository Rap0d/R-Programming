# Cross Table

# install.packages('gmodels')
library(gmodels)

myData <- read.csv('cross_table.csv')
head(myData)

# 부모의 학력 수준과 자녀의 시험 합격 여부
# recode
myData$level2[myData$level == 1] <- '고졸'
myData$level2[myData$level == 2] <- '대졸'
myData$level2[myData$level == 3] <- '대학원졸'

# 자녀 시험
myData$pass2[myData$pass == 1] <- 'pass'
myData$pass2[myData$pass == 2] <- 'fail'

level2 <- myData$level2
pass2 <- myData$pass2

table(level2, pass2)

# 교차 분할표
CrossTable(x = level2, y = pass2, dnn = c('부모 학력', '자녀 진학'))

mFrame <- data.frame(학력 = c('고졸', '대졸', '대학원졸'), 합격율 = c(0.551, 0.671, 0.574))
mFrame
ggplot(mFrame, aes(x = 학력, y = 합격율, fill = 학력, color = 학력)) + geom_col(position = 'Dodge') + theme_minimal(base_family = 'AppleGothic')
