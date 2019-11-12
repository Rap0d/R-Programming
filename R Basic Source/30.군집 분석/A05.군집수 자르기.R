# 계층형 군집 분석 결과에서 분석자가 원하는 군집수 만큼 잘라서 인위적으로 군집을 만들 수 있다.
head(iris[1:4])

idist <- dist(iris[1:4])

# 계층형 군집 분석(클러스터링)
hc <- hclust( idist )
hc
# Call:
# hclust(d = idist)
# 
# Cluster method   : complete 
# Distance         : euclidean 
# Number of objects: 150 

plot(hc)

K = 3
rect.hclust(hc, k = K, border=rainbow(K))

# 군집수 자르기
ghc <- cutree(hc, k = K) # 군집 분석 결과를 대상의 3개의 군집수를 지정한다.
ghc
# 150개의 관측치를 대상으로 3개의 군집수를 지정하여 군집을 의미하는 숫자(1~3)가 출력이 된다.

unique(ghc) # [1] 1 2 3

# iris 데이터 셋에 ghc 컬럼 추가
iris$ghc <- ghc
table( iris$ghc ) # 빈도수
#  1  2  3 
# 50 72 28 

head(iris)

# 요약 통계량 구하기
g1 <- subset(iris, ghc == 1 )
summary(g1[1:4]) # 제 1군집 요약 통계량

g2 <- subset(iris, ghc == 2 )
summary(g2[1:4])

g3 <- subset(iris, ghc == 3 )
summary(g3[1:4])

# iris 데이터 셋을 대상으로 계층적 군집 분석으로 군집 수를 파악한 후 원하는 군집 수 만큼
# 인위적으로 잘라서 군집을 생성하고, 각 군집별로 요약 통계량을 구하여 군집 내의 특성을 알아 보았다.