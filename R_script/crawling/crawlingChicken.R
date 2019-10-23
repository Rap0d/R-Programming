# install.packages("readxl")
# install.packages("treemap")
library(readxl)
library(stringr)
library(dplyr)
library(treemap)
library(digest)

setwd(' ../')
fileName <- '../치킨집 데이터/치킨집 가공.xlsx'

data01 <- read_excel(fileName)

str(data01)

colnames(data01) <- c('address', 'name')

rows <- nrow(data01)
loc <- '종로구'

findLoc <- paste('서울특별시', loc, sep = ' ')

# str_locate 함수가
## 주소지가 '서울특별시 강동구'이면 1을 반환해준다.
bool <- str_locate(data01$address, findLoc)[1:rows] == 1
bool

data02 <- subset(data01, bool)
data02

addr <- substr(data02$address, 11, 16)
addr

addr_num <- gsub('[0-9]', '', addr)
addr_trim <- gsub(' ', '', addr_num)
addr_trim <- gsub('-', '', addr_trim)
addr_trim

addr_count <- addr_trim %>% table() %>% data.frame()
colnames(addr_count) <- c('동', '매장수')
addr_count

arrange(addr_count, desc(매장수)) %>% head()

mTitle <- paste(loc, ' 동별 치킨집 분포', sep = '')
treemap(addr_count, index = '동', vSize = '매장수', title = mTitle, fontfamily.title = 'D2Coding', fontfamily.labels = 'D2Coding')
