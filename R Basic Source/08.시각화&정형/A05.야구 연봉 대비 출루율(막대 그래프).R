# 야구 선수들의 연봉 대비 출루율을 이용하여 막대 그래프를 그려 보세요.
data <- read.csv('야구성적.csv', header=TRUE)
str(data)
dim(data)
colnames(data)

chartdata <- data$연봉대비출루율  
chartdata
range(chartdata)

mycolor <- rainbow(nrow(data))
xlabel <- data$선수명

# paste() 함수 : 요소들의 문자열을 결합해준다.
# names.arg : x축에 보여 지는 항목을 설정한다.

barinfo <- barplot(chartdata, main='연봉 대비 출루율\n(밥값 여부 계산)', 
			col=mycolor, names.arg=xlabel, 
			cex.names=0.7, las=2, ylim=c(0, 50))

barinfo

# y축 좌측 옆의 설명 문구
title(ylab='연봉대비출루율', col.lab='red')
title(xlab='선수명', col.lab='blue')

aver <- mean(data$연봉대비출루율)
aver # 평균 : 13.5084

# 평균 점수에 해당하는 수평선 그리기
abline(h=aver, col='red', lty='dotted')

# text() : 그래프에 문자열을 출력해주는 함수이다.
text(x=3, y = aver + 0.5, col='black', labels=paste(round(aver, 2), '%(평균 출루율)'))

# 각 막대 그래프의 상단에 %율을 작성한다.
text(x=barinfo * 1.01, y = chartdata + 1, col='black', labels=paste(chartdata, '%'))
