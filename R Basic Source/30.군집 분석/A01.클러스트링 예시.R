vec <- c(2, 5, 2, 4, 4, 5, 5, 6, 4, 1)
mat <- matrix(vec, nrow=5, byrow = T)
rownames(mat) <- c('A', 'B', 'C', 'D', 'E')
# rownames(mat) <- c('짜장면', '짬뽕', '라면', '우동', '돈가스')

colnames(mat) <- c('속성1', '속성2')
mat

library(cluster)

distance <- dist(mat)
distance <- dist(mat, diag = T)
# as.matrix(distance)

newdist <- distance **2
newdist

hc <- hclust(distance, method='single')
plot(hc)

mds <- cmdscale(distance)
plot(mds , type = "n")
text(mds , rownames(mat))
