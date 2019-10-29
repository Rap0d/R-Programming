# 행렬의 곱 연산 
a <- matrix(c(1, 1, 1000, 500), ncol = 2, byrow = T)
b <- matrix(c(7, 4500), ncol = 1, byrow = T)
# solve 함수를 사용 
solve(a, b)

# 2번 문제
# 문제01 
# 3x + 2y – z = 12 
# x + y + z = 6 
# x -2y – z = -2 
# x = 3, y = 2, z = 1 

a <- matrix(c(1, 2, 0, 0, 2, 3, 1, 0, 3), ncol = 3, byrow = T)
a
b <- matrix(c(0, 4, 8), ncol = 1, byrow = T)
b
solve(a, b)

# 문제02 
# x + 2y = 0 
# 2y + 3z = 4 
# x + 3z = 8 
# x = 2, y = -1, z = 2

# 대각선 그리기
x <- seq(-5, 5, 0.05)
y <- 2/3*x - 1/3
plot(x, y, xlim = c(-5, 5), ylim = c(-10, 10), axes=F, col="red")

par(new=T)
y <- -2/3*x + 1/3
plot(x, y, xlim = c(-5, 5), ylim = c(-10, 10), axes=F, col="blue")

par(new=T)
y <- -2/3*x - 1/3
plot(x, y, xlim = c(-5, 5), ylim = c(-10, 10), axes=F, col="green")

par(new=T)
y <- -(3/2)*x + 1/2
plot(x, y, xlim = c(-5, 5), ylim = c(-10, 10), axes=F, col="yellow")

x <- seq(-5, 5, 0.05)
y <- x**2
plot(x, y, xlim = c(-5.5, 5.5), ylim = c(-1, 25), col = "red")

par(new = T)
y <- (2*x)**2
plot(x, y, xlim = c(-5.5, 5.5), ylim = c(-1, 25), col = "blue")
abline(h=0, v=0)

x <- seq(-5, 5, 0.05)
y <- 2 * x**2

myxilm <- c(-5.5, 5.5)
myyilm <- c(-1, 51)
plot(x, y, xlim = myxilm, ylim = myyilm, col="red", cex=0.5)

par(new = T)
y <- 2*(x-3)**2+1
plot(x, y, xlim = myxilm, ylim = myyilm, col="blue", cex=0.5)

par(new = T)
y <- 2*(x+3)**2-1
plot(x, y, xlim = myxilm, ylim = myyilm, col="green", cex=0.5)

abline(h=0, v = 0)

x <- seq(-3, 7, 0.05)
y <- -x^2+(4*x)-3
plot(x, y, col="red", cex=0.5)
abline(h=0, v = 0)

# 메트릭스 로 계산해보기
a <- matrix(c(1, 1, 1, 16, 4, 1, 4, 2, 1), ncol = 3, byrow = T)
a
b <- matrix(c(0, 0, 2), ncol = 1, byrow = T)
an <- solve(a, b)

x <- seq(-0, 5, 0.05)
y <- an[1] * x^2 + an[2] * x + an[3]
plot(x, y, col="red", cex=0.5)
abline(h=0, v=0)


# 순열
# install.packages('gtools')
library(gtools)
n = 10
r = 3
x = 4

perm <- combinations(n, r)
com <- combinations(x, r)

nrow(perm) - nrow(com)
perm
