x <- c(3, 5, 8, 11, 13)
y <- c(6, 11, 16, 22, 26)
plot(x, y, type = 'o', cex = 1.5)

## 피어슨 상관 계수 유도 과정
mean_x <- mean(x)
mean_y <- mean(y)

c <- sum((x - mean_x) * (y - mean_y))
m <- sqrt(sum((x - mean_x) ** 2) * sum((y - mean_y) ** 2))

corr <- c / m
corr

## cor() : 피어슨 상관 계수 함수
cor(x, y)

# 공분산 (covariance)
## 상관 계수(x, y) = 공분산(x, y) / (표준편차(x) * 표준편차(y))
sd_x <- sd(x)
sd_y <- sd(y)

# covariance(cov)
corr * sd_x * sd_y
cor(x, y)
cov(x, y)