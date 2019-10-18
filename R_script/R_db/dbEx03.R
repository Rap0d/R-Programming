library(reshape2)
library(stringr)
library(dplyr)
library(rJava)
library(DBI)
library(RJDBC)
par(family = 'D2Coding')
driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- '/Users/seungheonchang/Documents/_2_WorkSpace/_0_util/ojdbc6.jar'
drv <- JDBC(driverClass = driver, classPath = jarpath)
url <- 'jdbc:oracle:thin:@//127.0.0.1:32769/xe'
id <- 'rdbuser'
password <- '1234'
conn <- dbConnect( drv, url, id, password)
class( conn )
##############################
#
# 데이터베이스 실습 
# -> 컨트롤러를 이용하여 대용량 파일 받아오기 실습
# 


query01 <- 'select * from terrortable'
data01 <- dbGetQuery(conn, query01)

head(data01)
summary(data01)


