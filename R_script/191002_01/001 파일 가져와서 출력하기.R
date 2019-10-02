# 파일 가져와서 그 속성 보기 

getwd()
setwd("/Users/seungheonchang/Documents/Workspace/_3_rProgramming/R-Programming/R_data/191002_01")

abc = read.csv("abc.csv", header = T)
abc
print(abc)
View(abc)

head(abc, 3)
tail(abc)

# colnames, rownames
names(abc)
attributes(abc)

mode(abc)

str(abc)

abc$job

aTotal <- abc$total

abc[2]

abc[c('job', 'total')]

abc[c(1, 2, 3)]

abc[2, ]
abc[3, ]

# 1, 3행 보여주기 
abc[c(1,3),]

# 2, 4열 보여주기 
abc[, c(2,4)]

# 2, 5, 6열 보기
abc[, c(2, 5:6)]

# -가 붙으면 exclude
abc[, -c(2, 5:6)]

