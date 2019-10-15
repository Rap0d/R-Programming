# 분석 01 : 한국 복지 패널 데이터 준비하기

setwd('d:/r_test')

# foreign 패키지 : 외부 통계 프로그램(SAS, SPSS 등등) 파일 읽어 오기
install.packages('foreign')
install.packages('readxl')
install.packages('ggplot2')
install.packages('dplyr')

library(foreign)
library(ggplot2)
library(dplyr)
library(readxl) # 엑셀 파일 불러 오기

filename <- 'Koweps_hpc10_2015_beta1.sav'
raw_welfare <- read.spss(file = filename, to.data.frame = TRUE)
str(raw_welfare)
head(raw_welfare, 2)
class(raw_welfare) # "data.frame"
dim(raw_welfare) # class(raw_welfare)

# 코드 북 파일 : Koweps_Codebook.xlsx
# 필요한 컬럼만 다시 추출하기
welfare <- raw_welfare[c('h10_g3', 'h10_g4', 'h10_g10', 
                         'h10_g11', 'h10_eco9', 'p1002_8aq1', 'h10_reg7')]
head(welfare)

# help(rename)
# 가독성 있게 컬럼 이름을 변경( colnames로도 가능)
welfare <- rename(welfare, gender=h10_g3, birth=h10_g4, 
                  marriage=h10_g10, religion=h10_g11, code_job=h10_eco9, 
                  income=p1002_8aq1, code_region=h10_reg7 )
head(welfare)
tail(welfare)
dim(welfare) # 16664     7
str(welfare)

write.csv(welfare, 'welfare.csv', row.names=F, quote=F)