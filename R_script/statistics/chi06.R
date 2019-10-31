# 나이(age3)와 직위(position) 간의 관련성을 단계별로 분석하시오. [독립성 검정]
# 
# 파일 이름 : cleanData.csv
# 
# 단계1: 파일 가져오기
# 
# 단계2: 코딩 변경(변수 리코딩)
# 
# 단계3: plot(x,y) 함수를 이용한 산점도를 이용한 변수간의 관련성 보기
# 
# 단계4: 독립성 검정 : CrossTable(x,y, chisq = TRUE)
# 
# 단계5: 검정 결과 해석

# 귀무가설(H0) : 나이와 직위간 관련성은 없다. 

library(ggplot2)
library(gmodels)
library(RColorBrewer)

# 귀무 가설 채택 여부
## param : Table
chk_chi <- function(res) {
  chisq <- chisq.test(res)
  if(chisq$p.value > 0.05) {
    cat('귀무 가설 채택')
  } else {
    cat('귀무 가설 기각 ')
  }
}

data <- read.csv('cleanData.csv')
head(data)

data$position2 <- factor(data$position, levels = c(1, 2, 3, 4, 5), labels = c('부장', '차장', '과장', '대리', '사원'))

tableTot <- table(data$position2, data$age2)
tableTot

df <- as.data.frame(tableTot)
df

ggplot(df, aes(x = Var1, y = Var2)) + geom_point(aes(color = Freq)) + scale_color_gradient(low = "transparent", high = "red") + theme_minimal(base_family = 'D2Coding')

CrossTable(tableTot, chisq = T)

# Pearson's Chi-squared test 
# ------------------------------------------------------------
# Chi^2 =  287.8957     d.f. =  8     p =  1.548058e-57 

## p 값이 10^-57 * 1.54 이므로, 귀무가설이 기각 되었다.
## 따라서, 나이와 직위간 관련성이 있다고 볼 수 있다. 
