library(jsonlite)
library(stringr)

par(family = 'D2Coding')

getColor <- function(x) {
  return (rainbow(nrow(x)))
}

mFile <- 'R Basic Source/09.반정형/somedata.json'
mFrame <- fromJSON(mFile)
mode(mFrame)
class(mFrame)
write.csv(mFrame, 'humans.csv', quote = F, row.names = F)

jsonData <- toJSON(mFrame)
jsonData

mode(jsonData)
class(jsonData)
