# install.packages("jsonlite")

library(jsonlite)
library(ggplot2)

myfile = "somedata.json"
myframe <- fromJSON(myfile)
mode( myframe ) # "list"
class( myframe ) # "data.frame"

# help(jsonlite)

write.csv(myframe, 'humans.csv', quote = F, row.names = F)

#data.frame 인 result를 사용할 JSON 형식으로 변환하여 줍니다.
jsonData <- toJSON( myframe )
jsonData
# [{"name":"홍길동","age":10},{"name":"박영희","age":20},{"name":"김철수","age":30}] 

mode( jsonData ); class( jsonData )  # "character"와 "json" 출력

# 파이 그래프 그리기
bp<- ggplot(myframe, aes(x='', y=age, fill=name))+
  geom_bar(width = 1, stat = 'identity')

pie <- bp + coord_polar('y', start=0)
pie

# 색상 팔레트 적용하기
pie + scale_fill_brewer(palette='Dark2')

pie + scale_fill_brewer(palette='Blues') + theme_minimal()