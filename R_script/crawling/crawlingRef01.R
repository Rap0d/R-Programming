library(rvest)
library(stringr)

uen <- 'UTF-8'

cleanTxt <- function(x) {
  res <- gsub('\\r', '', x)
  res <- gsub('\\n', '', res)
  res <- gsub('\\t', '', res)
  res <- str_trim(res)
  return (res)
}

rbSix <- read_html('https://r6.tracker.network/profile/pc/Minimum-Zero', 'UTF-8')
rbSix %>% html_nodes('.trn-defstat__value') %>% html_nodes('img') %>% html_attr('title')

url1 <- 'https://r6.tracker.network/profile/pc/Minimum-Zero'
data01 <- read_html(url1, uen)
data01

item01 <- html_nodes(data01, '.trn-defstat__value')
link01 <- item01 %>% html_nodes('img') %>% html_attr('title')
link01

link01 <- paste('https://www.bobaedream.co.kr', link01, sep = '')
title01 <- item01 %>% html_nodes('.tit a') %>% html_attr('title')
desc01 <- item01 %>% html_nodes('.stxt') %>% html_text()
year01 <- data01 %>% html_nodes('#listCont .year') %>% html_text() %>% cleanTxt()
fuel01 <- data01 %>% html_nodes('#listCont .fuel') %>% html_text() %>% cleanTxt()
km01 <- data01 %>% html_nodes('#listCont .km') %>% html_text() %>% cleanTxt()
price <- data01 %>% html_nodes('#listCont .price') %>% html_text() %>% cleanTxt()

res01 <- data.frame(title01, desc01, year01, fuel01, km01, price, link01)
res01

write.csv(res01, '국산차.csv', row.names = F)

# https://gall.dcinside.com/board/lists?id=travel_europe
# 페이지에서 필요한 항목만 크롤링해보세요.
#


# 다음 3개의 사이트에 대하여 크롤링하여 1개의 데이터 프레임에 저장하여 보세요.
# 단, category 컬럼을 하나 추가하여 항목을 구분하도록 하시오.
# https://www.bobaedream.co.kr/cyber/CyberCar.php?cat=2 # 스포츠카
# https://www.bobaedream.co.kr/cyber/CyberCar.php?cat=3 # 밴,RV,버스
# https://www.bobaedream.co.kr/cyber/CyberCar.php?features=camp # 캠핑카