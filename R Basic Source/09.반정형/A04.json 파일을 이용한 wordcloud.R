# install.packages("jsonlite")
library(jsonlite)

myfile = "김주혁_naver_news.json"
myframe <- fromJSON(myfile)
class( myframe ) 
nrow(myframe)
myframe$description[1]

newdata <- c() # empty vector
msglen <- length(myframe$description)
for (idx in 1:msglen){
  newdata <- c(newdata, myframe$description[idx])
}
newdata

library(KoNLP)
somedata <- sapply(newdata, extractNoun, USE.NAMES = F)
somedata

mycheckdata <- unlist(somedata) # 모두 벡터화
length(mycheckdata) # 숫자 기억해 놓도록 하고
mycheckdata

# 글자의 길이가 2자리 이상 6자리 이하인 글자들만 추출
mycheckdata <- Filter(function(x){ nchar(x) >= 2 }, mycheckdata)
mycheckdata <- Filter(function(x){ nchar(x) <= 6 }, mycheckdata)
length(mycheckdata) # 개수 파악
mycheckdata

# 빈도 수를 역순으로 정렬하기
result <- sort(table(mycheckdata), decreasing = TRUE)
datalen <- 20
result <- head(result, datalen) # 20개를 이용하여 워드 클라우드 준비
result

# 빈도를 단어 구름으로 나타내기
# install.packages('wordcloud')
library( wordcloud )
# par(mar=c(2, 2, 2, 2))
# set.seed( 12345 )
length(names(result))
wordcloud(words=names(result), freq=result, scale=c(5, 0.5), min.freq=1, 
          color=rainbow(datalen), random.color=FALSE, random.order=FALSE, rot.per=0.25 ) 