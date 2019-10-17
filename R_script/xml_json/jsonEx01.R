library(jsonlite)
library(stringr)

par(family = 'D2Coding')

getColor <- function(x) {
  return (rainbow(nrow(x)))
}

china_file <- '../R-Programming/R Basic Source/09.반정형/중국_방문객_정보.json'
china_visit <- fromJSON(china_file)
china_visit

newdata <- china_visit[c('yyyymm', 'visit_cnt')]

newdata$mm <- str_sub(newdata$yyyymm, 5, 6)
colnames(newdata) <- c('년월', '방문자수', '월')

newdata$월 <- str_c(newdata$월, '월')

xlabel <- newdata$월

# large number remove e+05
options(scipen = 1)

barplot(newdata$방문자수, col = getColor(newdata), names.arg = xlabel, ylim = c(0, 600000), ylab = 'Number of people')

newdata