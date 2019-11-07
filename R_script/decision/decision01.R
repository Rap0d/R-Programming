library(rpart)

data <- read.csv('custom_info.csv')
data

str(data)
colnames(data)

data$job <- as.factor(data$job)
unique(data$job)

data$marriage <- as.factor(data$marriage)
data$iscar <- as.factor(data$iscar)
data$coupon <- as.factor(data$coupon)
str(data)

mCoupon <- table(data$coupon)
mCoupon

no <- mCoupon[1]
yes <- mCoupon[2]

tot <- no + yes

# 엔트로피 계산
- (no / tot) * log2(no / tot) - (yes / tot) * log2(yes / tot)

getEntropy <- function(x) {
  facX <- factor(x)
  
  sumEntropy <- 0
  for(i in levels(facX)) {
    prob <- sum(x == i) / length(x)
    sumEntropy <- sumEntropy - prob * log2(prob)
  }
  return(sumEntropy)
}

couponEntropy <- getEntropy(data[, 'coupon'])
couponEntropy

chkList <- colnames(data)[1:5]
chkList

for(i in chkList) {
  mEntropy <- getEntropy(data[,i])
  cat(i, ' : ', mEntropy, '\n')
}

# tree 생성
## minsplit : 가지치기 개수
tree1 <- rpart(coupon ~ ., data = data, control = rpart.control(minsplit = 2))
plot(tree1, compress = T, uniform = T, margin = 0.1)
text(tree1, use.n = T, col = 'blue')
tree1
# node), split, n, loss, yval, (yprob)
# * denotes terminal node

mTable <- table(marriage = data$marriage, coupon = data$coupon)
chisq.test(mTable)
# p-value : 작을수록 잘 나누어진 것.

# 지니 계수 구하기
getGini <- function(x) {
  facX <- factor(x)
  
  sumGini <- 0
  for(i in levels(facX)) {
    prob <- sum(x == i) / length(x)
    sumGini <- sumGini + prob ** 2
  }
  return(1 - sumGini)
}

couponGini <- getGini(data[, 'coupon'])
couponGini

for(i in chkList) {
  mGini <- getGini(data[,i])
  cat(i, ' : ', mGini, '\n')
}