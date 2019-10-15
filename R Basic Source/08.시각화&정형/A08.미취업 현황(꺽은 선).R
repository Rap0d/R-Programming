data <- read.csv('2000-2013년 연령별실업율_연령별평균_세로.csv', header=TRUE)

str(data)
dim(data) # [1] 14  6
head(data)

age_20 <- data[, 2] # 20대의 데이터 정보
age_20

plot(age_20, xlab='', ylab='', ylim=c(0, 11), axes=FALSE, 
	main='연령별 실업률 현황', col='violet', type='o', lwd=2)

# 30대 부터 60대까지의 색상
mycolor <- rainbow( 4 )

for( idx in c(3:6)){ # 반복문 사용
  age <- data[, idx]
  lines(age, col=mycolor[idx - 2], type='o', lwd=2)
}

rowsu <- nrow(data)
rowsu

colname <- data$연도
colname

# x축(1) y축(2)
axis(side=1, at=1:rowsu, label=colname, las=2)
axis(side=2, las=1)

# 수평 수직 눈금 그리기
abline(h=seq(0, 10, 0.5), v=seq(1, rowsu, 1), lty=2, lwd=0.2)

column_name <- colnames(data[2:6])
column_name

# gsub(바뀔단어, 새단어, 작업대상) 
# gsub('X', '', col) : col을 대상으로 문자열 X를 빈 문자열로 치환
new_col_name <- gsub('X', '', column_name)
new_col_name

colors <- c('violet', mycolor)

legend('topright', new_col_name, cex=0.8, 
	col=colors, lty=1, lwd=2, bg='white')
# 연령별 실업률 현황.png