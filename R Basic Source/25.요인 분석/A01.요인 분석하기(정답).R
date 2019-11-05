setwd('R Basic Source/')

# 과목 변수들을 저장하고 있는 엑셀 파일 읽어 오기
subject <- read.csv('factor_analyze.csv', header=TRUE)
str(subject)
# 'data.frame':	10 obs. of  6 variables:

class(subject) # "data.frame"
subject

# 변수의 주요 성분 분석
# 요인 분석에서 공통 요인으로 묶일 요소 수를 알아 본다.
pc <- prcomp( subject ) # 주성분 분석 수행 함수
class(pc) # "prcomp"
summary( pc )

# 두 번째 변동량까지 전체의 88%를 차지 하고 있으므로 주성분의 갯수를 2개라고 가정한다.
# Importance of components%s:
#                          PC1    PC2     PC3     PC4     PC5     PC6
# Standard deviation     2.389 1.5532 0.87727 0.56907 0.19315 0.12434
# Proportion of Variance 0.616 0.2603 0.08305 0.03495 0.00403 0.00167
# Cumulative Proportion  0.616 0.8763 0.95936 0.99431 0.99833 1.00000

mycolor = rainbow(ncol(subject))
plot( pc, main='주성분 분석 결과 시각화', col=mycolor, ylim=c(0, 6) )
# 주성분 분석 결과 시각화.png

abline(h=seq(0, 6, 1), lty=2)

legend('topright', '', c('PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6'), fill=mycolor)

# 부연 설명
# 첫 번째 성분이 변동량 62%, 두 번째 성분이 변동량 26%를 차지하고 있다.
# 이 2개의 변동량이 전체의 88%정도를 차지하고 있다.
# 전체 6개의 성분(과목) 중에서 주성분 변수를 2개로 가정할 수 있다.

# install.packages('corrgram')
# corrgram 함수를 이용하여 상관 계수와 색의 농도를 이용하여 시각화 해준다.
library(corrgram)

# matrix : 상관 계수 행렬이라고 한다.
class(cor(subject)) 

# 변수 간의 상관 관계 분석과 요인 분석
# 상관 관계 분석 : 요인 분석은 변수 간의 상관성으로 공통점을 인식한다.
par(family = 'AppleGothic')
corrgram( cor(subject), upper.panel=panel.conf )
# 상관 관계 도식화.png

# 부연 설명
# 위의 상관 계수 그림에서 동일 계열의 과목 점수에 대한 상관 계수가 높은 것으로 나타난다.
# 즉, 국어와 영어 / 수학과 물리 / 인문과 사회 과목이 서로 상관 계수가 높게 나오고 있다.
# 요인 분석은 기본적으로 상관 계수를 토대로 공통 요인을 추출한다.


# 고유 값으로 요인 수를 분석하기
# 상관 계수 행렬을 대상으로 초기 고유 값으로 요인 수를 알아 본다.
en <- eigen( cor(subject) )
en$values # 초기 고유 값 계산
# 3.44393944 1.88761725 0.43123968 0.19932073 0.02624961 0.01163331

en$vectors # 고유 벡터
# [,1]         [,2]        [,3]       [,4]        [,5]        [,6]
# [1,] -0.4062499 -0.351093036  0.63460534 -0.3149622  0.45699508  0.03041553
# [2,]  0.2542077 -0.628807884 -0.06984072 -0.3339036 -0.35389906 -0.54622817
# [3,]  0.4763815  0.008436692  0.58035475  0.6016209  0.05643527 -0.26654314
# [4,]  0.3017115 -0.566028650 -0.37734321  0.2468016  0.50326085  0.36333366
# [5,]  0.5155637  0.021286661  0.31595023 -0.4133867 -0.28995329  0.61559319
# [6,] -0.4319311 -0.400526644  0.11564711  0.4422216 -0.57042232  0.34452594

# 고유 값을 이용한 시각화
plot(en$values, type='o', pch=19) # pch=19는 solid circle이다.
# 고유 값을 이용한 시각화.png

# 위의 그림에서 1 ~ 3까지의 고유 값은 급격히 감소하다가, 4번째 고유 값에서 조금 완만하게 감소한다.
# 이러한 측면에서 보면 주성분은 3개로 가정할 수 있다.


# 요인 분석 : 요인 회전법 적용
# 요인 분석에서 해석이 어려운 어느 한 요인을 높게 나타나도록 하기 위하여 요인 축을 회전하는 방법이 있다.
# 일반적으로, varimax 회전법을 많이 사용한다.

