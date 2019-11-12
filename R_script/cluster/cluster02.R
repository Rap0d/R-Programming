library(cluster)

data <- read.csv('cmdscale.csv', header = T, stringsAsFactors = F)

mat <- t(as.matrix(data)) %*%  as.matrix(data)
mat

dist <- dist(mat)
dist

cluster <- hclust(dist)

par(family = 'AppleGothic')
plot(cluster)

# classical multi dimensional scaling
mds <- cmdscale(dist)
plot(mds, type = 'n')
text(mds, rownames(mat))