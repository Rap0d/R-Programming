# 1에서 100사이의 임의의 수 10개를 추출
height <- c(164, 170, 173, 175, 178, 180)
weight <- c(72, 68, 76, 76, 90, 83)

# type 속성으로 그려 보기
par(mfrow=c(2, 2))
plot(height, weight, type='l') # 실선
plot(height, weight, type='o') # 원형과 실선
plot(height, weight, type='h') # 직선
plot(height, weight, type='s') # 꺽은 선

# savePlot('산점도 그림01.png', type='png')

# pch 속성으로 그려 보기
par(mfrow=c(2, 2))
plot(height, weight, type='o', pch=5) # 내용이 비어 있는 사각형
plot(height, weight, type='o', pch=20, col='blue') # 파란 색으로 채워진 사각형
plot(height, weight, type='o', pch=20, col='orange', cex=1.5) # cex : 점의 크기
plot(height, weight, type='o', pch=20, col='green', cex=2.0, lwd=3) # lwd : 선의 굵기
# savePlot('산점도 그림02.png', type='png')

par(mfrow=c(1, 1))