library(ggplot2)

mycf <- read.csv('mycf.csv', header = T)

head(mycf)
str(mycf)
# 광고 유형
unique(mycf$group)
# 광고 관심도
unique(mycf$interest)

mycf$group2 <- factor(mycf$group, levels = c(1, 2), labels = c('연예인 CF', '일반인 CF'))
mycf$interest2 <- factor(mycf$interest, levels = c(0, 1), labels = c('관심없음', '관심있음'))

# 교차 분할표
crossTable <- addmargins(table(mycf$group2, mycf$interest2))
crossTable

# 행방향
prop.table(crossTable, 1)
# 열방향
prop.table(crossTable, 2)

mFrame <- data.frame(crossTable)
mFrame

ggplot(mFrame, aes(x = Var2, y = Freq, fill = Var1, color = Var1)) + geom_col(position = 'dodge') + theme_minimal(base_family = 'AppleGothic') + labs(x = '집단 유형', y = '광고 관심도', title = '집단 유형별 광고 관심도')
