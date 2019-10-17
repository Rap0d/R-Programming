v1 <- c(10, 12, 15, 11, 20)
v2 <- c(5, 7, 15, 8, 9)
v3 <- c(11, 20, 15, 18, 13)

# boxplot
boxstats <- boxplot(v1, v2, v3, col = c('blue', 'yellow', 'pink'), names = c('B', 'Y', 'P'), horizontal = T)

boxstats
