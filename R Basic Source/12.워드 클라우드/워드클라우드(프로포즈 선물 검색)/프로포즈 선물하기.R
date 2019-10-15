library(KoNLP)
library(ggplot2)
library(stringr)

propose <- readLines("propose.txt") 
propose
newpropose <- sapply(propose, extractNoun, USE.NAMES=F)

head(newpropose)
mode(newpropose) 
class(newpropose) 
# list 형태로 출력됨을 확인됩니다

# 필터링을 위해 unlist 작업을 해서 저장합니다.
vec_pro <- unlist(newpropose) 
length(vec_pro) # 3033

rep_propose <- str_replace( vec_pro, "\\.", "" )
rep_propose <- str_replace( rep_propose, "\\n", "" )
rep_propose <- str_replace( rep_propose, "\\d+", "" )

length(rep_propose) # 3033

# propose_gsub.txt : 분석시 배제하고자 하는 단어 목록을 담고 있는 텍스트 파일
stopwords <- readLines("프로포즈gsub.txt")
stopwords

for(idx in 1:length(stopwords)){
  rep_propose <- gsub(stopwords[idx], '', rep_propose)
}

# 두 글자 이상 되는 것만 필터링하기
rep_propose <- Filter(function(x) {nchar(x) >= 2}, rep_propose) 
rep_propose <- Filter(function(x) {nchar(x) <= 6} ,rep_propose) 
length(rep_propose) # 775

head(unlist(rep_propose), 20)

myfile <- 'propose_new.txt'
write(unlist(rep_propose), myfile)
newdata <- read.table(myfile)
nrow(newdata)

wordcount <- table(newdata)
wordcount <- sort(wordcount, decreasing = T)
head(wordcount, 15)

chartdata <- head(wordcount, 10)
mycolor <- rainbow(length(chartdata))

df <- as.data.frame(chartdata)
colnames(df) <- c('내용', '빈도수')

library(ggplot2)
mygraph <- ggplot(df, aes(x=내용, y=빈도수, col=내용, fill=내용)) + geom_bar(stat='identity') + labs(title='Propose Present Top 10') + theme(plot.title = element_text(hjust=0.5))
mygraph

wordcount <- table(newdata) 
head( sort( wordcount, decreasing=T ), 30)

library(RColorBrewer) 

mycolor <- brewer.pal(9, "Set1") 

set.seed(1234)
wordcloud(names(wordcount), freq=wordcount, rot.per=0.25, min.freq=2,
          random.order=F, random.color=T, colors = mycolor, scale=c(7, 1.5))

# 아래 코드는 기본 그래픽으로 그린 예시이다.
# 큰 값을 기준으로 상위 20개만 정렬하여 보여 준다.
head(sort(wordcount, decreasing=T), 20)
mydata <- head(sort(wordcount, decreasing=T),10)

bp <- barplot(mydata,  main = "프로포즈 선물 TOP 10", col = rainbow(10), 
              cex.names=0.7, las = 2,ylim=c(0,60))

pct <- round(mydata/sum(mydata) * 100 ,1)

# 예시 : 8건
text(x = bp, y = mydata * 1.05, labels = paste(mydata, "건"), col = "black", cex = 0.7)

# 예시 : 4.8%
text(x = bp, y = mydata * 0.85, labels = paste( "(", pct, "%", ")" ), col = "black", cex = 0.7)