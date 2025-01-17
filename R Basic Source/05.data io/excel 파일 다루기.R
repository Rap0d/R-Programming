# readxl 패키지도 있음
install.packages('xlsx')

Sys.setenv("JAVA_HOME" = '/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home')
Sys.setenv("DYLD_FALLBACK_LIBRARY_PATH" = '/Library/Frameworks/R.framework/Resources/lib:/Users/seungheonchang/lib:/usr/local/lib:/usr/lib:::/lib:/Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home/lib/server')
Sys.getenv()

dyn.load('/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home/lib/server/libjvm.dylib')

require(rJava)

.jinit()

# /Library/Java/JavaVirtualMachines/jdk1.8.0-144.jdk/Contents/Home/jre/lib/server
# DYLD_FALLBACK_LIBRARY_PATH       /Library/Frameworks/R.framework/Resources/lib:/Users/seungheonchang/lib:/usr/local/lib:/usr/lib:::/lib:/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home/lib/server

library(rJava)
library(xlsx)

# 인코딩 문자열 : 반드시 대문자 다음 오류가 발생한다.
# Error in make.names(vnames, unique = TRUE) : 
# invalid multibyte string at '<ec><88><98>?낆뾽泥<b4>'
myencoding = 'UTF-8'

filename = 'R정형데이터처리하기.xlsx'
getwd()
setwd('R Basic Source/05.data io/')
income <- read.xlsx(file=filename, sheetIndex = 1, encoding=myencoding)
mode(income)
class(income)
income

# 출장비 지급 내역
business <- read.xlsx(file=filename, sheetIndex = 2, encoding=myencoding)
business

# 가전 제품 시트 통합
sheets <- seq(3, 5) # 3번째 시트부터 5번째 까지

# help(read.xlsx)
# paste(1, "사분기", sep='')
# paste(as.character(1), "사분기", sep='')

total_df <- data.frame()

for( onesheet in sheets ){
  print(onesheet)
  dframe <- read.xlsx(file=filename, sheetIndex = onesheet, encoding=myencoding)
  dframe$bungi <- paste((onesheet-2), "사분기", sep='')
  total_df <- rbind(total_df, dframe)
}
total_df

# rowIndex : 가져올 행번호 지정
# colIndex : 가져올 열번호 지정
income2 <- read.xlsx(file=filename, sheetIndex = 1, encoding=myencoding, 
               header=FALSE, rowIndex=c(2, 3), colIndex = c(1, 3:4))
income2

