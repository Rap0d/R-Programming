library(rvest)
library(stringr)

url_europe <- 'http://gall.dcinside.com/board/lists/?id=travel_europe&page='

last_page_europe <- 2

europe_frame <- data.frame()

for(page in 1:last_page_europe){
  url <- paste(url_europe, page, sep='') # page 파라미터 관련
  html <- read_html(url)
  mycontent <- html %>% html_nodes('tr.ub-content')
  # cat(length(mycontent))
  
  num <- mycontent %>% html_node('td.gall_num') %>% html_text()
  # cat(num)
  # # if num == '공지' or num == '설문' : next
  # title <- mycontent %>% html_node('em.icon_img') %>% html_text()
  title <- mycontent %>% html_node('td.gall_tit') %>% html_text()
  title <- str_trim(title)
  title <- str_replace_all(title, '\\s', '') # \s white character을 의미한다.
  # title <- str_replace_all(title, '\\r', '')
  # title <- str_replace_all(title, '\\n', '')
  # cat(title)
  writer <- mycontent %>% html_node('td.gall_writer') %>% html_text()
  writer <- str_trim(writer)
  # cat(writer, '\n')
  date <- mycontent %>% html_node('td.gall_date') %>% html_text()
  # cat(date, '\n')
  count <- mycontent %>% html_node('td.gall_count') %>% html_text()
  # cat(count, '\n')
  recommend <- mycontent %>% html_node('td.gall_recommend') %>% html_text()
  # cat(recommend, '\n')
   
  dfimsi <- data.frame(num, title, writer, date, count, recommend)
  europe_frame <- rbind(europe_frame, dfimsi)
}

head(europe_frame, 5)
write.csv(europe_frame, 'myeurope.csv', row.names=F, quote=T)
