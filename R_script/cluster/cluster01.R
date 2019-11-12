library(cluster)

vec <- c(2, 5, 2, 4, 4, 5, 5, 7, 4, 1)
mat <- matrix(vec, nrow = 5, byrow = T)
rownames(mat) <- c('jjajang', 'jjambbong', 'noodle', 'udong', 'steak')
colnames(mat) <- c('attr 1', 'attr2')
mat

dist1 <- dist(mat)
dist1

dist2 <- dist(mat, diag = T)
dist2

hc <- hclust(dist, method = 'single')
plot(hc)

# 군집화
mds <- cmdscale(dist)
plot(mds, type = 'n')
text(mds, rownames(mat))
