# make sample data
name <- c('kim', 'park', 'lee', 'kang', 'shin')
gender <- c('M', 'F', NA, 'M', 'F')
score <- c(10, 20, 30, 40, NA)
df <- data.frame(name = name, gender = gender, score = score)

#########

# 결측치 확인
is.na(df)

# 결측치 개수 확인
sum(is.na(df))

# 개별 컬럼의 결측치 확인
is.na(df$gender)

# table 함수 : 빈도 확인
table(is.na(df))
# FALSE  TRUE 
# 13     2 

library(dplyr)
# 결측치만 필터링 하기 
df %>% filter(is.na(score))
df %>% filter(is.na(gender))
# name gender score
# 1 shin      F    NA
# name gender score
# 1  lee   <NA>    30

df_nomiss <- df %>% filter(!is.na(gender) & !is.na(score))
df_nomiss

# omit 함수를 이용한 필터링
df_nomiss2 <- na.omit(df)
df_nomiss2

std <- read.csv('jumsu2.csv')
std

std[c(3, 8, 15), 'kor'] <- NA
std

# mean 함수 안에 결측치 제거
# 결측치 값을 아예 제외한 17개의 평균을 구함
std %>% summarise(mean_kor=mean(kor, na.rm = T))
