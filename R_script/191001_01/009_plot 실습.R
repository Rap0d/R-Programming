# plot 실습 

human <- c('man', 'woman', 'woman', 'man', 'man')

# 그냥 plot을 실행하면 오류가 뜬다. 카테고리로 변환 해주어야 차트를 볼 수 있다. 
plot(human)

mode(human)
class(human)

# factor 형태로 바꾸어짐.
nhuman <- as.factor(human)
mode(nhuman)
class(nhuman)

plot(nhuman)

# table 함수로 간단하게 볼 수 있음 
table(nhuman)

ohuman <- factor(human, levels=c('woman', 'man'), ordered = T)

plot(ohuman)


studentData <- read.csv('R_Script/191001_01/STM_DATA_VIEW.csv')

plot(studentData)

summary(studentData)

str(studentData)


dim(hflights)

dim(studentData)

sd_df <- tbl_df(studentData)

filter(sd_df, KOR, ENG, MATH)

table(sd_df)

arrange(sd_df, desc(KOR))

selectScore <- select(sd_df, NAME, KOR, ENG, MATH)

summarise(sd_df, kavg = mean(KOR, na.rm=T))

kScore <- group_by(sd_df, KOR)
plot(selectScore$NAME, selectScore$KOR)

help(ggplot)
example(ggplot)
