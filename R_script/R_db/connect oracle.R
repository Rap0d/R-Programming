# R Oracle DB Connect
Sys.setenv("JAVA_HOME"='/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/jre')
dyn.load('/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/jre/lib/server/libjvm.dylib')

getwd()

install.packages('rJava')
install.packages('DBI')
install.packages('RJDBC')

library('rJava')
library('DBI')
library('RJDBC')

# setting driver and connection configuration

drv_Oracle <- JDBC(driverClass)


#############################################################################################################



remove.packages('rJava')
library('rJava')

