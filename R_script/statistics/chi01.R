# 카이 제곱

# 가설
## 귀무 가설 : 눈금이 나올 확률은 차이가 없다
### 가설은 부정적으로 세워야 함

data <- c(5, 6, 17, 15, 8, 9)

chisq_res <- chisq.test(data)

# p-value(유의 확률)가 0.05보다 작으면 기각 
chisq_res

# 귀무 가설 채택 여부
chk_chi <- function(res) {
  if(res$p.value > 0.05) {
    cat('귀무 가설 채택')
  } else {
    cat('귀무 가설 기각 ')
  }
}
chk_chi(chisq_res)

# 검정 통계량으로 해석하기
x_sq <- chisq_res$statistic
x_sq

chi_table <- 11.071

if(x_sq < chi_table) {
  cat('귀무 가설 채택')
} else {
  cat('귀무 가설 기각 ')
}

data2 <- c(10, 10, 10, 10, 10, 10)
chi_sq <- sum((data - data2)**2/data2)
chi_sq
