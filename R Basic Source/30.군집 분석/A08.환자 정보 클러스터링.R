patient_info <- read.csv("patient_info.csv" , stringsAsFactors = F , header = T)
str(patient_info)

#계층형군집 
library(cluster)
hcl <- hclust(dist(patient_info)^2 , method = "single")
hcl <- hclust(dist(patient_info) , method = "single")
plot(hcl , hang = -1 , xlab = "strudent" , ylab = "distance")

#Elbow point구하기 
wss <- 0

# k를 1~10까지 변화시키면서 각 withinss 값을 wss에 저장한다.
maxlen <- 10
for(i in 1:maxlen){
  wss[i] <- sum(kmeans(patient_info,centers = i)$withinss)
} 
wss

# 막대 그래프 또는 꺽은 선 그래프를 이용하여 elbow point 결정하기
# withinss값을 그래프로 그리기, 기울기가 급격하게 완만해지는 부분이 보통 elbow point.
barplot(wss, col=rainbow(maxlen))

plot(1:10, wss, type="b",xlab = "Number of Clusters", ylab = "Within group sum of squares")

# 일반적으로 기울기가 완만해지는 부분을 elbow point로 설정한다.
# 막대 그래프에서 대략 5또는 6 정도면 좋겠다.
# 여기서는 6으로 지정해본다.
elbow <- 6

# k-means군집 
# library(graphics)
kms <- kmeans(patient_info , elbow)
kms

plot(patient_info , col = kms$cluster)