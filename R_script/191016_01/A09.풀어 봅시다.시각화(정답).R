# R정형데이터처리하기.xlsx 파일을 이용하여 다음 물음에 답하시오.
# readxl 패키지도 있음
# install.packages('xlsx')

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_221')
library(rJava)
library(xlsx)

myencoding = 'UTF-8'

filename = 'R정형데이터처리하기.xlsx'

# 출장비지급내역 시트
# 교통비와 식비를 이용하여 산점도 그래프 그리기
# 출장비 지급 내역
business <- read.xlsx(file=filename, sheetIndex = 2, encoding=myencoding)
xdata <- business$교통비
ydata <- business$식비

# x, y를 이용하여 산점도 그래프 그리기
plot( x=xdata, y=ydata, main='교통비/식비 산점도', xlab='교통비', ylab='식비', col='red', cex=2.0, xlim=c(45000, 140000), ylim=c(50000, 200000))

# 가전제품1 시트
# 1일 생산량을 이용하여 세로 막대 그래프 그리기
homeware <- read.xlsx(file=filename, sheetIndex = 3, encoding=myencoding)

prodname <- homeware$제품명
prodname
oneday <- homeware$X1일생산량
oneday

quarter1 <- unlist(oneday)
names(quarter1) <- prodname
class(quarter1)
quarter1

mylegend <- prodname
simcolor <- rainbow(length(quarter1))
barplot(quarter1, main='일사분기 일일 생산량', beside = T, col=simcolor, horiz=F, legend=mylegend, ylim=c(0, max(quarter1) + 10)) 

title(xlab='가전 제품 이름', col.lab='blue')

# 가전제품1 시트 ~ 가전제품3 시트와 '사사분기.csv' 파일을 이용하여
# 사분기 데이터 프레임(이름 : quarter_table)을 만드세요.

sheets <- seq(3, 5) # 3번째 시트부터 5번째 까지

quarter_table <- data.frame()

for( onesheet in sheets ){
  print(onesheet)
  dframe <- read.xlsx(file=filename, sheetIndex = onesheet, encoding=myencoding)
  dframe$bungi <- paste((onesheet-2), "사분기", sep='')
  quarter_table <- rbind(quarter_table, dframe)
}

imsi <- read.csv('사사분기.csv')
imsi$bungi <- '4사분기'

quarter_table <- rbind(quarter_table, imsi)
quarter_table
 
# 이하 문제들은 quarter_table을 이용하면 된다
# 각 분기별/제품명의 1일 생산량으로 막대 그래프 그리기
bungidata <- quarter_table[c('제품명', 'X1일생산량', 'bungi')]
bungidata

library(reshape2)
bungidata <- dcast(bungidata, 제품명 ~ bungi, value.var = 'X1일생산량')
bungidata

prodname <- bungidata[1]
prodname
bungichart <- bungidata[2:5]
bungichart <- as.matrix(bungichart)

mycolor <- rainbow(nrow(prodname))
mylegend <- unlist(prodname)
mylegend

upp_y_lim <- max(bungichart) + 10

barplot(bungichart, main='분기별 판매 현황', beside = T, col=mycolor,  ylim=c(0, upp_y_lim))
# legend=mylegend,

legend("topright", legend = mylegend, fill=mycolor, bty = "o", cex=0.7, bg='lightyellow')

title(xlab='분기', col.lab='blue')


# 각 분기별 총 생산량의 평균을 이용하여 pie 그래프 그리기
library(dplyr)
result <- quarter_table %>% group_by( bungi ) %>% summarise(avgtotal=mean(총생산량, na.rm=TRUE))

chartdata <- result$avgtotal
mylabel <- result$bungi

pie(chartdata, main='분기별 총 생산량의 평균', clockwise = T, col=mycolor, labels=mylabel, radius = 0.8)

# 각 불량품 컬럼으로 히스토 그램(breaks=10) 그래프 그리기
badthing <- quarter_table$불량품
range(badthing)
histinfo <- hist(badthing, main='불량품', col=mycolor, xlab='키(cm)', ylab='도수', xlim=c(10, 60))
# breaks = 10,


# '총생산량', '불량품', '출고량'으로 boxplot을 그려 보세요.
# 불량품은 데이터의 값이 작아서 100을 곱한 다음 수행하시오.
boxdata <- quarter_table[c('총생산량', '불량품', '출고량')]
boxdata$불량품 <- 100 * boxdata$불량품
head(boxdata)
boxstats <- boxplot(boxdata, col=c('blue', 'yellow', 'pink'), names=c('총생산량', '불량품', '출고량'))
# , horizontal=T

# 각 분기별 총 생산량을 이용하여 꺽은 선 그래프 그리기
widedata <- dcast(quarter_table, 제품명 ~ bungi, sum, value.var='총생산량')
widedata

quarter01 <- widedata[, 2] # 20대의 데이터 정보
quarter01

plot(quarter01, xlab='', ylab='', axes=FALSE, ylim=c(0, 13000), 
     main='분기별 총생산량', col='violet', type='o', lwd=2)

mycolor <- rainbow( 3 )

for( idx in c(3:5)){ # 반복문 사용
  quarter <- widedata[, idx]
  lines(quarter, col=mycolor[idx - 2], type='o', lwd=2)
}

rowsu <- nrow(widedata)
rowsu

colname <- widedata$제품명
colname

# x축(1) y축(2)
axis(side=1, at=1:rowsu, label=colname, las=2)
axis(side=2, las=1)

# 수평 수직 눈금 그리기
abline(h=seq(0, 14000, 1000), v=seq(1, rowsu, 1), lty=2, lwd=0.2)

new_col_name <- colnames(widedata[2:5])
new_col_name

colors <- c('violet', mycolor)

legend('topright', new_col_name, cex=0.8, 
       col=colors, lty=1, lwd=2, bg='white')
# 분기별 총 생산량.png