# 귀무 가설 채택 여부
chk_chi <- function(res) {
  if(res$p.value > 0.05) {
    cat('귀무 가설 채택')
  } else {
    cat('귀무 가설 기각 ')
  }
}

data <- data.frame(Berverage = c('사이다', '콜라', '주스', '환타', '물'), qty = c(31, 35, 54, 61, 81))
data

chisq_res <- chisq.test(data$qty)

chk_chi(chisq_res)
