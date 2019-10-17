par(family = 'D2Coding')
mcolor <- rainbow(10)

data <- read.csv('../../../R_data/191015/2000-2013년 연령별실업율_연령별평균_세로.csv', header = T)
data
str(data)
dim(data)
head(data)

# 20대 데이터 가져오기
age20 <- data[,2]
age20

plot(age20, xlab = '', ylab = '', main = '연령별 실업율 현황', col = 'violet', type = 'o', lwd = 2, axe = F, ylim = c(0, 11))

len <- c(3:6)

# 모든 연령대의 데이터 가져오기
for(idx in len) {
  age <- data[, idx]
  # 추가적인 그래프를 그릴때 사용 
  lines(age, col = mcolor[idx - 2], type = 'o', lwd = 2)
}

srow <- nrow(data)
srow

colname <- data$연도
colname

axis(side = 1, at = 1:srow, label = colname, las = 2)
axis(side = 2, las = 1)

# Guide line
abline(h = seq(0, 10, 0.5), v = seq(1, srow, 1), lty = 2, lwd = 0.5)

column_name <- colnames(data[2:6])

# gsub함수로 replace all 가능
column_name <- gsub('X', '', column_name)
column_name

colors <- c('violet', mcolor)
legend('topright', column_name, cex = 0.7, col = colors, lty = 1, lwd = 2, bg = 'white')
