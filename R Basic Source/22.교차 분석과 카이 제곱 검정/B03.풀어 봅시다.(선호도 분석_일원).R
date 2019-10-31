data <- data.frame(Beverage=c('사이다', '콜라', '오렌지', '환타', '망고 주스'), qty=c(31, 35, 54, 61, 81))
data

chisq.test(data$qty)
# Chi-squared test for given probabilities
# 
# data:  data$qty
# X-squared = 31.588, df = 4, p-value = 2.322e-06

# p-value < 0.05이므로 귀무 가설을 기각한다.
# 즉, 스포츠 음료에 대한 선호도에 차이가 있다.