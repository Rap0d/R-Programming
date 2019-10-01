2+3*4
(2+3)*4
1e+3

a <- 14
b <- 4

a+b
a-b
a*b
a/b

a %/% b   # 몫
a %% b    # 나머지 

2 ** 3    # 제곱 
2 ^ 3     # 제곱

su1 <- 17
su2 <- 5

# 몫
su1 %/% su2
# 나머지 
su1 %% su2

# ':' 은 연속형 데이터 
aa <- c(1:1000)
aa

# ',' 은 이산형 데이터 
bb <- c(300:500, 800:900)
bb

fbb <- as.factor(bb)
plot(fbb)

# seq 의 활용 
cc <- seq(from=1, to=5)
cc <- seq(from=1, to=10, by=2)
cc

# reverse
rev(1:10)

# replicates
hh <- rep(1:2, 3)
ii <- rep(1:2, each=3)

jj <- rep(c(2, 3, 5), each=3)


           