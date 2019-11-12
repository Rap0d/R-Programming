# install.packages("ggplot2") 
library(ggplot2)
nrow(diamonds) # 53940

set.seed(1234)
mysample <- sample(1:nrow(diamonds), 1000) # 1000개만 샘플링

# 표본으로 검정 데이터 생성
test <- diamonds[mysample, ]
dim(test) # 1000   10
colnames(test)
head(test)    # 검정 데이터

# 군집을 위해서 필요한 변수만 추출
# price(가격) : price in US dollars (\$326–\$18,823)
# carat(무게) : weight of the diamond (0.2–5.01)
# depth(깊이) : total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)
# table(너비) : width of top of diamond relative to widest point (43–95)
mydiamonds = test[c("price","carat", "depth", "table")] 
head(mydiamonds)
dim(mydiamonds)

# 계층적 군집 분석(탐색적 분석)
# 계층적 군집 분석을 이용하여 대략적인 군집 수를 확인한다.
hc <- hclust(dist(mydiamonds), method='ave')
hc
# Call:
# hclust(d = dist(mydiamonds), method = "ave")
# 
# Cluster method   : average 
# Distance         : euclidean 
# Number of objects: 1000 

plot( hc )
plot( hc, hang=-1 )
# 다이아몬드 군집 분석 01.png 

# 비계층적 군집 분석(확인적 분석) - kmeans() 함수 이용
# 확인적 군집 분석 : 군집의 수를 알고 있는 경우
hc2 = kmeans(mydiamonds, centers=3) # 3개의 군집수를 적용한다.
hc2 

names(hc2) 
# [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"    "size"        
# [8] "iter"         "ifault" 

hc2$cluster # 각 케이스에 대한 소속 군집수(1,2,3)
 
# 오리지널 데이터에 군집수 추가
mydiamonds$cluster = hc2$cluster
head(mydiamonds) 

# 변수 간의 상관 관계 보기 
refcol <- c('price', 'carat', 'depth', 'table')
cor(mydiamonds[, refcol], method="pearson")
#        price        carat        depth      table
# price  1.00000000  0.923692317 -0.039501137  0.1031825
# carat  0.92369232  1.000000000 -0.005542946  0.1645923
# depth -0.03950114 -0.005542946  1.000000000 -0.3147234
# table  0.10318255  0.164592318 -0.314723372  1.0000000

# 변수 간의 상관성 보기.png
plot(mydiamonds[, refcol])

# 위의 결과를 보면, price(단가) 변수에 가장 큰 영향을 끼치는 변수는 carat(무게 : 캐럿)이다.
# depth는 부(negative)의 영향을 미친다.

# 상관 계수를 색상으로 시각화하기
# install.packages("corrgram")
library(corrgram)     # 상관성 시각화 
corrgram(mydiamonds[, refcol])  # 색상 적용
# 상관 계수 색상 적용.png

# 수치(상관 계수) 추가(위쪽)
# 결과물의 소괄호 내의 값은 신뢰 구간이다.
corrgram(mydiamonds[, refcol], upper.panel=panel.conf)
# 수치(상관 계수) 추가(위쪽).png

# 위의 상관 계수를 보면 가격에 가장 영향을 미치는 요소는 무게이다.

# 비계층적 군집 시각화
# 무게와 가격을 이용하여 산점도를 그려 보자.
# 군집에 따라 색상을 다르게 설정해본다.
plot(mydiamonds$carat, mydiamonds$price, col=mydiamonds$cluster)
 
# 각 그룹의 중심점에 포인트 추가 
# 군집의 구분을 용이하게 하기 위해 각군의 중앙에 별도의 기호를 표시한다.
points(hc2$centers[,c ("carat", "price")], col=c(1, 2, 3), pch=8, cex=5)
# 다이아몬드 군집 분석 02.png

# diamonds 데이터 셋 1000개의 표본으로 계층적 군집 분석으로 군집 수를 파악했다.(여기서는 3개)
# 이 군집 수를 이용하여 비계층적 군집 분석에 의하여 군집을 형성했다.
# 무게(carat)와 단가(price)를 이용하여 시각화했다.
# 결과를 살펴 보면, 다이아몬드의 크기가 클 수록, 대체적으로 가격이 상승하고 있다.