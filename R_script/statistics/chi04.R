# 귀무가설(H0) : 커피 브랜드와 성별의 연관성은 없다.

library(ggplot2)
library(gmodels)

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

chisq01 <- read.csv('카이제곱검정01.csv', header = T)
head(chisq01)
str(chisq01)

table(chisq01$gender)
table(chisq01$brand)

mTable <- table(gender = chisq01$gender, brand = chisq01$brand)
mTable

chk_chi(mTable)

CrossTable(x = chisq01$gender, y = chisq01$brand, chisq = T, dnn = c('gender', 'brand'))
