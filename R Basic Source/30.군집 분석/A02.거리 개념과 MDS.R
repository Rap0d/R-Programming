cmdscale <- read.csv("cmdscale.csv" , stringsAsFactors = F , header = T)

head(cmdscale) 

# 행렬 만들기
cmd_matrix <- t(as.matrix(cmdscale)) %*% as.matrix(cmdscale)
cmd_matrix

distance <- dist(cmd_matrix)
distance

cluster = hclust(distance)
cluster

plot(cluster)

# cmdscale : Classical (Metric) Multidimensional Scaling
mds <- cmdscale(distance)
plot(mds , type = "n")
text(mds , rownames(cmd_matrix))
