# 저는 위의 수식을 이용해서
# 2-means를 R로 시뮬레이션을 해볼께요.
# 즉, 군집이 2개인 경우인거죠.

dis <- function(x, y){
  return ((x[1]-x[2])^2 + (y[1]-y[2])^2)
}
x <- c(rnorm(20, 3, 1), rnorm(20, 7, 1))
y <- c(rnorm(20, 4, 1), rnorm(20, 8, 1))
plot(x, y, cex=0.5, xlim=c(0, 10), ylim=c(0, 10))

c <- data.frame(x=c(2, 6), y=c(5, 8))
c$x

points(c$x, c$y, pch=20, col='red', cex=1.5)

distance1 <- c()
for(i in 1:length(x)){
  lines(c(x[i], c$x[1]), c(y[i], c$y[1]), lty=2)
  distance1 <- c(distance1, dis(c(x[i], c$x[1]), c(y[i], c$y[1])))
}
distance1

plot(x, y, cex=0.5, xlim=c(0, 10), ylim=c(0, 10))
points(c$x, c$y, pch=20, col='red', cex=1.5)
distance2 <- c()
for(i in 1:length(x)){
  lines(c(x[i], c$x[2]), c(y[i], c$y[2]), lty=2)
  distance2 <- c(distance2, dis(c(x[i], c$x[2]), c(y[i], c$y[2])))
}
distance2

clusters <- c()
f <- factor(distance1 > distance2)
levels(f) <- c('1', '2')
f

x1_var <- mean(x[f=='1'])
x2_var <- mean(x[f=='2'])
y1_var <- mean(y[f=='1'])
y2_var <- mean(y[f=='2'])
x1_var ;  x2_var ; y1_var ; y2_var

c$x - c(x1_var, x2_var)
c$y - c(y1_var, y2_var)

plot(x, y, cex=0.5, xlim=c(0, 10), ylim=c(0, 10))
points(c(x1_var, x2_var), c(y1_var, y2_var), pch=20, col='red', cex=1.5)
distance1 <- c()
for(i in 1:length(x)){
  lines(c(x[i], x1_var), c(y[i], y1_var), lty=2)
  distance1 <- c(distance1, dis(c(x[i], x1_var), c(y[i], y1_var)))
}
distance1


plot(x, y, cex=0.5, xlim=c(0, 10), ylim=c(0, 10))
points(c(x1_var, x2_var), c(y1_var, y2_var), pch=20, col='red', cex=1.5)
distance2 <- c()
for(i in 1:length(x)){
  lines(c(x[i], x2_var), c(y[i], y2_var), lty=2)
  distance2 <- c(distance2, dis(c(x[i], x2_var), c(y[i], y2_var)))
}
distance2


clusters <- c()
f <- factor(distance1 > distance2)
levels(f) <- c('1', '2')
f

x1_var <- mean(x[f=='1'])
x2_var <- mean(x[f=='2'])
y1_var <- mean(y[f=='1'])
y2_var <- mean(y[f=='2'])
x1_var ;  x2_var ; y1_var ; y2_var

c$x - c(x1_var, x2_var)
c$y - c(y1_var, y2_var)