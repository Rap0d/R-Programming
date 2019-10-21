# install.packages("rvest")

# rvest : R로 크롤링을 할 때 가장 많이 쓰이는 패키지
library(rvest)
library(dplyr)
library(stringr)

setwd('R Basic Source/11.크롤링/')
url <- 'http://movie.daum.net/moviedb/grade?movieId=112942&type=netizen&page=1'

# read_html 함수를 통해 html을 불러온다.
## encoding UTF-8은 대소문자 구분하니 주의한다.
html01 <- read_html(url, encoding = 'UTF-8')
html01

# id : '#', class : '.'
## html_nodes : node는 tag를 의미, nodes이기 때문에 모두 가져오는 함수
## review_info 클래스를 모두 가져오기
div_lists <- html_nodes(html01, '.review_info')

# 원소의 개수 구하기
length(div_lists)

# lists의 안으로 접근하기
writer_lists <- html_nodes(div_lists, '.link_profile')
writer_lists

# html_text : list의 요소를 가져오는 함수
writer <- html_text(writer_lists)
writer

div_lists

# 텍스트 정제 과정
comments <- html01 %>% html_nodes('.review_info') %>% html_nodes('p') %>% html_text()
comments <- gsub('\\t', '', comments)
comments <- gsub('\\r', '', comments)
comments <- gsub('\\n', '', comments)
comments <- str_trim(comments)
comments