# 주성분 분석의 가정에 의한 2개 요인으로 분석
result <- factanal(subject, factors=2, rotation='varimax')
result
# ... 중략
# Test of the hypothesis that 2 factors are sufficient.
# The chi square statistic is 11.32 on 4 degrees of freedom.
# The p-value is 0.0232 

# 위 결과를 보면 p-value(0.0232) < 0.05이므로 요인 수가 부족하다는 의미이다.
# 요인의 갯수를 다시 늘려서 분석을 수행해야 한다.

# 고유 값으로 가정한 3개의 요인으로 분석
result <- factanal(subject, factors=3, rotation='varimax', scores='regression')
result
# Call:
#   factanal(x = subject, factors = 3, scores = "regression", rotation = "varimax")
# 
# Uniquenesses:
#   국어  수학  인문  물리  사회  영어 
# 0.005 0.051 0.240 0.005 0.005 0.056 
# 
# Loadings:
#   Factor1 Factor2 Factor3
# 국어 -0.379           0.923 
# 수학  0.236   0.931   0.166 
# 인문  0.771   0.297  -0.278 
# 물리  0.120   0.983  -0.118 
# 사회  0.900   0.301  -0.307 
# 영어 -0.710   0.140   0.649 
# 
# Factor1 Factor2 Factor3
# SS loadings      2.122   2.031   1.486
# Proportion Var   0.354   0.339   0.248
# Cumulative Var   0.354   0.692   0.940
# 
# The degrees of freedom for the model is 0 and the fit was 0.7745 

# 다양한 방법으로 요인 적재량 보기
# 기본 요인 적재량 보기
attributes( result ) # 결과 변수 속성 보기
# $names
#  [1] "converged"    "loadings"     "uniquenesses" "correlation"  "criteria"     
#  [8] "factors"      "dof"   "method"       "rotmat"       "scores"       "n.obs"        "call"        
# 
# $class
# [1] "factanal"

# 기본적으로 제공되는 요인 적재량 보기
result$loadings

# 모든 요인 적재량 보기
print(result$loadings, cutoff=0)
# Call:
#   factanal(x = subject, factors = 3, scores = "regression", rotation = "varimax")
# 
# Uniquenesses: 유효성을 판단하여 제시하는 값으로 통상적으로 0.5이하이면 유효하다고 본다.
#   국어  수학  인문  물리  사회  영어 
# 0.005 0.051 0.240 0.005 0.005 0.056 
# 
# Loadings: 요인 적재 값이라고한다.
#           각 변수와 해당 요인 간의 상관 계수를 의미한다.
# 통상적으로 값이 +0.4미만이면 중요도가 낮다 라고 본다.
# 아래 결과에서 국어와 영어는 Factor3에서 상관 계수가 비교적 크다.
# 따라서, Factor3으로 묶어서 한 과목으로 축소할 수 있다.
#   Factor1 Factor2 Factor3
# 국어 -0.379  -0.005   0.923 
# 수학  0.236   0.931   0.166 
# 인문  0.771   0.297  -0.278 
# 물리  0.120   0.983  -0.118 
# 사회  0.900   0.301  -0.307 
# 영어 -0.710   0.140   0.649 

# SS loadings는 각 요인 적재 값의 제곱의 합을 제시한 값이다.
# 예를 들어서 Factor3은 1.486인데, 0.923부터 0.649까지의 제곱한 값들의 합이다.
# Factor1 Factor2 Factor3
# SS loadings      2.122   2.031   1.486
# Proportion Var   0.354   0.339   0.248
# Cumulative Var   0.354   0.692   0.940
# 정보 손실 = 1 - 0.94 = 0.06으로 적정한 상태이다.
# The degrees of freedom for the model is 0 and the fit was 0.7745 

# 요인 점수란 요인 분석에서 추정된 값을 의미한다.
# scores 속성의 값을 이용하여 요인 점수를 확인할 수 있다.
result$scores # 요인 점수 보기

# 요인 점수를 이용한 요인 적재량 시각화
# Factor1과 Factor2를 이용한 요인 적재량 시각화
mylwd = 5
plot( result$scores[, c(1:2)], main='Factor1과 Factor2 요인 점수 행렬', lwd = mylwd, col='red')
# 산점도에 따른 레이블 표시(문항 이름 : name)

# name : 각 과목의 문항 이름
name <- paste('문제', c(1:10), sep='')
name

