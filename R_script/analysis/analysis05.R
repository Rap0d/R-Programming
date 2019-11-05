library(car)

product <- read.csv('product.csv')
str(product)
head(product)

colnames(product) <- c('xdata1', 'xdata2', 'ydata')
head(product)

model <- lm(formula = ydata ~ xdata1 + xdata2, data = product)
model

# vif() : 다중공선성이 있는지 검증하는 함수 
## 다중 공선성 : 독립 변수가 여러개일 때, 독립 변수간 강한 상관관계를 가지는 현상.
## 다중 공선성을 가지면 여러 독립 변수를 사용하는 의미가 없어진다. 
## 따라서 연관성을 갖는 독립변수를 제거하는 과정을 거쳐야 한다.
vif_res <- vif(model)
class(vif_res)

table(vif_res >= 10.0)
# FALSE 
# 2 
## 다중공선성을 갖지 않음 