# install.packages('foreign')

# 외부 통계 프로그램 파일 로드 패키지
library(foreign)

setwd('../../../R_data/191023/')
fileName <- 'Koweps_hpc10_2015_beta1.sav'
raw_data <- read.spss(file = fileName, to.data.frame = T)

raw_data
str(raw_data)

# 코드 북 파일 : Koweps_Codebook.xlsx
welfare <- raw_data[c('h10_g3', 'h10_g4', 'h10_g10', 'h10_g11', 'h10_eco9', 'p1002_8aq1', 'h10_reg7')]
str(welfare)
dim(welfare)
