# 사용자 로그인과 테이블 생성하기
# scott 사용자 생성은 카페 : 821번 참고 요망
create table test_table(
	id varchar2(50) primary key,
	pass varchar2(30) not null, 
	name varchar2(25) not null, 
	age number(2)
);

insert into test_table values('hong', '1234', '홍길동', 35) ;
insert into test_table values('kim', '5678', '김길동', 45) ;

commit ;

select * from test_table ;

# 접속 테스트
install.packages('rJava')
install.packages('DBI')
install.packages('RJDBC')

Sys.setenv(JAVA_HOME='c:/program files/Java/jre1.8.0_191')
library(rJava)
library(DBI)
library(RJDBC)

# 코딩 구현 절차
# 드라이버 객체 구하기
# 접속 객체 구하기

driver <- 'oracle.jdbc.driver.OracleDriver'
jarpath <- 'C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar'

# jarpath <- 'C:/oraclexe/app/oracle/product/10.2.0/server/jdbc/lib/ojdbc14.jar'

drv <- JDBC(driverClass = driver, classPath = jarpath)

class( drv )
# [1] "JDBCDriver"
# attr(,"package")
# [1] "RJDBC"

url <- 'jdbc:oracle:thin:@//127.0.0.1:1521/xe'
id <- 'gomdori'
password <- 'oracle'

conn <- dbConnect( drv, url, id, password)
class( conn ) 
# [1] "JDBCConnection"
# attr(,"package")
# [1] "RJDBC"

query = 'select power(2, 10) from dual'

result <- dbGetQuery(conn, query)
result 
#   POWER(2,10)
# 1        1024

class( result ) # data.frame

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

query <- 'select * from test_table'
dbGetQuery(conn, query)

query <- "delete from test_table where name = '홍길동'"
dbSendUpdate(conn, query)

query <- 'select * from test_table'
dbGetQuery(conn, query)
