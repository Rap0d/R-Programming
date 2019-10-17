# jumsu.json 파일을 이용하여 학생들의 국영수 각각 평균 점수를 구하시오.
# 3 과목의 평균을 이용하여 Pie 그래프를 그리시오.

library(jsonlite)

myfile = "jumsu.json"
myframe <- fromJSON(myfile)
myframe

jumsu_df <- data.frame()

for(idx in 1:nrow(myframe)){
  name <- myframe$name[idx]
  kor <- myframe$kor[idx]
  eng <- myframe$eng[idx]
  math <- myframe$math[idx]
  
  dframe <- data.frame(name, kor, eng, math)
  
  jumsu_df <- rbind(jumsu_df, dframe)
}
jumsu_df

name <- jumsu_df$name
jumsu <- as.matrix(jumsu_df[2:4])
mylabel <- colnames(jumsu)
jumsu <- as.integer(jumsu)
jumsu <- matrix(jumsu, nrow=2)
chartdata <- apply(jumsu, 2, mean)
chartdata

pct <- round(chartdata/sum(chartdata)*100, 2)
label <- paste(mylabel, "\n(", pct, ')%', sep='')
label
mycolor <- rainbow(length(chartdata))
pie(chartdata, main='3 과목의 평균', labels=label, col=mycolor)

# 미국(275)_해외방문객정보(2016 ~ 2017).json 파일을 이용하여 
# 매년(2016년과 2017년) 총 방문객 수를 이용하여 막대 그래프 그리기
# 년도에 상관 없이 4분기의 총방문객을 이용하여 Pie 그래프를 그리시오.
myfile = "미국(275)_해외방문객정보(2016 ~ 2017).json"
usaframe <- fromJSON(myfile)
usaframe

newdata <- usaframe[c('yyyymm', 'visit_cnt')]

library(stringr)
newdata$year <- str_sub(newdata$yyyymm, 1, 4)
newdata$mm <- str_sub(newdata$yyyymm, 5, 6)
newdata$visit_cnt <- as.integer(newdata$visit_cnt)
newdata$mm <- paste(newdata$mm, '월', sep='')

newdata$quarter[newdata$mm == '01월' | newdata$mm == '02월' | newdata$mm == '03월'] = '1사분기'
newdata$quarter[newdata$mm == '04월' | newdata$mm == '05월' | newdata$mm == '06월'] = '2사분기'
newdata$quarter[newdata$mm == '07월' | newdata$mm == '08월' | newdata$mm == '09월'] = '3사분기'
newdata$quarter[newdata$mm == '10월' | newdata$mm == '11월' | newdata$mm == '12월'] = '4사분기'

newdata

library(reshape2)
widedata <- dcast(newdata, year ~ mm, sum, value.var='visit_cnt')
widedata
year <- widedata$year
chartdata <- widedata[2:ncol(widedata)]
ylimmin <- 0
ylimmax <- max(chartdata)

mycolor <- rainbow(length(year))
# mycolor <- c('yellow', 'green')
barinfo <- barplot(as.matrix(chartdata), main='중국인 방문 객수', beside=T, col=mycolor, cex.names=1.1, las=1, ylim=c(ylimmin, ylimmax))

quarterdata <- dcast(newdata, year ~ quarter, sum, value.var='visit_cnt')
quarterdata

chartdata <- quarterdata[2:ncol(quarterdata)]

chartdata <- apply(chartdata, 2, sum)
chartdata

pct <- round(chartdata/sum(chartdata)*100,2)
mylabel <- paste(names(chartdata), "\n(", pct, "%)")
mycolor <- rainbow(length(chartdata))
pie(chartdata, main='분기별 총방문객', labels=mylabel, col=mycolor)

# pokedex-korean.json 파일을 이용하여 
# name, img, type, height, weight 항목들만 추출하여 csv 파일로 저장하시오.
myfile = "pokedex-korean.json"
myframe <- fromJSON(myfile)
str(myframe)

pokedex <- data.frame()

for(idx in 1:nrow(myframe)){
  # name, img, type, height, weight
  name <- myframe$name[idx]
  img <- myframe$img[idx]
  type <- myframe$type[idx]
  
  height <- myframe$height[idx]
  height <- str_replace(height, ' m', '')
  height <- as.numeric(height)

  weight <- myframe$weight[idx]
  weight <- str_replace(weight, ' kg', '')
  weight <- as.numeric(weight)
  
  dframe <- data.frame(name, img, type, height, weight)
  
  pokedex <- rbind(pokedex, dframe)
}
head(pokedex)

