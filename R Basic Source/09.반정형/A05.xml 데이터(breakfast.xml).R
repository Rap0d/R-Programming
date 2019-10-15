# install.packages('tidyverse')
library(stringr)
library(xml2)
library(tidyverse)

# xml_path <- 'https://www.w3schools.com/xml/simple.xml'
xml_path <- 'breakfast.xml'

# read xml data from url
raw_xml <- read_xml(xml_path)
mode(raw_xml) ; class(raw_xml) ;
raw_xml

# food element
food_node <- xml_children(raw_xml)
mode(food_node) ; class(food_node) ;
food_node

# 1번째 노드의 하위 노드
xml_find_all(food_node[1], './*')

# %>% 연산자를 이용한 방법
food_node[2] %>% xml_find_all('./*')

# 아마도 수십년동안 data.frame()을 사용하다가 똑똑한 사용자 및 개발자가 불필요한 것은 덜어내고 필요한 사항을 집약시킨 것이 tibble() 자료구조다. tibble은 tidyverse 생태계를 구성하는 한 멤버로 tidyverse를 설치하게 되면 즉시 활용할 수 있다. 
# 요컨대 tibble은 데이터 프레임을 현대적으로 업그레이드한 형태라고 생각하시면 됩니다.

# 각 element 별로 한 줄씩 만들어서 합쳐주기
# idx는 일종의 primary key와 같은 역할을 수행한다.
myextract <- function(x){
  temp_row <- xml_find_all(food_node[x], './*')
  tibble(
    idx = x,
    key = temp_row %>% xml_name(),
    value = str_trim(temp_row %>% xml_text()) # str_trim으로 좌우측 공백 제거하기
    # value = temp_row %>% xml_text()
    # value = str_replace_all( temp_row %>% xml_text(), '\\s', '')
  ) %>% return()
}

seq(food_node)
mytibble <- lapply(seq(food_node), myextract)
mytibble

# 맨 마지막의 select 구문은 idx 열을 제외함과 동시에 열의 순서를 맞춰주기 위해 사용했습니다.
data <- mytibble %>% bind_rows() %>% spread(key, value) %>% select(food_node %>% xml_children() %>% xml_name %>% unique())

mode(data) ;  class(data) ;
str(data)

write.csv(data, 'breakfast.xml.csv') # 파일로 저장하기