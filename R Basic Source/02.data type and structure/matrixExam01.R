mat_a <- matrix(c(1, 2), nrow=2)
mat_a

mat_b <- matrix(c(-2, 3), nrow=2)
mat_b

mat_c <- matrix(c(3, 2, -1, 0), nrow=2, byrow=T)
mat_c


## 행렬 A, B, C가 있을때 AB, AC, BA, CB 구하기 
ab <- mat_a %*% mat_b
ab

ac <- mat_a %*% mat_c
ac

ba <- mat_b %*% mat_a
ba

cb <- mat_c %*% mat_b
cb

acb <- mat_a %*% cb
acb
