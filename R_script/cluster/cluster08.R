library(cluster )

par(family = 'AppleGothic')
data <- read.csv('patient_info.csv', stringsAsFactors = F)
str(data)

hc <- hclust(dist(data), method = 'single')
plot(hc)

# k를 1부터 10까지 반복하여 elbow point 구하기
wss <- numeric()

maxLen <- 10
for(i in 1:maxLen) {
  wss[i] <- sum(kmeans(data, centers = i)$withinss)
}

wss

# 막대 그래프 또는 꺽은 선 그래프를 이용하여 elbow point 결정하기
# withinss값을 그래프로 그리기, 기울기가 급격하게 완만해지는 부분이 보통 elbow point.
plot(1:maxlen, wss, type='b')

# 일반적으로 기울기가 완만해지는 부분을 elbow point로 설정한다.
elbow <- 6
kms <- kmeans(data, elbow)
kms

unique(kms$cluster)
plot(data, col=kms$cluster)

