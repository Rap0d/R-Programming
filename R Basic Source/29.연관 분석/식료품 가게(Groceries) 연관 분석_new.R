library(arules)

data('Groceries')
str(Groceries)
Groceries

Groceries.df <- as(Groceries, 'data.frame')
str(Groceries.df)
head(Groceries.df)

rules = apriori(Groceries, parameter = list(supp=0.001, conf=0.8))
# 410개의 규칙

inspect(head(rules))

install.packages('arulesViz')
library(arulesViz)

plot(rules, method='grouped')

rules = apriori(Groceries, parameter = list(supp=0.001, conf=0.8, maxlen=3))

inspect(rules)

plot(rules, method='grouped')

rules <- sort(rules, decreasing = T, by='confidence')

inspect(head(rules))

set.seed(1234)
plot(rules, method='graph', control=list(type='items'))

# %in% : ~을 포함하는
wmilk <- subset(rules, rhs %in% 'whole milk')
wmilk
inspect(wmilk)
plot(wmilk, method='graph')


vegetable <- subset(rules, rhs %in% 'other vegetables')
vegetable
plot(vegetable, method='graph')
plot(vegetable, method='scatterplot')

# %pin% : ~을 포함하는
veg <- subset(rules, rhs %pin% 'vegetables')
veg
inspect(veg)

butter_yogurt <- subset(rules, lhs %in% c('butter', 'yogurt') )
plot(butter_yogurt, method='graph')



