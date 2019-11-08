library(cvTools)

mFrame <- data.frame(col = c(1:10))

cross <- cvFolds(n = nrow(mFrame), K = 5, R = 2)
str(cross)
cross

names(cross)
class(cross)
cross$which
cross$subsets
cross$subsets[cross$which == 4, 2]

kVal <- 5
rVal <- 2

K <- 1:kVal
R <- 1:rVal

for(r in R) {
  cat('---------------------------------------\n')
  for(k in K) {
    cat(r, ' : ', k, '\n')
  }
}
