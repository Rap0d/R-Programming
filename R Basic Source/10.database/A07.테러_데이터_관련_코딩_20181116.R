# R에서 오라클 DB 접속하기
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_191')
library(rJava)
library(DBI)
library(RJDBC)

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- 'C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar'

# JDBC : jar 파일에 들어 있는 해당 클래스를 메모리에 올리는 역할
drv <- JDBC(driver, jarpath)
class(drv)

url <- 'jdbc:oracle:thin:@localhost:1521/xe'
id <- 'oraman'
password <- 'oracle'

# dbConnect : 적절한 인증 절차를 거쳐서 DBMS에 접근
conn <- dbConnect(drv, url, id, password)
class(conn)

# 상위 10개국 테러 현황을 막대 그래프로 그려 보세요.
query <- 'select * from country_summary_top10'
result <- dbGetQuery(conn, query)
mode(result) # "list"
class(result) # "data.frame"
result

chart_data <- result$CNT
names(chart_data) <- result$COUNTRY_TXT
chart_data
mycolor <- rainbow(length(chart_data))
barplot(chart_data, main='상위 10개국 테러 현황', ylim=c(0, 14000), col=mycolor)

legend('topright', '', names(chart_data), cex=0.8, fill=mycolor, bg='lightyellow')

# 3개국 테러 현황
query <- 'select * from three_country'
result <- dbGetQuery(conn, query)
result

country <- result$COUNTRY_TXT
year <- result$IYEAR

library(reshape2)

# 년도(year)를 행으로 국가 이름(country)을 열로 지정하여 CNT 컬럼에 대하여 합계를 구하시오.
chart_data <- dcast(result, year ~ country, value.var='CNT', sum)
chart_data
myrowname <- chart_data[1]
myrowname
chart_data <- as.matrix(chart_data[2:4])
chart_data

mycolor <- rainbow(nrow(chart_data))
barplot(chart_data, main='3개국 테러 현황', beside=TRUE, col=mycolor, ylim=c(0, 4000))

# abline(h=seq(0, 4000, 1000))
# legend('topright', '', myrowname, cex=0.8, fill=mycolor, bg='lightblue')

# bungiview를 이용하여 Pie Chart를 그려 보세요.
query <- 'select * from bungiview'
result <- dbGetQuery(conn, query)
result

chart_data <- result$CNT
chart_data # pie를 그리고자 하는 데이터

sumtotal <- sum(chart_data)
sumtotal # 모든 데이터의 총합

percent <- round( 100 * chart_data / sumtotal, 2)
percent # 각 데이터의 비율

mycaption <- paste(result$RESULT, '(', percent, '%)', sep='')
mycaption

pie(chart_data, main='분기별 테러 비율', label=mycaption, col=rainbow(length(chart_data)))

# 특정한 국가만 보기
query <- " select country_txt, result, count(*) as cnt
    from bungi
    where country_txt in ('Afghanistan', 'Iraq')
    group by country_txt, result
    order by cnt desc "
query
result <- dbGetQuery(conn, query)
result

country <- result$COUNTRY_TXT
bungi <- result$RESULT

chart_data <- dcast(result, country ~ bungi, value.var='CNT', sum)
chart_data
myrowname <- chart_data[1]
myrowname
chart_data <- as.matrix(chart_data[2:5])
chart_data

mycolor <- rainbow(nrow(chart_data))
barplot(chart_data, main='Afghanistan과 Iraq 테러 현황', horiz=TRUE, beside=FALSE, col=mycolor, xlim=c(0, 6000))
################################################################################
