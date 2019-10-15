install.packages('foreign')

library(ggplot2)
library(dplyr)
library(foreign) # 외부 통계 프로그램 읽어 오기(sas, spss)

# Warning message:
#   In read.spss(file = filename, to.data.frame = T) :
#   Koweps_hpc10_2015_beta1.sav: Compression bias (0) is not the usual value of 100

filename <- 'Koweps_hpc10_2015_beta1.sav'
raw_welfare <- read.spss(file=filename, to.data.frame = T)
class(raw_welfare) # "data.frame"
dim(raw_welfare) # 16664   957

welfare <- raw_welfare[c('h10_g3' , 'h10_g4' , 'h10_g10' , 'h10_g11' , 'h10_eco9' , 'p1002_8aq1' , 'h10_reg7')]

head(welfare)

welfare <- rename(welfare, gender=h10_g3, birth=h10_g4, marriage=h10_g10, religion=h10_g11, code_job=h10_eco9, income=p1002_8aq1, code_religion= h10_reg7)

colnames(welfare)

head(welfare)
tail(welfare)
dim(welfare)
str(welfare)

write.csv(welfare, 'welfare.csv', row.names = F, quote=F)