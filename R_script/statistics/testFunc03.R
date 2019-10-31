library(ggplot2)
library(gmodels)

# 귀무 가설 채택 여부
## param : test result
chk_test <- function(res) {
  print(res)
  cat('p value : ', res$p.value, '\n')
  if(res$p.value > 0.05) {
    cat('가설 채택', '\n')
  } else {
    cat('가설 기각 ', '\n')
  }
}


# 귀무가설 : 동전의 앞면과 뒷면의 비율은 차이가 없다.

res <- prop.test(x = 42, n = 100, p = 0.5)

chk_test(res)