write.csv(pokedex, 'pokedex.csv', quote = F, row.names = F)

# 다음 url에 대하여 json을 읽어 들여서, node_id, name, full_name 3개의 컬럼만
# result.csv 파일에 저장해 보세요.
myurl <- 'https://api.github.com/users/hadley/repos'
myframe <- fromJSON( myurl )

sink('aa.txt')
str(myframe)
sink()

nrow(myframe) # 30
newdata <- myframe[c('node_id', 'name', 'full_name')]
dim(newdata)
str(newdata)
newdata

write.csv(newdata, 'hadley_repos.csv', row.names = F, quote= F )


# jtbcnews_facebook_2016-10-01_2017-03-12.json 파일에서 
# message 항목만 추출하여 워드 클라우드를 만들어 보세요.
myfile = "jtbcnews_facebook_2016-10-01_2017-03-12.json"
jtbcnews <- fromJSON(myfile)
jtbcnews

newdata <- c() # empty vector
msglen <- length(jtbcnews$message)
msglen
for (idx in 1:msglen){
  newdata <- c(newdata, jtbcnews$message[idx])
}
newdata
# install.packages("KoNLP")
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
datalen <- 150
result <- head(result, datalen)
result

# 빈도를 단어 구름으로 나타내기
# install.packages('wordcloud')
library( wordcloud )
# par(mar=c(2, 2, 2, 2))
length(names(result))
set.seed( 12345 )
wordcloud(words=names(result), freq=result, scale=c(5, 1), min.freq=1, color=rainbow(datalen), random.color=FALSE, random.order=FALSE, rot.per=0.25 ) 



# 마지막으로 wordcloud2를 활용해서 워드클라우드를 그리고 싶을 때 주의해야 할 점을 알려드릴게요.
# 1. 내가 원하는 이미지는 반드시 어두운색 계열로 색칠된 이미지이어야 한다.
# 2. wordcloud2 package만 설치해서는 figPath= 옵션을 활용할 수 없다. 반드시 htmlwidgets, htmltools, jsonlite, yaml, base64enc 총 5개 packages를 함께 설치하고 실행해야 한다.

# install.packages(c('htmlwidgets', 'htmltools', 'jsonlite', 'yaml', 'base64enc'))

library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)

# 먼저 Rstudio를 여시고 devtools라는 패키지를 불러옵니다. 없으시다면 install.packages('devtools')로 먼저 설치한 다음 불러오시면 됩니다. devtools는 저도 얼마전에 알아서 자세히는 모르지만 아마 github와 연동을 시켜주는 패키지인것 같습니다.
# github에는 전 세계의 코딩유저들이 자신의 코드를 공유하고 질문하는 글로벌 코딩 커뮤니티입니다.
# devtools를 불러오셨으면 아래와 같이 입력하여 wordcloud2를 설치합니다.
# 
# 혹시 왜 install.packages('wordcloud2')로 바로 설치하지 않고 저런 방법으로 wordcloud2를 설치하는지 궁금해 하시는 분들을 위해 말씀드리자면, 그냥 install.pakcages로 바로 wordcloud2를 설치하였을 때 구동이 되긴 하지만 많은 기능들이 불구가 되어 사용할 수 없는 오류가 발생합니다. 저도 그래서 해결방법을 찾다가 github에도 같은 질문이 올라와 있더라고요. 그에 대한 답으로 저렇게 설치하면 기능들을 온전히 사용할 수 있다고 합니다.
library(devtools)
devtools::install_github("lchiffon/wordcloud2")

# install.packages('wordcloud2', dependencies = T)
library( wordcloud2 )
wordcloud2(data=result, size=1.0, fontFamily = '나눔바른고딕', col="random-dark", rotateRatio= 0, backgroundColor="lightyellow")

wordcloud2(data=result, size=1.0, rotateRatio= 0, backgroundColor="lightyellow", figPath = 'alice.png')


wordcloud2(data=result, size=1.0, rotateRatio= 0, backgroundColor="lightyellow", figPath = 'mypicture.jpg')

# wordcloud2(data=result, size=1.0, col="random-dark", rotateRatio= 0, backgroundColor="lightyellow", figPath = 'D:\\Rwork\\hahaha\\alice.png')
 
letterCloud(data=result,word='R',wordSize=1,fontFamily='굴림')

letterCloud(data=result,word='도원동',wordSize=1,fontFamily='굴림')