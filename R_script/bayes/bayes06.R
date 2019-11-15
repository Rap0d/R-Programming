library(tm)
library(e1071)

data <- read.csv('R Basic Source/32.Naive Bayes/naive_bayes_test.csv', header = T, stringsAsFactors = F)

head(data)
str(data)
summary(data)
dim(data)
colnames(data)

data$type <- factor(data$type)
table(data$type)

corpus <- Corpus(VectorSource(data$text))
corpus

inspect(corpus)

clean <- tm_map(corpus, tolower)
clean <- tm_map(clean, removeNumbers)
clean <- tm_map(clean, removeNumbers, stopwords())
clean <- tm_map(clean, removePunctuation)
clean <- tm_map(clean, stripWhitespace)
inspect(clean[1:5])
inspect(corpus)

sp_matrix <- DocumentTermMatrix(clean)
inspect(sp_matrix)

totRow <- nrow(data)
trainingRow <- totRow - 2

class(sp_matrix)
class(clean)

# raw data
training <- data[1:trainingRow,]
testing <- data[(trainingRow + 1) : totRow, ]

# matrix
matrixTraining <- sp_matrix[1:trainingRow,]
matrixTesting <- sp_matrix[(trainingRow + 1) : totRow, ]

# corpus
corpusTraining <- clean[1:trainingRow]
corpusTesting <- clean[(trainingRow + 1) : totRow]

inspect(matrixTraining)

convertCounts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c('No', 'Yes'))
}

## 빈도가 2개 이상인 것들
mDict <- findFreqTerms(matrixTraining, 1)

newTraining <- DocumentTermMatrix(corpusTraining, list(dictionary = mDict))
newTesting <- DocumentTermMatrix(corpusTesting, list(dictionary = mDict))

inspect(newTraining)

newTraining <- apply(newTraining, MARGIN = 2, convertCounts)
newTesting <- apply(newTesting, MARGIN = 2, convertCounts)

model <- naiveBayes(newTraining, training$type)
model

pred <- predict(model, testing$type)
pred

table(pred, testing$type)

