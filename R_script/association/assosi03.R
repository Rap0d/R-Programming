library(arules)

data <- read.transactions('mybasket.csv', sep = ',')
data
summary(data)

dataRules <- apriori(data, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
summary(dataRules)
# set of 2513 rules
# 
# rule length distribution (lhs + rhs):sizes
# 2   3   4   5   6   7   8 
# 64 263 588 759 567 232  40 
# 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 2.000   4.000   5.000   4.938   6.000   8.000 
# 
# summary of quality measures:
#   support           confidence          lift            count       
# Min.   :0.006361   Min.   :0.2500   Min.   :0.9601   Min.   :  5.00  
# 1st Qu.:0.010178   1st Qu.:0.6283   1st Qu.:1.6969   1st Qu.:  8.00  
# Median :0.016539   Median :0.7667   Median :2.0363   Median : 13.00  
# Mean   :0.029437   Mean   :0.7271   Mean   :2.2962   Mean   : 23.14  
# 3rd Qu.:0.029262   3rd Qu.:0.8750   3rd Qu.:2.4717   3rd Qu.: 23.00  
# Max.   :0.255725   Max.   :1.0000   Max.   :9.7640   Max.   :201.00  
# 
# mining info:
#   data ntransactions support confidence
# data           786   0.006       0.25
plot(dataRules, interactive = T)
inspect(dataRules)
# lhs                rhs        support     confidence lift      count
# [1]   {meat}          => {veg}      0.008905852 0.3043478  3.6802676   7  
# [2]   {meat}          => {milk}     0.017811705 0.6086957  3.2326675  14  
# [3]   {meat}          => {alcohol}  0.020356234 0.6956522  1.7581434  16  
# [4]   {meat}          => {frozen}   0.024173028 0.8260870  2.0418376  19  
# [5]   {meat}          => {deco}     0.024173028 0.8260870  1.8136993  19 

# 향상도 순으로 정렬
inspect(sort(dataRules, by = 'lift')[1:5])
# lhs                                         rhs    support     confidence lift     count
# [1] {clothes,deco,frozen,milk,snack}         => {meat} 0.012722646 0.2857143  9.763975 10   
# [2] {alcohol,clothes,deco,frozen,milk,snack} => {meat} 0.011450382 0.2812500  9.611413  9   
# [3] {bakery,clothes,deco,frozen,milk,snack}  => {meat} 0.010178117 0.2580645  8.819074  8   
# [4] {clothes,deco,frozen,snack,veg}          => {meat} 0.006361323 0.2500000  8.543478  5   
# [5] {alcohol,clothes,frozen,milk,snack}      => {meat} 0.012722646 0.2500000  8.543478 10  

write(dataRules, file = 'dataRules02.csv', sep = ',', quote = T, row.names = F)

data_df <- as(dataRules, 'data.frame')
str(data_df)
head(data_df)
# rules     support confidence     lift count
# 1     {meat} => {veg} 0.008905852  0.3043478 3.680268     7
# 2    {meat} => {milk} 0.017811705  0.6086957 3.232667    14
# 3 {meat} => {alcohol} 0.020356234  0.6956522 1.758143    16
# 4  {meat} => {frozen} 0.024173028  0.8260870 2.041838    19
# 5    {meat} => {deco} 0.024173028  0.8260870 1.813699    19
# 6  {meat} => {bakery} 0.019083969  0.6521739 1.521094    15

plot(dataRules)

itemFrequencyPlot(data, topN = 20)
