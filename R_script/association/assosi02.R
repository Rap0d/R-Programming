library(arules)

data <- read.transactions('groceries.csv', sep = ',')
dim(data)
#[1] 9835  169

summary(data)
# transactions as itemMatrix in sparse format with
# 9835 rows (elements/itemsets/transactions) and
# 169 columns (items) and a density of 0.02609146 
# 
# most frequent items:
#   whole milk other vegetables       rolls/buns             soda           yogurt          (Other) 
# 2513             1903             1809             1715             1372            34055 
# 
# element (itemset/transaction) length distribution:
#   sizes
# 1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22 
# 2159 1643 1299 1005  855  645  545  438  350  246  182  117   78   77   55   46   29   14   14    9   11    4 
# 23   24   26   27   28   29   32 
# 6    1    1    1    1    3    1 
# 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   2.000   3.000   4.409   6.000  32.000 
# 
# includes extended item information - examples:
#   labels
# 1 abrasive cleaner
# 2 artif. sweetener
# 3   baby cosmetics

inspect(data[1:5])

itemFrequency(data[, 1:3])
itemFrequency(data)

class(data)
# [1] "transactions"
# attr(,"package")
# [1] "arules"

itemFrequencyPlot(data, support = 0.1)
itemFrequencyPlot(data, topN = 20)

image(sample(data, 100))

dataRules <- apriori(data, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
summary(dataRules)
inspect(dataRules)

# 향상도 순으로 정렬
inspect(sort(dataRules, by = 'lift')[1:5])

# berries 아이템을 포함하는 ...
berryRules <- subset(dataRules, items %in% 'berries')
inspect(berryRules)

write(dataRules, file = 'dataRules.csv', sep = ',', quote = T, row.names = F)

data_df <- as(dataRules, 'data.frame')
str(data_df)

plot(dataRules)
