# 첨부된 파일을 이용하여 해당 범죄 건수와 내외국인 숫자와의 상관 관계를 분석해 보세요.
# 첨부 : 범죄와외국등록일반.csv

library(corrplot)
library(corrgram)

data <- read.csv('범죄와외국등록일반.csv')
summary(data)
sd(data$범죄)
sd(data$외국인)
sd(data$내국인)

c1 <- cor(data$범죄, data$외국인)
c2 <- cor(data$범죄, data$내국인)
c1;c2

cor(data$외국인, data$내국인)

mat <- cbind(c1, c2)
mat

colnames(mat) <- c('외국인', '내국인')

barplot(mat, main = '범죄와 내외국인의 상관 계수', ylim = c(0, 1.0), col = rainbow(2))

cor(data)

corrgram(data)

corrgram(data, upper.panel = panel.conf)
