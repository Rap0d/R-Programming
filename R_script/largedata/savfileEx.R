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
