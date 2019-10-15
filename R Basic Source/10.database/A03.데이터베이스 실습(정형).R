Sys.setenv(JAVA_HOME='c:/program files/Java/jre1.8.0_191')
library(rJava)
library(DBI)
library(RJDBC)

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- 'C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar'

drv <- JDBC(driver, jarpath)

url <- 'jdbc:oracle:thin:@localhost:1521/xe'
id <- 'gomdori'
password <- 'oracle'

conn <- dbConnect(drv, url, id, password)

query <- "insert into goodsinfo(pcode, pname, price, maker)
        values(1001, '냉장고', 2000000, 'SM')"
dbSendUpdate(conn, query)

query <- "insert into goodsinfo(pcode, pname, price, maker)
        values(1002, '세탁기', 700000, 'YG')"
dbSendUpdate(conn, query)

query <- "insert into goodsinfo(pcode, pname, price, maker)
        values(1003, 'HDTV', 2500000, 'GM')"
dbSendUpdate(conn, query)

query <- 'select * from goodsinfo'
result <- dbGetQuery(conn, query)
result

pname <- result$PNAME
maker <- result$MAKER
myprice <- result$PRICE
myprice <- myprice/10000  

# 막대 그래프
xlabel <- paste(pname, '(', maker, ')', sep='')
mycolor <- rainbow(length(myprice))
barplot(myprice, col=mycolor, names.arg=xlabel, las=1, ylab='가격(단위 만)', main='상품 단가표')

# 파이 그래프
price_ratio <- myprice/sum(myprice)
price_ratio <- round(100 * price_ratio, 2)
price_ratio <- paste(price_ratio, '%', sep='')
pielabel <- paste(xlabel, '\n', price_ratio, sep='')
pielabel

pie(myprice, col=mycolor, labels = pielabel, main='상품 단가표')