mycex = 0.8
mypos = 3

text(result$scores[, 1], result$scores[, 2], labels=name, cex=mycex, pos=mypos, col='blue')

# 요인 적재량 추가
points( result$loadings[, c(1:2)], pch=19, col='green', lwd = mylwd)
# 요인 적재량의 레이블 표시
text( result$loadings[, 1], result$loadings[, 2], labels=rownames(result$loadings),
      cex=mycex, pos=mypos, col='red')

abline(h = 1.0, lty = 2)
abline(v = 1.0, lty = 2)
# Factor1과 Factor2 요인 점수 행렬.png

# 부연 설명
# 1~2 번째 요인을 대상으로 산점도를 그리고, 각 점에 문항 이름을 적용한다.
# Factor1의 요인 점수를 기준으로 1에 가까운 요인은 인문과 사회 과목으로 나타난다.
# Factor2의 요인 점수를 기준으로 1에 가까운 요인은 물리와 수학 과목으로 나타난다.
# 참고로, 국어와 영어는 어더한 요인으로도 분류되지 않는다.

# Factor1과 Factor3를 이용한 요인 적재량 시각화
plot( result$scores[, c(1, 3)], main='Factor1과 Factor3 요인 점수 행렬', lwd = mylwd, col='red')
# 산점도에 따른 레이블 표시(문항 이름 : name)
# 산점도에 따른 레이블 표시(문항 이름 : name)
text(result$scores[, 1], result$scores[, 3], labels=name, cex=mycex, pos=mypos, col='blue')

# 요인 적재량 추가
points( result$loadings[, c(1, 3)], col='green', lwd = mylwd)
# 요인 적재량의 레이블 표시
text( result$loadings[, 1], result$loadings[, 3], labels=rownames(result$loadings),
      cex=mycex, pos=mypos, col='red')
abline(h = 1.0, lty = 2)
abline(v = 1.0, lty = 2)
# Factor1과 Factor3 요인 점수 행렬.png

# 부연 설명
# 1, 3 번째 요인을 대상으로 산점도를 그리고, 각 점에 문항 이름을 적용한다.
# Factor3의 요인 점수를 기준으로 1에 가까운 요인은 국어와 영어 과목으로 나타난다.

# 3차원 산점도로 요인 적재량 시각화
# Factor1, Factor2, Factor3의 요인 적재량을 3차원 산점도를 이용하여 동시에 시각화 해보도록 한다.
# install.packages('scatterplot3d')
library(scatterplot3d)

# 요인 점수별 분류 및 3차원 프레임 생성
Factor1 <- result$scores[, 1]
Factor2 <- result$scores[, 2]
Factor3 <- result$scores[, 3]

# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type)
d3 <- scatterplot3d( Factor1, Factor2, Factor3, type='p' )

# 요인 적재량 표시
loadings1 <- result$loadings[,1]
loadings2 <- result$loadings[,2]
loadings3 <- result$loadings[,3]

d3$points3d(loadings1, loadings2, loadings3, bg='red', pch=21, cex=2, type='h')
# 요인 적재량(3차원 산점도).png

# 부연 설명
# 3차원 산점도에서 국어와 영어는 Factor3, 수학과 물리는 Factor2, 인문과 사회는 Factor1으로 분류된다.
# 따라서, 2차원의 산점도 결과와 동일한 형태로 요인 적재량이 시각화된다.

# 요인 점수 : 요인 적재량을 대상으로 각각의 사례가 추출된 요인을 
#             반영하고 있는 정도를 나타내는 점수를 말한다.

# 요인별 산술 평균
app_science <- (subject$수학 + subject$물리)/2
soc_science <- (subject$인문 + subject$사회)/2
net_science <- (subject$국어 + subject$영어)/2

app_science # 응용 과학
soc_science # 사회 과학
net_science # 언어

# 상관 관계 분석
subject_factor_df <- data.frame(app_science, soc_science, net_science)

cor(subject_factor_df)
#             app_science soc_science net_science
# app_science   1.0000000  0.43572654 -0.68903024
# soc_science   0.4357265  1.00000000 -0.02570212
# net_science  -0.6890302 -0.02570212  1.00000000

# 상관 관계 분석표에 보면 '응용 과학'(app_science)과 '사회 과학'(soc_science)이 약간의 양의 상관(0.44정도) 관계를 가지고 있다는 것을 알 수 있다.
corrgram( cor(subject_factor_df), upper.panel=panel.conf )
# 상관 관계 분석표.png

