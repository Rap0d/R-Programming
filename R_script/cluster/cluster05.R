colnames(iris)
unique(iris$Species)

idist <- dist(iris[1:4])
hc <- hclust(idist)
hc
plot(hc)

K = 3
rect.hclust(hc, k=K, border=rainbow(K))

ghc <- cutree(hc, k=K)
unique(ghc)

iris$ghc <- ghc
colnames(iris)

table(iris$ghc)
# 1  2  3
# 50 72 28

g1 <- subset(iris, ghc==1)
summary(g1[1:4])

g2 <- subset(iris, ghc==2)
summary(g2[1:4])

g3 <- subset(iris, ghc==3)
summary(g3[1:4])