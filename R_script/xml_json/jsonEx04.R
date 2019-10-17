
library(rJava)
library(KoNLP)
library(jsonlite)
library(stringr)
library(dplyr)
library(reshape2)
library(devtools)
library(wordcloud2)

library(htmltools)
library(yaml)
library(base64enc)
library(htmlwidgets)

par(family = 'D2Coding')

getColor <- function(x) {
  return (rainbow(nrow(x)))
}

setwd('R Basic Source/09.반정형/')
getwd()

##########################################

fulldata <- fromJSON('jumsu.json')
fulldata

dlen <- length(fulldata$name)
dlen

res1 <- c()
for(idx in 1:dlen) {
  res1$name <- c(res1$name, fulldata$name[idx])
  res1$kor <- c(res1$kor, as.numeric(fulldata$kor[idx]))
  res1$eng <- c(res1$eng, as.numeric(fulldata$eng[idx]))
  res1$math <- c(res1$math, as.numeric(fulldata$math[idx]))
}

colnames(res1)

# jumsu.json 파일을 이용하여 학생들의 국영수 각각 평균 점수를 구하시오.
# 3 과목의 평균을 이용하여 Pie 그래프를 그리시오.
avg1 <- c()
avg1 <- c(avg1, round(mean(res1$kor), 2))
avg1 <- c(avg1, round(mean(res1$eng), 2))
avg1 <- c(avg1, round(mean(res1$math), 2))

avg1
colnames(res1[2:4])
pie(avg1, labels = colnames(res1[2:4]))

# 미국(275)_해외방문객정보(2016 ~ 2017).json 파일을 이용하여 
# 매년(2016년과 2017년) 총 방문객 수를 이용하여 막대 그래프 그리기
usf <- fromJSON('미국(275)_해외방문객정보(2016 ~ 2017).json')
usf

summary(usf)

mData <- usf[c('yyyymm', 'visit_cnt')]
mData

mData$year <- as.numeric(str_sub(mData$yyyymm, 1, 4))
mData$month <- as.numeric(str_sub(mData$yyyymm, 5, 6))

mData

res2 <- mData[2:4]
res2 <- dcast(res2, month ~ year, value.var = 'visit_cnt')
res2
xlab1 <- res2[1]
res2 <- res2[2:3]
leg <- paste(t(xlab1[1]), '월')
par(cex = 0.7)

res2

barplot(as.matrix(res2), ylab = 'Visitor of U.S', beside = T, col = getColor(xlab1), legend = leg)

# 년도에 상관 없이 4분기의 총방문객을 이용하여 Pie 그래프를 그리시오.
mData

res3 <- c()
res3$cnt <- mData$visit_cnt
res3$month <- mData$month
res3 <- as.data.frame(res3)
res3

res3 <- res3 %>% group_by(month) %>% summarise(tot = sum(cnt))

q4 <- res3 %>% filter(month > 9)
res4 <- q4$tot

lbls <- c('10월', '11월', '12월')
lbls <- paste(lbls, '\n', res4)

pie(res4, labels = lbls, col = getColor(q4))

# pokedex-korean.json 파일을 이용하여 
# name, img, type, height, weight 항목들만 추출하여 csv 파일로 저장하시오.
# 
pok <- fromJSON('pokedex-korean.json')
pok

mode(pok)
class(pok)

nLen <- nrow(pok)
nLen

res5 <- data.frame()
for(idx in 1:nLen) {
  name <- pok$name[idx]
  img <- pok$img[idx]
  type <- pok$type[idx]
  height <- pok$height[idx]
  weight <- pok$weight[idx]
  tmp <- data.frame(name = name, img = img, type = type, height = height, weight = weight)
  res5 <- rbind(res5, tmp)
}
res5

write.csv(res5, 'pokemon.csv', quote = F, row.names = F)

# 다음 url에 대하여 json을 읽어 들여서, node_id, name, full_name 3개의 컬럼만
# result.csv 파일에 저장해 보세요.
url = 'https://api.github.com/users/hadley/repos'
# 
repos <- fromJSON(url)

nLen2 <- nrow(repos)
nLen2

res6 <- data.frame()
for(idx in 1:nLen2) {
  node_id <- repos$node_id[idx]
  name <- repos$name[idx]
  full_name <- repos$full_name[idx]
  tmp <- data.frame(node_id = node_id, name = name, full_name = full_name)
  res6 <- rbind(res6, tmp)
}
res6

write.csv(res6, 'apiRes.csv', quote = F, row.names = F)

# jtbcnews_facebook_2016-10-01_2017-03-12.json 파일에서 
# message 항목만 추출하여 워드 클라우드를 만들어 보세요.
# 
news <- fromJSON('jtbcnews_facebook_2016-10-01_2017-03-12.json')
head(news)

summary(news)
colnames(news)

head(news$message)

newsLen <- length(news$message)
newsLen

msgData <- c()
for(idx in 1:newsLen) {
  msgData <- c(msgData, news$message[idx])
}
head(msgData)
summary(msgData)
mode(msgData)
class(msgData)

nounData <- sapply(msgData, extractNoun, USE.NAMES = F)
nounData <- unlist(nounData)

nounData <- Filter(function(x) {
  nchar(x) >= 2
}, nounData)
nounData <- Filter(function(x) {
  nchar(x) <= 6
}, nounData)
length(nounData)
nounData

res7 <- sort(table(nounData), decreasing = T)
datalen <- 500
res7 <- head(res7, datalen)
res7

wordcloud2(res7, size = 1, fontFamily = "D2Coding", color = "random-dark", shape = 'rectangle', shuffle = F, rotateRatio = 0.5, maxRotation = pi/4)

