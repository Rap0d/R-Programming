getLinearReg <- function(data01) {
  # 독립변수
  x <- data01[,2]
  # 종속변수
  y <- data01[,1]
  
  model <- lm(y ~ x, data = data01)
  
  par(family = 'AppleGothic')
  plot(x, y, pch = '*', lwd = 2, cex = 2.0, col = 'blue', main = 'linear regression')
  abline(coef(model), col = 'red', lwd = 2)
  return(model)
}

# param : model
getSummary <- function(model) {
  print(attributes(model))
  print(model$coefficients)
  print(fitted.values(model))
  print(residuals(model))
  print(sum(resi ** 2))
  print(summary(model))
  
  # R-squared : 독립 변수와 종속 변수와의 상관관계
  # 1에 가까울수록 이상적인 모델
}

data1 <- read.csv('시험 점수와 공부 시간1.csv')
data2 <- read.csv('시험 점수와 공부 시간2.csv')

model1 <- getLinearReg(data1)
model2 <- getLinearReg(data2)

summary(model1)
summary(model2)

getSummary(model1)
