library(rJava)
library(KoNLP)
library(stringr)
library(dplyr)
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(wordcloud2)

setwd('../../../R_data/191022/')

fileName <- 'Untitled spreadsheet - ExcelData.csv'
data01 <- read.csv(fileName, header = T)
data01

dustData <- data01[c(1:3)]
dustData

# 필터링
dustData_an <- dustData %>% filter(측정소명 %in% c('강동구', '송파구'))
dustData_an

# 날짜별 카운트
count(dustData_an, date) %>% arrange(desc(n))
# 측정소 별 카운트
count(dustData_an, 측정소명) %>% arrange(desc(n))

# 측정소 별로 분리하기
gangdong <- subset(dustData_an, 측정소명 == '강동구')
songpa <- subset(dustData_an, 측정소명 == '송파구')

summary(gangdong$미세먼지)
summary(songpa$미세먼지)

# theory : 두 지역의 평균은 차이가 없다.
# p-value > 0.05 이면 가설을 채택
# t 검증 : 두 집단의 평균이 같은지를 판단할 때 사용
t.test(data = dustData_an, 미세먼지 ~ 측정소명)
#
# Welch Two Sample t-test
# 
# data:  미세먼지 by 측정소명
# t = 1.0225, df = 706.39, p-value = 0.3069
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -1.796001  5.699641
# sample estimates:
#   mean in group 강동구 mean in group 송파구 
# 44.05753             42.10571 

par(family = 'D2Coding')
boxplot(gangdong$미세먼지, songpa$미세먼지, names = c('강동구', '송파구'), col = rainbow(2))
