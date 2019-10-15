# R에서 읽어 들이기
library(DBI)
Sys.setenv(JAVA_HOME='c:/program files/Java/jre1.8.0_144')
library(rJava)
library(RJDBC)

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- 'C:/oraclexe/app/oracle/product/10.2.0/server/jdbc/lib/ojdbc14.jar'
drv <- JDBC(driver, jarpath)
url <- 'jdbc:oracle:thin:@//127.0.0.1:1521/xe'
id <- 'scott'
password <- 'tiger'
conn <- dbConnect( drv, url, id, password)
query = 'select * from country_summary_top_10'
result <- dbGetQuery(conn, query)

class(result)
result
chart_data <- result$CNT
names(chart_data) <-  result$COUNTRY_TXT
barplot(chart_data, col=rainbow(10), main='Terror Top 10')

# 뷰 three_conunty를 R에서 불러 와서 막대 차트로 그려 보세요
# R책 147, 193쪽
query = 'select * from three_conunty'
result <- dbGetQuery(conn, query)
result

country <- result$COUNTRY_TXT
year <- result$IYEAR 
library(reshape2)
chart_data <- dcast(result, year ~ country, sum)
chart_data
chart_data <- as.matrix(chart_data[2:4])

barplot(chart_data, col=rainbow(4), beside=T,
        ylim=c(0, 4000))

# legend(2000, 1000, c('2013', '2014', '2015'),
#       cex=0.8, fill=rainbow(4))


# bungiview를 이용하여 Pie Chart를 그려 보세요.
# 책 151쪽
query = 'select * from bungiview'
result <- dbGetQuery(conn, query)
result
result$RESULT
chart_data <- result$CNT
chart_data
total <- 0
for (val in chart_data){
  total <- total + val
}
total
percent <- 100 * round(chart_data/total, 4)
percent
mynames <- paste(result$RESULT, '(', percent, '%)')
mynames
pie(chart_data, label=mynames, col=rainbow(4), 
      main='분기별 테러 현황')