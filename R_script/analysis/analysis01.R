getLinearReg <- function(data01) {
  # 독립변수
  x <- data01[,2]
  # 종속변수
  y <- data01[,1]
  
  model <- lm(y ~ x, data = data01)
  plot(data01, pch = '*', lwd = 2, cex = 2.0, col = 'blue', main = 'y = 2 * x + 1 linear regression')
  abline(coef(model), col = 'red', lwd = 2)
}

test <- read.csv('test02.csv', header = T)

test[,2]
getLinearReg(test)

summary(test)

x <- test$x
y <- test$y

model <- lm(y ~ x, data = test)
model

attributes(model)

model$coefficients

fitted.values(model)

resi <- residuals(model)

resi_square_tot <- sum(resi ** 2)
resi_square_tot

summary(model)
