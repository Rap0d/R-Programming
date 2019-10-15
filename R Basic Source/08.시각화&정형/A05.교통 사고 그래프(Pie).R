traffic <- read.csv("교통 사고 데이터.csv")

nrow(traffic) # 데이터 row수 보기
summary(traffic) # 기본통계량 보기
str(traffic) # 변수 특성 확인 등 구조 확인

circle <- table(traffic$사고유형_대분류)
circle
mode(circle) # "numeric"
class(circle) # "table"
pie(circle)

# 기준선 변경(init.angle)
pie(circle, init.angle=90)

# 원 크기 조절(radius)
pie(circle, radius=0.9) # 반경

# 방향 바꾸기(clockwise)
pie(circle, clockwise=T)

# 값 입력(labels)
label <- paste(names(circle), "\n", circle)
label
pie(circle, labels=label)

# 값(퍼센트) 입력
label <- paste(names(circle), "\n", circle/sum(circle)*100)
label
pie(circle, labels=label)

pct <- round(circle/sum(circle)*100,2)
label <- paste(names(circle), "\n", pct, "%")
pie(circle, labels=label)

# 3D 원그래프(pie chart)도 그릴 수 있습니다. 다만 "plotrix"라는 library가 필요해요.
# 3D 파이차트(plotrix, pie3D)
install.packages("plotrix")
library(plotrix)
pie3D(circle, labels=label)

# 파이 간격 설정(explode)
pie3D(circle, labels=label, explode=0.1) 
pie3D

# 값 크기 조절(labelcex)
pie3D(circle, labels=label, labelcex=0.9)
