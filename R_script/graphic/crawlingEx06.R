library(rJava)
library(KoNLP)
library(stringr)
library(dplyr)
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(wordcloud2)

cleaner <- function(x) {
  res <- str_replace_all(x, '\\W', ' ')
  return(res)
}

cleaner2 <- function(x) {
  res <- str_extract(x, "[가-힣]{2,6}")
  res <- str_replace(res, '\\.', '')
  res <- str_replace(res, '\\n', '')
  res <- str_replace(res, '\\d+', '')
  return(res)
}

setwd('../워드클라우드(프로포즈 선물 검색)/')

# text line을 읽어들이는 함수 
data01 <- readLines('propose.txt')
data01

buildDictionary(ext_dic = c('sejong', 'woorimalsam'))
data02 <- sapply(data01, extractNoun)
data02

data03 <- unlist(data02)
data03

length(data03)

data04 <- cleaner2(data03)
data04

stopwords <- readLines('propose_gsub.txt')

for(idx in 1:length(stopwords)) {
  data04 <- gsub(stopwords[idx], '', data04)
}
data04

data04 <- Filter(function(x) {nchar(x) >= 2}, data04)
data04 <- Filter(function(x) {nchar(x) <= 6}, data04)
data04

head(unlist(data04), 20)

newData <- unlist(data04)
newData

wordcount <- table(newData)
wordcount <- sort(wordcount, decreasing = T)

chartdata <- head(wordcount, 10)
mColor <- rainbow(length(chartdata))

df <- as.data.frame(chartdata)
colnames(df) <- c('내용', '빈도수')

df
ggplot(data = df, aes(x = 내용, y = 빈도수, fill = 내용, color = 내용)) + ylim(0, max(df$빈도수 + 5)) + geom_col() + coord_flip() + geom_text(aes(label = 빈도수), hjust = -0.3) + theme_bw(base_family = 'D2Coding') + labs(title = 'Propose Present Top 10')

wordcount <- table(newData)
wordcount <- head(sort(wordcount, decreasing = T), 100)
mColor2 <- brewer.pal(10, 'Set1')

wordcloud2(wordcount, fontFamily = 'D2Coding', rotateRatio = 0, shuffle = T, size = 1.5, color = mColor2)
