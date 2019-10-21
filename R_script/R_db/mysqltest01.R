library(DBI)
library(RMySQL)

drv <- MySQL()
drv
str(drv)

# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '초기설정 비밀번호';
## Failed to connect to database: Error: Plugin caching_sha2_password could not be loaded
con<-dbConnect(MySQL(),user="rdbuser",password="12345",dbname="r_database",host="localhost")

query01 <- 'select * from myterror'
data <- dbGetQuery(con, query01)
