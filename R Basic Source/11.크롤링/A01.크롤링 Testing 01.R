# 내가 작성한 문서 testing.html에서 <div class="review_info">을 찾은 다음
# <em class="link_profile">...</em> 을 찾으면 작성자 정보이다.
# <p class="desc_review">을 찾으면 코멘트이다.

# install.packages('rvest')

library("rvest")

url <- 'testing.html'

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
