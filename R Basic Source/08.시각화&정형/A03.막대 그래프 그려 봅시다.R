# install.packages('reshape2')
library(reshape2)

mydata <- read.csv('student_subject_score.csv', header=T)
mydata

unique(mydata$subject)

namesubject <- dcast(mydata, name ~ subject, value.var = 'jumsu')
namesubject

name <- namesubject[1]
name
chartdata <- namesubject[2:7]
chartdata
class(chartdata) # "data.frame"

chart1 <- as.matrix(chartdata)
chart1
myrow <- dim(chart1)[1]
myrow
barplot(chart1, main='과목별 학생 점수', beside=TRUE, col=rainbow(myrow), ylim=c(0, max(chart1) + 10) )
# 과목별 학생 점수.png

barplot(chart1, col=rainbow(myrow), beside=FALSE, main='과목별 학생 점수', horiz=T, xlim=c(0, 250))
# 과목별 학생 점수(h).png

chartdata
chart2 <- t(chartdata)
chart2
t(name)
colnames(chart2) <- t(name)
chart2
myrow <- dim(chart2)[1]
myrow
barplot(chart2, col=rainbow(myrow), beside=TRUE, main='학생별 과목 점수', ylim=c(0, max(chart1) + 10) )
# 학생별 과목 점수.png

namesubject
sim <- namesubject[1,1:ncol(namesubject)]
name <- sim[1]
name
simvec <- sim[2:length(sim)]
# simvec <- as.vector(simvec)
simvec <- unlist(simvec)
class(simvec)
simvec
help(pie)
pie(simvec, main=paste('심형래 시험 점수'))
# 심형래 시험 점수.png

namesubject
jumsu <- namesubject[,c(1, 3, 6, 5)]
jumsu

x <- c(1, 2, 3)
mat <- jumsu[, 2:4]
mat
mysize = 3
mycolor = rainbow(mysize)

help(matplot)
# pch와 type 속성이 상충
matplot(x, mat, pch='*', type='l', cex=3, col=mycolor, 
	lty=c('solid', 'dotted', 'dashed'), xlim=c(0.5, 3.5))

legend(1.0, 95, c('국어', '영어', '수학'), cex=1.0, fill=mycolor)
# matplottest.png