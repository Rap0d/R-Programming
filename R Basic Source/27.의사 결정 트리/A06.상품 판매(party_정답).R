sales = read.csv("product_sales.csv") 
str(sales)
head(sales)
 

idx = sample(1:nrow(sales), 0.7* nrow(sales))
train = sales[idx, ]
test = sales[-idx, ]
 
formula = tot_price ~ .
model = ctree(formula = formula, data = train)
model 

plot(model)