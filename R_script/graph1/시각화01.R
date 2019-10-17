# 산점도 그래프

height <- sort(c(163, 180, 184, 174, 160, 173, 177, 157))
weight <- sort(c(50, 80, 84, 70, 45, 65, 77, 44))

# 2x2 그래프
# mfrow : x by y 배치 옵션
par(mfrow=c(2, 2))

# 각 타입별 그래프 활용
plot(height, weight, type='l')
plot(height, weight, type='o')
plot(height, weight, type='h')
plot(height, weight, type='s')

# pch(plotting character) : 점의 모양(표시 기호), range : 1 ~ 25
# col(color) : 선색상
# cex(character expansion) : 점의 크기
# lwd(line width) : 선의 굵기
plot(height, weight, type = 'o', pch=5)
plot(height, weight, type = 'o', pch=20, col = 'blue')
plot(height, weight, type = 'o', pch=22, col = 'orange', cex = 1.5)
plot(height, weight, type = 'o', pch=24, col = 'green', cex = 2.0, lwd = 3)

# 그래프 배치 초기화
par(mfrow=c(1,1))