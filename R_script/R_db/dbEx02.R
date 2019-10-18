library(reshape2)
library(stringr)
library(dplyr)

library(rJava)
library(DBI)
library(RJDBC)

par(family = 'D2Coding')
# 데이터베이스 실습(정형)
# 
# 파일 이름 : 09_03.데이터베이스 실습(정형).R
# 
# 첨부 이미지 : goods_info.png
# 
# 1. sql-developer을 이용하여 그림과 같은 테이블을 생성하세요.
# 

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- '/Users/seungheonchang/Documents/_2_WorkSpace/_0_util/ojdbc6.jar'
drv <- JDBC(driverClass = driver, classPath = jarpath)
url <- 'jdbc:oracle:thin:@//127.0.0.1:32769/xe'
id <- 'rdbuser'
password <- '1234'
conn <- dbConnect( drv, url, id, password)
class( conn ) 

##############################

# 2. R에서 SQL문을 이용하여 데이터를 추가하시오.
#
query <- "insert into goods values('1004', 'Computer', 1000000, 'HP')"
dbSendUpdate(conn, query)
# 3. R에서 SQL문을 이용하여 데이터를 조회하시오.
# 
query <- 'select * from goods'
data01 <- dbGetQuery(conn, query)
# 4. R에서 막대 그래프와 Pie 그래프를 그리시오.
pd <- data01[2:3]
rownames(pd) <- pd$PNAME
pd <- as.matrix(pd[2])

barplot(t(pd), beside = T, col = rainbow(nrow(pd)))

lbls <- paste(rownames(pd), '\n', (pd/10000), '만원')
pie(pd, labels = lbls, col = rainbow(nrow(pd)))
