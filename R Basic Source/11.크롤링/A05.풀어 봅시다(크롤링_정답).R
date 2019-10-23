# https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1
# 페이지에서 필요한 항목만 크롤링해보세요.

library("rvest")
library(stringr)

dist <- c('1만km', '4천km')
str <- '1만km'
loc <- str_locate(str, '[가-힣]')
loc <- str_locate(str, '만km')

str_sub(str, loc[1], loc[1])  == '만'
distance <- as.integer(str_sub(str, 1, loc[1] - 1))
distance # 금액 숫자만

abc <- c('a  b\n\t')
gsub('\n\t', '', abc)

make_dist <- function(str){
  loc <- str_locate(str, '[가-힣]')
  distance <- as.integer(str_sub(str, 1, loc[1] - 1))
  
  result <- 0 # 리턴할 금액
  cat(str_sub(str, loc[1], loc[1]) == '만')
  if( str_sub(str, loc[1], loc[1]) == '만' ){
    result <- distance * 10000  
  }else{
    result <- distance * 1000
  }
  return ( result )
}

dist <- c('1만km', '4천km')
for(item in dist ){
  res <- make_dist(item)
  cat(res,'\n')
}


url_base <- 'https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page='

last_page <- 1 # 2페이지 까지만

# 차량정보, 연식, 연료, 주행, 가격, 지역, 판매자
df <- data.frame() # 내용이 비어 있는 data frame

for(page in 1:last_page){    
  url <- paste(url_base, page, sep='') # page 파라미터 관련
  html <- read_html(url)
  prod_item <- html %>% html_nodes('.product-item')
  
  info01 <- prod_item %>% html_node('.tit') %>% html_text()
  info01 <- str_trim(info01)

  info02 <- prod_item %>% html_node('.stxt') %>% html_text()
  info02 <- str_trim(info02)

  info03 <- prod_item %>% html_node('.data-item') %>% html_text()
  info03 <- str_trim(info03)

  year <- prod_item %>% html_node('.year') %>% html_text()
  year <- str_trim(year)

  fuel <- prod_item %>% html_node('.fuel') %>% html_text()
  fuel <- str_trim(fuel)
  
  km <- prod_item %>% html_node('.km') %>% html_text()
  km <- str_trim(km)
  km <- str_replace(km, 'km', '')
  
  price <- prod_item %>% html_node('.price') %>% html_text()
  price <- str_trim(price)    
  price <- str_replace(price, '\n', '')
  price <- str_replace(price, '만원', '')
  # price <- str_replace(price, '팔림', '0')
  # price <- str_replace(price, '계약', '0')
  # price <- str_replace(price, '상담', '0')
  # price <- str_replace(price, '운용리스', '0')
  # for(a in 1:length(price)){
  #   cat(paste('[', price[a], ']', '\n', sep=''))
  # }
  dfimsi <- data.frame(info01, info02, info03, year, fuel, km, price)
  df <- rbind(df, dfimsi)
}

head(df)
# colnames(df) <- c('writers', 'comments', 'regdate')
write.csv(df, 'mycarinfo.csv', row.names=F, quote=T)


# 다음 3개의 사이트에 대하여 크롤링하여 1개의 데이터 프레임에 저장하여 보세요.
# 단, category 컬럼을 하나 추가하여 항목을 구분하도록 하시오.
# https://www.bobaedream.co.kr/cyber/CyberCar.php?cat=2 # 스포츠카
# https://www.bobaedream.co.kr/cyber/CyberCar.php?cat=3 # 밴,RV,버스
# https://www.bobaedream.co.kr/cyber/CyberCar.php?features=camp # 캠핑카

# 항목별 달라지는 url 주소의 끝 부분
cate_url <- c('cat=2', 'cat=3', 'features=camp')

# category 컬럼에 추가할 구분자
mycate <- c('sports', 'ven', 'camp')
url_base <- 'https://www.bobaedream.co.kr/cyber/CyberCar.php?'

myframe <- data.frame() # 내용이 비어 있는 data frame

for(idx in 1:length(cate_url)){
  url <- paste(url_base, mycate[idx], sep='') # page 파라미터 관련
  html <- read_html(url)
  prod_item <- html %>% html_nodes('.product-item')
  
  info01 <- prod_item %>% html_node('.tit') %>% html_text()
  info01 <- str_trim(info01)
  
  info02 <- prod_item %>% html_node('.stxt') %>% html_text()
  info02 <- str_trim(info02)
  
  info03 <- prod_item %>% html_node('.data-item') %>% html_text()
  info03 <- str_trim(info03)
  
  year <- prod_item %>% html_node('.year') %>% html_text()
  year <- str_trim(year)
  
  fuel <- prod_item %>% html_node('.fuel') %>% html_text()
  fuel <- str_trim(fuel)
  
  km <- prod_item %>% html_node('.km') %>% html_text()
  km <- str_trim(km)
  km <- str_replace(km, 'km', '')
  
  price <- prod_item %>% html_node('.price') %>% html_text()
  price <- str_trim(price)    
  price <- str_replace(price, '\n', '')
  price <- str_replace(price, '만원', '')
  
  # url 주소에 따른 카데고리 구분자
  category <- mycate[idx] 
  
  dfimsi <- data.frame(info01, info02, info03, year, fuel, km, price, category)
  myframe <- rbind(myframe, dfimsi)
}

head(myframe)
write.csv(myframe, 'mycarinfo02.csv', row.names=F, quote=T)