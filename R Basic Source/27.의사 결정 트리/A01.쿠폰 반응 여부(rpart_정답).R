customer <- read.csv('custom_info.csv', header=T)
str(customer)
colnames(customer)

customer$job <- as.factor(customer$job)
unique(customer$job)
customer$marriage <- as.factor(customer$marriage)
customer$iscar <- as.factor(customer$iscar)
customer$coupon <- as.factor(customer$coupon)

no <- 12
yes <- 18
total <- no + yes

-(no/total)*log2(no/total)-(yes/total)*log2(yes/total)

# 엔트로피를 이용하는 방법
get_entropy <- function(x) { 
  factor_x <- factor(x) 
  # cat(factor_x, '\n')
  # cat(levels(factor_x), '\n')
  # cat(length(x), '\n')
  entropy <- 0 
  for(item in levels(factor_x)) {
    prob <- sum(x == item) / length(x) 
    entropy <- entropy - prob * log2(prob) 
  }
  return (entropy)
}

coupon_entropy <- get_entropy(customer[, 'coupon'])
coupon_entropy

levels(customer[['gender']])

max_value <- -999999
min_value <- +999999

for(str in colnames(customer)[1:5]){
  factors <- levels(customer[[str]])
  
  sum_entropy <- 0
  for(str2 in factors){
    test_x <- customer[customer[[str]] == str2, ][6]
    sum_entropy <- sum_entropy + get_entropy(test_x[,1])
  }
  if(max_value < sum_entropy){
    max_value = sum_entropy
  }
  if(min_value > sum_entropy){
    min_value = sum_entropy
  }
  cat(str, '-->', sum_entropy, '\n')
}

max_value
min_value

# '결혼여부' 컬럼이 'coupon' 컬럼에 영향을 많이 준다.

library(rpart)
tree1 <- rpart(coupon~., data=customer, control=rpart.control(minsplit = 2))
plot(tree1, compress=T, uniform=T, margin=0.1)
text(tree1, use.n=T, col='blue')

# minsplit : 최소가지치기 개수
# compress : 세로폭
# uniform : 가로폭
# leaf에 있는 2개의 숫자 : NO/YES

tree1

# 카이 제곱 검정
# xtabs(~결혼여부 + coupon, data=customer )
mytable <- table(marriage=customer$marriage, coupon=customer$coupon)

chisq.test(mytable)
# 카이제곱 approximation은 정확하지 않을수도 있습니다
# 메시지는 너무 데이터가 적어서 나오는 경고 메시지이다.

# p-value(0.005658)이 적을 수록 잘 나누어 진 것이다.

# 지니 계수를 이용하는 방법
get_gini <- function(x){
  factor_x <- factor(x)
  gini_sum <- 0
  for( str in levels(factor_x)){
    prop <- sum(x== str) / length(x)
    gini_sum <- gini_sum + prop^2
  }
  return (1 - gini_sum)
}

coupon_gini <- get_gini(customer[, 'coupon'])
coupon_gini

for(str in colnames(customer)[1:5]){
  factors <- levels(customer[[str]])
  
  sum_gini <- 0
  for(str2 in factors){
    test_x <- customer[customer[[str]] == str2, ][6]
    sum_gini <- sum_gini + get_gini(test_x[,1])
  }
  cat(str, '-->', sum_gini, '\n')
}