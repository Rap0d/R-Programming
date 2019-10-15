# https://cinema4dr12.tistory.com/1170

library("rvest")

url <- 'https://www.baseball-reference.com/leagues/MLB/2017.shtml'
html <- read_html(url)
# html


# https://www.w3schools.com/xml/xpath_syntax.asp 사이트 참조.

# Team Standard Batting의 콘텐츠
# rvest::html_nodes는 rvest 패키지내의 html_nodes을 지칭한다.
# id="teams_standard_batting"을 갖는 <table> 태그
sb_table <- rvest::html_nodes(x=html, xpath='//*[@id="teams_standard_batting"]')
# sb_table
sb <- rvest::html_table(sb_table)[[1]]
head(sb)

# 테이블 하단의 소계 항목 지우기
sb <- sb[1:(base::nrow(sb)-3),]
mode(sb)
class(sb)

write.csv(sb, 'baseball.csv', row.names=F, quote=F)
