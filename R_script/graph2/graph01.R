par(family = 'D2Coding')

traffic <- read.csv('R_data/191015/교통 사고 데이터.csv')
traffic
str(traffic)
colnames(traffic)
summary(traffic)

unique(traffic$사고유형_대분류)
circle <- table(traffic$사고유형_대분류)
circle
mode(circle)
class(circle)

getPercent <- function(x) {
  res <- round(x/sum(x) * 100, 2)
  return (res)
}

# pie 그래프에는 벡터 값이 들어간다.
pie(circle)

# 시작 각도
pie(circle, init.angle = 90)

# 반지름
pie(circle, radius = 0.7)

# 시계 방향
pie(circle, clockwise = T)

# 값 넣기
mlabel <- paste(names(circle), '\n', circle)
mlabel
pie(circle, labels = mlabel)

# percentage
mlabel2 <- paste(names(circle), '\n', getPercent(circle), '%')
pie(circle, labels = mlabel2)

# 3dim pie graph
# install.packages('plotrix')
library(plotrix)

pie3D(circle, labels = mlabel2, explode = 0.15)

# 도로형태-대분류로 파이그래프 그려보기
roadType <- table(traffic$도로형태_대분류)
mlabel3 <- paste(names(roadType), '\n', getPercent(roadType), '%')
pie(roadType, labels = mlabel3)
