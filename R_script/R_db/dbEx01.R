# install.packages(c("DBI", "RJDBC"))

library(rJava)
library(DBI)
library(RJDBC)

# R에서 DB 접근하기 위한 절차
## 드라이버 객체 구하기
## 접속 객체 구하기

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- '/Users/seungheonchang/Documents/_2_WorkSpace/_0_util/ojdbc6.jar'

drv <- JDBC(driverClass = driver, classPath = jarpath)

class(drv)
# [1] "JDBCDriver"
# attr(,"package")
# [1] "RJDBC"

url <- 'jdbc:oracle:thin:@//127.0.0.1:32769/xe'
id <- 'rdbuser'
password <- '1234'

conn <- dbConnect( drv, url, id, password)
class( conn ) 
# [1] "JDBCConnection"
# attr(,"package")
# [1] "RJDBC"

##############################

# test query
query = 'select power(2, 10) from dual'

result <- dbGetQuery(conn, query)
result 
# POWER(2,10)
# 1        1024

class( result ) # data.frame

#####################################

# dbGetQuery(접속객체, 쿼리)
## return : data frame

query <- 'select * from test_table'
resultSet <- dbGetQuery(conn, query)
mode(resultSet) # "list"
class(resultSet) # "data.frame"

query <- ' select * from test_table'
query <- paste(query, ' order by age desc ')
result <- dbGetQuery(conn, query)
result 

query <- "insert into test_table values( 'shin', '1234', '신사임당', 60 )"
dbSendUpdate(conn, query)

query <- 'select * from test_table'
dbGetQuery(conn, query)

query <- 'select * from test_table where age >= 45'
result <- dbGetQuery(conn, query)
result 

query <- "update test_table set age = 40 where name = '강감찬'"
dbSendUpdate(conn, query)

query <- "update test_table set age = 10 where name like '김%'"
dbSendUpdate(conn, query)

query <- 'select * from test_table'
dbGetQuery(conn, query)

query <- "delete from test_table where name = '홍길동'"
dbSendUpdate(conn, query)

query <- 'select * from test_table'
dbGetQuery(conn, query)

