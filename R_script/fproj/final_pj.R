library(dplyr)
library(reshape2)
library(stringr)
library(ggplot2)

par(family = 'AppleGothic')
par(cex = 0.7)

# Data Import
weekData <- read.csv('지난_1년_동안_평일_하루_평균_여가시간_20191028144506.csv', header = T)
weekendData <- read.csv('지난_1년_동안_휴일_하루_평균_여가시간_20191028144518.csv', header = T)

# Data preview
# View(weekData)
str(weekData)
summary(weekData)

# Data preprocessing
col1 <- as.vector(unlist(weekData[1,]))
colnames(weekData) <- col1
weekData <- weekData[-1,]
transData <- t(weekData)
col2 <- as.vector(unlist(transData[2,]))
colnames(transData) <- col2
transData <- transData[-1:-2,]
transData <- gsub('-', '0', transData)
df1 <- as.data.frame(transData)
head(df1)
rownames(df1)

##########################################################
# 소득별 여가시간의 차이
# Get income data
in01 <- as.vector(df1$`100만원 미만`)
in01 <- as.numeric(in01)
in02 <- as.vector(df1$`100~200만원`)
in02 <- as.numeric(in02)
in03 <- as.vector(df1$`200~300만원`)
in03 <- as.numeric(in03)
in04 <- as.vector(df1$`300~400만원`)
in04 <- as.numeric(in04)
in05 <- as.vector(df1$`400~500만원`)
in05 <- as.numeric(in05)
in06 <- as.vector(df1$`500~600만원`)
in06 <- as.numeric(in06)
in07 <- as.vector(df1$`600만원 이상`)
in07 <- as.numeric(in07)

income <- rbind(in01, in02, in03, in04, in05, in06, in07)
income
income <- income[, -1]
income <- income[, -6]
colnames(income) <- c('less 3', '3 to 5', '5 to 7', '7 to 9', 'over 9')
income
rownames(income) <- c('~100만', '100만~200만', '200만~300만', '300만~400만', '400만~500만', '500만~600만', '600만~')
# c('#DAF7A6', '#FFC300', '#93FFCE', '#93E2FF', '#9F93FF')
bp1 <- barplot(income, beside = T, col = rainbow(nrow(income)), 
        main = '소득별 여가시간 그래프', legend = rownames(income),
        ylim = c(0, 60), xlab = '여가시간', ylab = 'proportion')
par(cex = 0.4)
text(x = bp1, y = income * 1.05, labels = paste(income, '%'))

##########################################################

##########################################################
# 성별간 여가시간의 차이
# Get gender data
par(cex = 0.7)
male <- as.vector(df1$남성)
male <- as.numeric(male)
female <- as.vector(df1$여성)
female <- as.numeric(female)

gender <- rbind(male, female)
class(gender)
gender
colnames(gender) <- col1[-1:-2]
gender <- gender[,-1]
avgGender <- gender[,6]
gender <- gender[,-6]

# Gender chart
bp2 <- barplot(gender, beside = T, col = c('#94d7e3', '#ebbee5'),
              legend = rownames(gender), ylim = c(0,50),
              main = '남성과 여성의 평일 여가시간 그래프',
              xlab = '여가시간', ylab = 'proportion')
text(x = bp2, y = gender * 1.05, labels = paste(gender, '%'))
##########################################################


