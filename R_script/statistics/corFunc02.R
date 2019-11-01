# install.packages("corrplot")
library(corrplot)

corr_test = read.csv('cov_corr_test.csv', header = F)
str(corr_test)

mytable = table(corr_test$V1, corr_test$V2)
mytable

proptable = prop.table(mytable)
addmargins(proptable)

x = corr_test$V1
y = corr_test$V2

plot(x, y, type = 'o', lty = 1)
cor(x, y) # [1] 0.1423654

mCorr <- cor(corr_test)

par(mfrow = c(2,2))
corrplot(mCorr)
corrplot(mCorr, addCoef.col = 'red')
corrplot(mCorr, method = 'ellipse', addCoef.col = 'red')
corrplot(mCorr, method = 'ellipse', addCoef.col = 'yellow', type = 'upper')

