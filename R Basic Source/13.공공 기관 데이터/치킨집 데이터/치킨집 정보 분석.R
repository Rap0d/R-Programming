# install.packages('readxl')
library(readxl)

filename <- '치킨집 가공.xlsx'
examdata <- read_excel(filename)

# View(dustdata)
str(examdata)

head(examdata)
colnames(examdata) <- c('address', 'name')

# install.packages('stringr')
library(stringr)

rowsu <- nrow(examdata) # 전체 행수
guname <- '용산구' 
bool <- str_locate(examdata$address, paste('서울특별시 ', guname, sep='') )[1:rowsu] == 1 
newdata <- subset(examdata,bool)
newdata

addr <- substr(newdata$address, 11, 16)
addr

# 공백과 숫자 제거하기
addr_num <- gsub('[0-9]', '', addr) # 정규 표현식으로 숫자 제거
addr_trim <- gsub(' ', '', addr_num) # 공백 제거
head(addr_trim)

# install.packages('dplyr')
library(dplyr)

# 도수 분포표로 만든후 데이터 프레임으로 변환하기
addr_count <- addr_trim %>% table() %>% data.frame()
colnames(addr_count) <- c('동이름', '매장수')
head(addr_count, 10)

# 치킨집이 많은 동네부터 확인해보기
arrange(addr_count, desc(매장수)) %>% head()

# install.packages('treemap')
library(treemap)

mytitle <- paste(guname, ' 동별 치킨집 분포', sep='')
treemap(addr_count, index='동이름', vSize='매장수', title=mytitle)