# 중1학년 신체검사 결과 군집 분석
#A 중학교에서 측정한 중 1학생들의 신체 검사 결과를 이용하여 군집 분석을 해보도록 한다.
body = read.csv("R Basic Source/30.군집 분석/bodycheck.csv", header=TRUE)
head(body)

# 학생이 총 15명이다.
dim(body) # 15  5
# 번호 컬럼을 제외한 나머지 컬럼들에 대한 유클리드 거리를 생성한다.
body_dist= dist(body[, -1])

# -- 클러스터링
hc = hclust(body_dist)
hc
# Call:
# hclust(d = body_dist)
#
# Cluster method   : complete <- 2개의 cluster에서 가장 먼 거리를 이용하여 측정하는 방식
# Distance         : euclidean <- 거리 측정 방식은 '유클리디언'거리를 사용.
# Number of objects: 15

# 유사한 데이터(악력, 신장, 체중, 안경 유무)끼리 군집을 생성한다.
plot(hc)

# 군집 단위로 테두리 만들기
# 3개 영역으로 그룹핑(k = 3)한다.
rect.hclust(hc, k = 3, border='red')
rect.hclust(hc, k = 3, border = c('red', 'blue', 'green') )
# 중학생 신검 클러스터 결과.png

# 부연 설명
# 데이터(악력, 신장, 체중, 안경 유무)를 이용하여 3개의 그룹으로 그룹핑한 결과
# 3개 그룹 (10, 4, 8, 1, 15), (11, 3, 5, 6, 14), (2, 9, 13, 7, 12)으로 군집이 형성되었다.
# 또한, 3개의 그룹을 빨간 상자 모양으로 만들어서 명확이 구분이 되도록 하였다.

# 군집별 특성 파악하기
# 군집별 서브 셋을 구하여, 요약 통계량을 이용한 군집별 특징 들을 살펴 보자.
# 각 그룹별 서브셋 만들기
group1= subset(body, 번호==10 | 번호==4 | 번호==8 | 번호==1  | 번호==15)
group2= subset(body, 번호==11 | 번호==3 | 번호==5 | 번호==6  | 번호==14)
group3= subset(body, 번호==2 | 번호==9 | 번호==13 | 번호==7  | 번호==12)

# 군집별 목록 보기
group1[2:5]
#    악력 신장 체중 안경유무
# 1    28  146   34        1
# 4    25  156   38        1
# 8    23  153   40        1
# 10   27  152   39        1
# 15   25  142   32        1

group2[2:5]
group3[2:5]

summary(group1[2:4]) # 1 군집 요약 통계량
#       번호           악력           신장            체중         안경유무
#  Min.   : 1.0   Min.   :23.0   Min.   :142.0   Min.   :32.0   Min.   :1
#  1st Qu.: 4.0   1st Qu.:25.0   1st Qu.:146.0   1st Qu.:34.0   1st Qu.:1
#  Median : 8.0   Median :25.0   Median :152.0   Median :38.0   Median :1
#  Mean   : 7.6   Mean   :25.6   Mean   :149.8   Mean   :36.6   Mean   :1
#  3rd Qu.:10.0   3rd Qu.:27.0   3rd Qu.:153.0   3rd Qu.:39.0   3rd Qu.:1
#  Max.   :15.0   Max.   :28.0   Max.   :156.0   Max.   :40.0   Max.   :1

summary(group2[2:4])
summary(group3[2:4])

# 위의 예시에서 우리는 그래프의 결과를 보고 군집을 분류 하였다.
# stats 패키지에서 제공이 되는 cutree() 함수를 이용하면 군집수로 자를 수 있다. 
ghc <- cutree(hc, k = 3)
ghc
# 1 2 3 1 3 3 2 1 2 1 3 2 2 3 1

newgroup1= subset(body, ghc == 1)

# 다음 결과는 모든 요소가 TRUE이므로 group1과 newgroup1가 동일하다는 의미이다.
group1 == newgroup1
