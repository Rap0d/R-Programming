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
#############################################################

# R에서 불러와서 그래프 그리기

# country_summary : histogram
query01 <- 'select * from country_summary'
country_summary <- dbGetQuery(conn, query01)
country_summary

rownames(country_summary) <- country_summary$COUNTRY_TXT
rcs <- country_summary$COUNTRY_TXT
country_summary <- country_summary[2]
country_summary

hist(country_summary$CNT, main = '테러빈도수에 대한 Histogram', breaks = 100)

# country_summary : barplot(terror count >= 1000 & country_summary <= 2500)
query01 <- 'select * from country_summary'
country_summary <- dbGetQuery(conn, query01)
country_summary

res01 <- filter(country_summary, CNT >= 1000 & CNT <= 2500)
rownames(res01) <- res01$COUNTRY_TXT
leglb <- rownames(res01)
res01 <- res01$CNT
# res01 <- as.matrix(res01)
res01
barplot(res01, col = rainbow(length(res01)), ylab = '발생 건수', xlab = '국가', main = '국가별 테러가 1000건 이상, 2500건 이하인 나라', names.arg = leglb, ylim = c(0, 2500))

# country_summary_TOP_10 : barplot

query02 <- 'select * from country_summary_top_10'
top_10 <- dbGetQuery(conn, query02)
top_10

rownames(top_10) <- top_10$COUNTRY_TXT
leglb2 <- rownames(top_10)
top_10 <- top_10$CNT

barplot(top_10, col = rainbow(length(top_10)), ylab = '발생 건수', xlab = '국가', main = '테러 건수 상위 10위 국가들', names.arg = leglb2, ylim = c(0, 15000), cex.names = 0.6)

# THREE_CONUNTY
query03 <- 'select * from three_country'
three_country <- dbGetQuery(conn, query03)
three_country

res03 <- dcast(three_country, COUNTRY_TXT ~ IYEAR, value.var = 'CNT')
res03
rownames(res03) <- res03$COUNTRY_TXT
lb03 <- rownames(res03)
res03 <- res03[2:5]
mat03 <- as.matrix(res03)

barplot(mat03, beside = T, col = rainbow(nrow(mat03)), ylab = '발생 건수', xlab = '연도', main = '테러 건수 상위 3위 국가의 연도별 테러 발생 수', legend = lb03, ylim = c(0, 5000))

res04 <- dcast(three_country, IYEAR ~ COUNTRY_TXT, value.var = 'CNT')
res04
rownames(res04) <- res04$IYEAR
lb03 <- rownames(res04)
res04 <- res04[2:4]
mat04 <- as.matrix(res04)

barplot(mat04, beside = T, col = rainbow(nrow(mat04)), ylab = '발생 건수', xlab = '국가', main = '테러 건수 상위 3위 국가의 나라별 테러 발생 수', legend = lb03, ylim = c(0, 5000))