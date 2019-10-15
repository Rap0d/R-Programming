# R정형데이터처리하기.xlsx 파일을 이용하여 다음 물음에 답하시오.
library(rJava)
library(xlsx)
library(dplyr)
library(reshape2)
library(stringr)

xencoding <- 'UTF-8'
filename <- 'R_data/old/R정형데이터처리하기.xlsx'

par(family = 'D2Coding')
par(cex = 0.7)
mcolor <- rainbow(10)

# 출장비지급내역 시트
# 교통비와 식비를 이용하여 산점도 그래프 그리기
data1 <- read.xlsx(file = filename, sheetIndex = 2, encoding = xencoding)
data1
class(data1)
xlabel <- data1$사원명
xlabel
tranf <- data1$교통비
food <- data1$식비
tranf
food
range(tranf)
range(food)

plot(tranf, type = 'o', xlab = '사원명', ylab = '비용', col = 'magenta', ylim = c(50000, 200000))
par(new = T)
plot(food, type = 'o', ylab = "", xlab = "", ylim = c(50000, 200000), col = 'cyan')
legend(x = 16, y = 0.5, c('교통비', '식비'), cex = 0.7, col = c('magenta', 'cyan'))

# 가전제품1 시트
# 1일 생산량을 이용하여 세로 막대 그래프 그리기
# 
data2 <- read.xlsx(file = filename, sheetIndex = 3, encoding = xencoding)
oneday <- data2$X1일생산량
xlab2 <- data2$제품명
barplot(oneday, xlab = '제품명', ylab = '1일 생산량', names.arg = xlab2, cex.names = 0.7, ylim = c(0, 250), col = mcolor)


# 가전제품1 시트 ~ 가전제품3 시트와 '사사분기.csv' 파일을 이용하여
# 사분기 데이터 프레임(이름 : q_df)을 만드세요.
#
sheets <- seq(3, 5)
q_df <- data.frame()

q4 <- read.csv('R_data/191015/사사분기.csv')
q4
class(q4)

for( onesheet in sheets ){
  print(onesheet)
  dframe <- read.xlsx(file=filename, sheetIndex = onesheet, encoding=xencoding)
  dframe$qu <- paste((onesheet-2), "사분기", sep='')
  q_df <- rbind(q_df, dframe)
}
q4$qu <- '4사분기'
q_df <- rbind(q_df, q4)
colnames(q_df)
q_df
# 이하 문제들은 q_df을 이용
# 각 분기별/제품명의 1일 생산량으로 막대 그래프 그리기
qsub <- dcast(q_df, 제품명 ~ qu, value.var = 'X1일생산량')
qsub

pdn <- qsub[1]
pdn

chartdata <- qsub[2:5]
chartdata

chart1 <- as.matrix(chartdata)
mrow <- nrow(chart1)
barplot(chart1, beside = T, main = '각 분기별 제품의 1일 생산량', col = mcolor, ylim = c(0, 350), legend = qsub$제품명)

# 각 분기별 총 생산량의 평균을 이용하여 pie 그래프 그리기
q_df$총생산량 <- str_replace_all(q_df$총생산량, ',', '')
q_df$총생산량 <- str_trim(q_df$총생산량)
q_df$총생산량 <- as.numeric(q_df$총생산량)

qavg <- q_df %>% group_by(qu) %>% summarise(avg = round(mean(총생산량), 2))
pavg <- qavg$avg
lbls <- qavg$qu
pct <- round(pavg / sum(pavg) * 100)
lbls <- paste(lbls, pct)
lbls <- paste(lbls, '%', sep = "")
pie(qavg$avg, labels = lbls, main = '각 분기별 총 생산량의 평균')

# 불량품 컬럼으로 히스토 그램(breaks=10) 그래프 그리기
q_df
bad <- q_df$불량품

hist(bad, breaks = 10, freq = T)

# 각 분기별 총 생산량을 이용하여 꺽은 선 그래프 그리기
q_df

qua <- q_df$qu
qavg2 <- q_df %>% group_by(qu) %>% summarise(avg = round(mean(총생산량), 2))
avg4 <- qavg2$avg
plot(avg4, type = 'o', ylim = c(8000, 10000), axes = F)
axis(1, at=1:4, labels = c("1사분기", '2사분기', '3사분기', '4사분기'))
axis(2, ylim = c(8000, 10000))

