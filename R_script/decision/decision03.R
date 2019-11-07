library(party)

str(airquality)
colnames(airquality)

mFormula <- Temp ~ Ozone + Solar.R + Wind
model <- ctree(formula = mFormula, data = airquality)

model

plot(model)
