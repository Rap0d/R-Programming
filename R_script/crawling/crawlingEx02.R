library(rvest)

# none page parameter
url_base <- 'https://movie.daum.net/moviedb/grade?movieId=112942&type=netizen&page='

# 10page
last_page <- 10

df <- data.frame()

# all page load
## data frame에 넣기
for (page in 1:last_page) {
  url <- paste(url_base, page, sep = '')
  # cat(url, '\n')
  html <- read_html(url)
  html <- html %>% html_nodes('.review_info')
  writers <- html %>% html_nodes('.link_profile') %>% html_text()
  
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
  
  tmp <- data.frame(writers, comments, regdate)
  df <- rbind(df, tmp)
}
df
colnames(df)
write.csv(df, 'daum2.csv', row.names = F, quote = F)
