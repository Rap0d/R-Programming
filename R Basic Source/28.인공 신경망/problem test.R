prob <- read.csv('problem.csv', stringsAsFactors = F, header=T)
head(prob)
dim(prob) # 50행 31열

# 30열까지가 질문에 대한 응답 정보
for(i in 1:30){
  prob[i] <- prob[i] * (1/5)
}
head(prob)

normalize <- function(x){
  return( (x-min(x))/diff(range(x)))
}

# for(i in 1:30){
#   prob[i] <- normalize(prob[i])
# }
# head(prob)

unique(prob$accident)
condition <- prob$accident == 'suicide' | prob$accident == 'violence'
condition
prob$accident2 <- with(prob, ifelse( condition, 1, -1 ))
head(prob)

library(nnet)

m1 <- nnet(accident2 ~ ., data = prob, size = 10)
m1

r1 <- predict(m1, prob)
head(r1)

cbind(prob$accident2, r1 < 0.5)
