# 네이버 웹툰 페이지 파싱

library(rvest)
library(stringr)

url <- 'https://comic.naver.com/webtoon/weekday.nhn'
u_en <- 'UTF-8'

data <- read_html(url, encoding = u_en)
data

tag01 <- html_nodes(data, '.thumb a')
tag01

# /webtoon/list.nhn?titleId=700858&weekday=mon
attr <- html_attr(tag01, 'href')
attr

attr <- gsub('/webtoon/list.nhn\\?', '', attr)
attr
delimiter <- '&'
a <- str_split(attr[1], delimiter, simplify = T)
delimiter <- '='
b <- str_split(a[1], delimiter, simplify = T)
b

title <- data %>% html_nodes('.thumb') %>% html_node('img') %>% html_attr('title')
title

src <- data %>% html_nodes('.thumb') %>% html_node('img') %>% html_attr('src')
src

# 반복할 전체 갯수
iteration <- c(1:length(attr))
iteration

df <- data.frame()
for (idx in iteration) {
  delimiter <- '&'
  mdata <- str_split(attr[idx], delimiter, simplify = T)
  delimiter <- '='
  titleId <- str_split(mdata[1], delimiter, simplify = T)
  weekday <- str_split(mdata[2], delimiter, simplify = T)
  
  tmp <- data.frame(titleId[2], weekday[2], title[idx], src[idx])
  df <- rbind(df, tmp)
} 
colnames(df) <- c('titleId', 'weekday', 'title','src')
write.csv(df, 'naver_webtoons.csv', row.names = F, quote = T)
