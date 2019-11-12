# 참조 : cluster 패키지는 recommend 패키지라 인스톨하지 않아도 된다.

result <- read.csv('myRFM.csv', header=T)
# install.packages('cluster')
library(cluster)

dim( result ) # head( result )

# 컬럼 정보 : Recency(최신성) Frequency(거래 빈도 수)  Monetary(구매 금액)

unique(result$Recency)

head( result ) # 앞 6행만 확인하기
#   Recency Frequency Monetary
# 1       2        17      976
# 2       1         7      171
# 3       3        23     2322
# 4       3        32     3293
# 5       3        14      426
# 6       2        24      666

# 계층적 군집화 알고리즘 분석
myeucdist <- dist( result, 'euclidean' ) # 유클리디언 거리 생성
result2 <- hclust( myeucdist , method="ave") # 평균 연결 방법

names( result2 ) # 계층적 군집 분석에 대한 세부 내용 확인
# [1] "merge"   "height"  "order"   "labels"   "method"  "call"  "dist.method"

# 계층형 군집 분석 결과를 덴드로그램으로 그리기
# hang=-1은 음수 값을 제외하는 옵션이다.
plot( result2, hang=-1)
# 덴드로그램01.png

# 비 계층적 군집화 알고리즘 분석
kmeans3 <- kmeans(result, 3) # 3개의 그룹으로 나누자

kmeans3
# K-means clustering with 3 clusters of sizes 3, 59, 27
# 3개의 그룹으로 나눈 결과 각 군집에 3개/59개/27개로 그룹화되어 있다.
# 
# Cluster means: 각 군집별 평균 값
#   Recency Frequency   Monetary
# 1 2.000000  98.33333 10352.6667 ← 제 1그룹
# 2 1.898305  14.69492   514.5763
# 3 2.148148  34.59259  2354.9259
# 
# Clustering vector: # 각 케이스가 어떤 그룹에 속해 있는 가를 보여 주고 있다. (1그룹은 숫자 1이 3개 보이고 있다.)
#   [1] 2 2 3 3 2 2 3 2 2 2 2 2 3 2 2 2 2 2 2 2 3 2 2 2 2 2 1 2 2 3 3 2 2 3 2 2 2 2 2 3 3 3 2 2 2 2 2 2 1 3 2 2 3 2 2 1
# [57] 2 2 3 2 3 2 2 3 3 3 3 3 2 2 2 3 3 3 3 2 3 2 2 3 2 2 2 2 2 2 2 2 3
# 
# Within cluster sum of squares by cluster:
#   [1]   669195.3  7917790.3 22281681.8
# (between_SS / total_SS =  91.0 %)
# 
# Available components:
#   
#   [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"    "size"        
# [8] "iter"         "ifault"  

cor(result, method="pearson") 
plot(result)
# 상관 계수 그래프.png

# 상관 계수를 색상으로 시각화
# install.packages("corrgram")   
library(corrgram)
corrgram(result, upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽)
# corrgram_upper.png

corrgram(result, lower.panel=panel.conf) # 수치(상관계수) 추가(아래쪽)

# 비계층적 군집 분석 시각화
# 비계층적 군집 분석 결과가 담겨 있는 kmeans3을 이용하여 산포도 그래프를 작성한다.

plot( result[c('Frequency', 'Monetary')], main='[거래 빈도 수]와 [구매 금액]의산점도', col=kmeans3$cluster)

# 군집의 구분을 용이하게 하기 위해 각군의 중앙에 별도의 기호를 표시한다.
points( kmeans3$centers[, c('Frequency', 'Monetary')], col=1:3, pch=8, cex=2, lwd=3)
# 택배 서비스 군집 분석.png