Sys.setenv(JAVA_HOME='c:/program files/Java/jre1.8.0_191')
library(rJava)
library(DBI)
library(RJDBC)

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- 'C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar'

drv <- JDBC(driver, jarpath)

url <- 'jdbc:oracle:thin:@localhost:1521/xe'
id <- 'oraman'
password <- 'oracle'

conn <- dbConnect(drv, url, id, password)

query <- 'select * from mytable'
data_set <- dbGetQuery(conn, query)
data_set
