# 행렬의 곱 연산 
a <- matrix(c(1, 1, 1000, 500), ncol = 2, byrow = T)
b <- matrix(c(7, 4500), ncol = 1, byrow = T)
# solve 함수를 사용 
solve(a, b)


