library(class)
library(gmodels)

data <- read.csv("wisc_bc_data.csv", stringsAsFactors = F)
str(data)
dim(data) # [1] 569  32

data <- data[-1]
unique(data$diagnosis)
table(data$diagnosis)

data$diagnosis <- factor(data$diagnosis, levels = c("B", "M"), labels = c("Benign", "Malignant"))
table(data$diagnosis)
357/(357+212)

colnames(data)

# wdbc.names.txt 파일 참고
summary(data[c("radius_mean", "area_mean", "smoothness_mean")])
# radius_mean       area_mean      smoothness_mean
# Min.   : 6.981   Min.   : 143.5   Min.   :0.05263
# 1st Qu.:11.700   1st Qu.: 420.3   1st Qu.:0.08637
# Median :13.370   Median : 551.1   Median :0.09587
# Mean   :14.127   Mean   : 654.9   Mean   :0.09636
# 3rd Qu.:15.780   3rd Qu.: 782.7   3rd Qu.:0.10530
# Max.   :28.110   Max.   :2501.0   Max.   :0.16340

# min-max Algorithm
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

dataN <- as.data.frame(lapply(data[2:31], normalize))
dataN

summary(dataN[c("radius_mean", "area_mean", "smoothness_mean")])
# # radius_mean       area_mean      smoothness_mean 
# Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
# 1st Qu.:0.2233   1st Qu.:0.1174   1st Qu.:0.3046  
# Median :0.3024   Median :0.1729   Median :0.3904  
# Mean   :0.3382   Mean   :0.2169   Mean   :0.3948  
# 3rd Qu.:0.4164   3rd Qu.:0.2711   3rd Qu.:0.4755  
# Max.   :1.0000   Max.   :1.0000   Max.   :1.0000

# 데이터 분리
## 하단 100개를 테스트 용으로 사용
testingRow <- 100
totRow <- nrow(dataN)
trainingRow <- totRow - testingRow

dataTrain <- dataN[1:trainingRow,]
dataTest <- dataN[(trainingRow + 1):totRow,]

dataTrainLabels <- data[1:trainingRow, 1]
dataTestLabels <- data[(trainingRow + 1) : totRow, 1]

kSize_1 <- floor(sqrt(trainingRow))
kSize_1 <- ifelse(kSize_1 %% 2 == 0, kSize_1 + 1, kSize_1)
kSize_1

knnPred <- knn(train = dataTrain, test = dataTest, cl = dataTrainLabels, k = kSize_1, prob = T)
knnPred

table(knnPred, dataTestLabels)

CrossTable(x = dataTestLabels, y = knnPred, prop.chisq = F)

dataTrain <- dataN[1:trainingRow,]
dataTest <- dataN[(trainingRow + 1) : totRow, ]

for(idx in c(5, 11, 15, 21, 27)) {
  kSize_1 <- idx
  knnPred <- knn(train = dataTrain, test = dataTest, cl = dataTrainLabels, k = kSize_1, prob = T)
  CrossTable(x = dataTestLabels, y = knnPred, prop.chisq = F)
  mTable <- table(knnPred, trainingRow)
  accuracy <- (mTable[1,1] + mTable[2,2]) / sum(mTable)
  accuracy <- round(accuracy, 2)
  print(accuracy)
  cat('--------------------------------------------------------------')
}

