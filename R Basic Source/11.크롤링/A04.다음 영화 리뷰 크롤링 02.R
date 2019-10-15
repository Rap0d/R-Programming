# 다음 영화 사이트에서 '메리와 마녀의 꽃'의 리뷰에 대하여
# 1 ~ 10 페이지 까지의 작성자/평점/코멘트/작성일자 정보를 csv 파일 형식으로 저장해본다.

# <div class="review_info">을 찾은 다음
# <em class="link_profile">문준용</em> 을 찾으면 작성자 정보이다.
# <em class="emph_grade">0</em>을 찾으면 평점 정보이다.
# <p class="desc_review">을 찾으면 코멘트이다.
# <span class="info_append">을 찾으면 작성일자 정보이다.  

library("rvest")

url_base <- 'http://movie.daum.net/moviedb/grade?movieId=112942&type=netizen&page='

last_page <- 10

df <- data.frame() # 내용이 비어 있는 data frame

for(page in 1:last_page){    
  url <- paste(url_base, page, sep='') # page 파라미터 관련
  html <- read_html(url)
  html <- html %>% html_nodes('.review_info')
  
  writers <- html %>% html_node('em') %>% html_text()
  # print(length(em_lists))
  # writers <- em_lists[3] %>% html_text()
  comments <- html %>% html_nodes('p') %>% html_text()
  comments <- gsub('\\t', '', comments)
  comments <- gsub('\\n', '', comments)
  comments <- gsub('\\r', '', comments)
  comments <- gsub(',', '', comments)
  comments <- str_trim(comments)
  comments   
  
  regdate <- html %>% html_node('.info_append') %>% html_text()
  regdate <- gsub('\\t', '', regdate)
  regdate <- gsub('\\n', '', regdate)
  regdate <- gsub('\\r', '', regdate)
  regdate <- gsub(',', '', regdate)
  regdate <- str_trim(regdate)

  # print( regdate )
  dfimsi <- data.frame(writers, comments, regdate)
  df <- rbind(df, dfimsi)
}

df
colnames(df) <- c('writers', 'comments', 'regdate')
write.csv(df, 'daum2.csv', row.names=F, quote=F)


# 추가 문제
# https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1
# 페이지에서 필요한 항목만 크롤링해보세요.