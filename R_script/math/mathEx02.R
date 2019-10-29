# 표준 정규 분포 Z 변환

# 정규 분포를 따르는 데이터 1000개를 만들기
## rnorm()
## 평균은 mean, 표준 편차는 sd
g <- rnorm(n = 1000, mean = 250, sd = 20)
g
d <- rnorm(n = 1000, mean = 110, sd = 20)
d

h <- data.frame(g, d)
head(h)

par(mfrow = c(1, 2))
hist(h$g, freq = T)
hist(h$g, freq = F)

hist(h$d, freq = T)
hist(h$d, freq = F)

# scale : (x - mean) / sd
h <- transform(h, z.g = scale(g), z.d = scale(d))
h


