# install.packages("jsonlite")
# setwd('d:/rtest')

library(jsonlite)

myfile = "member.json"
myframe <- fromJSON(myfile)
mode( myframe ) # "list"
class( myframe ) # "data.frame"

# help(jsonlite)

myframe
myframe$name[1]

# 이름, 키, 혈액형 정보만 읽어 오
for (idx in 1:nrow(myframe)){
  name <- myframe$name[idx]
  height <- myframe$information$info$height[idx] 
  blood <- myframe$information$info$blood[idx]
  cat('이름 :', name, ', 키:', height, ', 혈액형:', blood)
  cat('\n')
}