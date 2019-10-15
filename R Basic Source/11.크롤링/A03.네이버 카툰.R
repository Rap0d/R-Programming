# install.packages('rvest')
library("rvest")

url <- 'https://comic.naver.com/webtoon/weekday.nhn'

html <- read_html(url)
# html

div_lists <- html_nodes(html, '.thumb')
length(div_lists)

atag <- html_node(div_lists, 'a')
attr <- html_attr(atag, 'href')

attr <- gsub('/webtoon/list.nhn', '', attr)
attr <- gsub('\\?', '', attr)
attr

library(dplyr)
# 연쇄 법칙 사용하기 
# attr <- html %>% html_nodes('.thumb') %>% html_nodes('a') %>% html_attr('href')

mytitle <- html %>% html_nodes('.thumb') %>% html_node('img') %>% html_attr('title')
mytitle
mysrc <- html %>% html_nodes('.thumb') %>% html_node('img') %>% html_attr('src')
mysrc

iteration <- c(1:length( attr ))

# for (idx in iteration){
#   download.file(mysrc[idx], paste0( getwd(), "/output/image_", idx, '.jpg'))
# }

library('stringr')

vec <- NULL
for (idx in iteration){
  delimiter <- '&'
  mydata <- str_split( attr[idx], delimiter, simplify = TRUE)

  delimiter <- '='
  titleid <- str_split( mydata[1], delimiter, simplify = TRUE)
  weekday <- str_split( mydata[2], delimiter, simplify = TRUE)
  # print(idx)
  vec <- c(vec, titleid[2], weekday[2], mytitle[idx], mysrc[idx])
}
# vec

col_su = 4 # 컬럼의 숫자 
mat <- matrix(vec, ncol = col_su, byrow = T)
# mat

df <- as.data.frame( mat )
# df
colnames(df) <- c('titleId','weekday','title','src')
write.csv(df, 'naver_cartoons.csv', row.names=F, quote=F)
