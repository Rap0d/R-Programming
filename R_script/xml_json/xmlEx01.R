# install.packages("xml2")
# install.packages("tidyverse")

library(xml2)
library(dplyr)
library(stringr)
library(tidyverse)

setwd('R Basic Source/09.반정형/')

xPath01 <- 'breakfast.xml'
# read_xml 함수를 이용한 file read
xData01 <- read_xml(xPath01)

# raw xml 의 구조 파악
mode(xData01)
class(xData01)
xData01

# raw xml 의 자식노드의 구조 파악
f_node <- xml_children(xData01)
mode(f_node)
class(f_node)
# "xml_nodeset"

# node 의 1번째 자식에 접근
f_node[1]

# './*' : 현 위치의 모든 객체
# xml_find_all(x, y) : x번째 항목의 y항목을 모두 찾기
xml_find_all(f_node[1], './*')

# pipe 연산자 사용하여 같은 값 도출 가능
f_node[2] %>% xml_find_all('./*')

# <breakfast_menu>
#   <food>
#   <name>Belgian Waffles</name>
#   <price>$5.95</price>
#   <description>
#     Two of our famous Belgian Waffles with plenty of real maple syrup
#   </description>
#   <calories>650</calories>
#   </food>

mExtract <- function(x) {
  # tmp_row : x 번째 행 데이터
  # tmp_row 에 자식노드 다 가져옴
  tmp_row <- xml_find_all(f_node[x], './*')
  
  tibble(
    idx = x,
    # tag
    # xml_name() : tag name 가져오기
    key = tmp_row %>% xml_name(),
    # value
    # xml_text() : tag안에 있는 값을 가져오기
    # trim 하는 이유 : white char(\n etc.) 없애기 위함
    value = str_trim(tmp_row %>% xml_text())
  ) %>% return()  # pipe 연산자로 리턴
}

seq(f_node)
# lapply : seq 를 이용한 for 문과 비슷한 작용
# lapply(seq, func)
mTibble <- lapply(seq(f_node), mExtract)
mTibble

mode(mTibble)
class(mTibble)
str(mTibble)
summary(mTibble)

# bind_rows() : table 로 묶어주는 함수
# spread(key, value) : 키값을 colnames로, value 값을 내용으로 펼쳐준다.
data01 <- mTibble %>% bind_rows() %>% spread(key, value)
data01

data02 <- mTibble %>% bind_rows() %>% spread(key, value) %>% select(f_node %>% xml_children() %>% xml_name() %>% unique())

mode(data02)
class(data02)
str(data02)
data02

write.csv(data02, 'breakfastXML.csv')

