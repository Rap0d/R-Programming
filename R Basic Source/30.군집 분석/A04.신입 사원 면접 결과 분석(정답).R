# 데이터 셋 가져 오기
interview <- read.csv('interview.csv', header = T )

names(interview)
# [1] "no"       "가치관"   "전문지식" "발표력"   "인성"     "창의력"   "자격증"   "종합점수" "합격여부"

head(interview)

# 유클리디언 거리 계산
interview_df <- interview[c(2:7)] # no 컬럼은 뺀다.
interview_df

# 유클리디언 거리 생성하기
idist <- dist(interview_df)
idist <- dist(interview_df, diag=TRUE)
head(idist)
# [1]  3.464102 11.445523  2.449490 15.524175  3.741657 14.142136

# 계층적 군집 분석
hc <- hclust(idist)
hc
# Call:
# hclust(d = idist)
# 
# Cluster method   : complete 
# Distance         : euclidean 
# Number of objects: 15 <-- 15개 행에 대한 군집 분석

# 군집 분석 시각화
plot(hc)

# 군집 단위 테두리 생성
rect.hclust(hc, k=3, border='red')

# 군집별 특징 보기
g1 <- subset(interview, no==108 | no==110 | no==107 | no==112 | no==115 )

g2 <- subset(interview, no==102 | no==101 | no==104 | no==106 | no==113 )

g3 <- subset(interview, no==105 | no==114 | no==109 | no==103 | no==111 )

# 그룹 요약 통계량
summary(g1)
#        no            가치관        전문지식        발표력          인성          창의력         자격증     종합점수      합격여부
#  Min.   :107.0   Min.   :13.0   Min.   :17.0   Min.   : 8.0   Min.   : 8.0   Min.   :16.0   Min.   :0   Min.   :65.0   불합격:5  
#  1st Qu.:108.0   1st Qu.:14.0   1st Qu.:18.0   1st Qu.:10.0   1st Qu.: 9.0   1st Qu.:17.0   1st Qu.:0   1st Qu.:70.0   합격  :0  
#  Median :110.0   Median :14.0   Median :19.0   Median :11.0   Median :10.0   Median :18.0   Median :0   Median :72.0             
#  Mean   :110.4   Mean   :14.4   Mean   :18.8   Mean   :10.8   Mean   : 9.4   Mean   :18.2   Mean   :0   Mean   :71.6             
#  3rd Qu.:112.0   3rd Qu.:15.0   3rd Qu.:20.0   3rd Qu.:12.0   3rd Qu.:10.0   3rd Qu.:20.0   3rd Qu.:0   3rd Qu.:75.0             
#  Max.   :115.0   Max.   :16.0   Max.   :20.0   Max.   :13.0   Max.   :10.0   Max.   :20.0   Max.   :0   Max.   :76.0             

summary(g2)
summary(g3)