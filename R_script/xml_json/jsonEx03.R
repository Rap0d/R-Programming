
library(rJava)
library(KoNLP)
library(jsonlite)
library(stringr)
library(wordcloud2)

par(family = 'D2Coding')

getColor <- function(x) {
  return (rainbow(nrow(x)))
}

fileName <- 'R Basic Source/09.반정형/김주혁_naver_news.json'
fullData <- fromJSON(fileName)
fullData

colnames(fullData)

desLen <- length(fullData$description)
newData <- c()
for(idx in 1:desLen) {
  newData$desc <- c(newData, fullData$description[idx])
}
newData

# 명사 추출 함수
someData <- sapply(newData, extractNoun, USE.NAMES = F)
someData

mChkData <- unlist(someData)
mChkData

# 명사중 2글자 이상 6글자 이하 필터링
mChkData <- Filter(function(x) {
  nchar(x) >= 2
}, mChkData)
mChkData <- Filter(function(x) {
  nchar(x) <= 6
}, mChkData)
length(mChkData)
mChkData

res <- sort(table(mChkData), decreasing = T)
datalen <- 20 # 워드 클라우드의 개수
res <- head(res, datalen)
res

wordcloud2(res, size = 0.5, fontFamily = "D2Coding", color = "random-dark", shape = 'rectangle', shuffle = F, rotateRatio = 0.5, maxRotation = pi/4)

