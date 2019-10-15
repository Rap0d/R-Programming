# 다음 영화 사이트에서 '메리와 마녀의 꽃'의 리뷰에 대하여
# 1페이지의 작성자와 코멘트 내용을 출력해본다.
# 탭/공백/엔터키 등의 white character은 치환을 해보도록한다.

# <div class="review_info">을 찾은 다음
# <em class="link_profile">문준용</em> 을 찾으면 작성자 정보이다.
# <p class="desc_review">을 찾으면 코멘트이다.

library("rvest")

url <- 'http://movie.daum.net/moviedb/grade?movieId=112942&type=netizen&page=1'

html <- read_html(url, encoding='UTF-8')
# html

div_lists <- html_nodes(html, '.review_info')
length(div_lists)

writer_lists <- html_nodes(div_lists, '.link_profile')
length(writer_lists)
writer_lists

writers <- html_text(writer_lists)
writers

library(dplyr)
library(stringr)
comments <- html %>% html_nodes('.review_info') %>% html_nodes('p') %>% html_text() 
comments <- gsub('\\t', '', comments)
comments <- gsub('\\n', '', comments)
comments <- gsub('\\r', '', comments)
comments <- str_trim(comments)
comments