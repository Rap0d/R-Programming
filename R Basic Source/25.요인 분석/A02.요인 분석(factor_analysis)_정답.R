myfile <- read.csv('factor_analysis.csv', header=TRUE)
head(myfile)

# 자료의 개략적인 특성을 파악하기 위하여 상관 계수를 확인해보자.
round(cor(myfile), 2)
#      col1 col2 col3 col4 col5 col6
# col1 1.00 0.43 0.85 0.46 0.40 0.43
# col2 0.43 1.00 0.57 0.45 0.43 0.90
# col3 0.85 0.57 1.00 0.49 0.40 0.44
# col4 0.46 0.45 0.49 1.00 0.91 0.45
# col5 0.40 0.43 0.40 0.91 1.00 0.47
# col6 0.43 0.90 0.44 0.45 0.47 1.00

library(corrgram)
corrgram( cor(myfile), upper.panel=panel.conf )
# 그래프의 색상을 확인해보면 다음과 같은 요소들끼리 상관 계수가 크다.
# col1과 col3, col2와 col6, col4와 col5이다.

# 주성분 요인수 분석
pc <- prcomp(myfile)
summary(pc)
# Importance of components:
#                       PC1    PC2    PC3    PC4     PC5     PC6
# Standard deviation     2.9724 1.5844 1.4889 0.6763 0.44834 0.34049
# Proportion of Variance 0.6163 0.1751 0.1546 0.0319 0.01402 0.00809
# Cumulative Proportion  0.6163 0.7914 0.9460 0.9779 0.99191 1.00000
# Cumulative Proportion는 분산의 누적 비율로써, PC3까지의 누적 비율이 전체의 94.6%를 차지하고 있다.

# 시각화
plot(pc, main='주성분 요인수 분석', type='l', sub='My Plot', ylim=c(0, 10))
# 주성분 요인수 분석.png
# 그림에서 보면, 앞의 3개가 기울기가 좀 크다
# 즉, 주성분을 3개로 가정하자.

# 요인 분석하기
fact_result <- factanal(myfile, factors=3, scores=c('regression'))
fact_result
# Call:
#   factanal(x = myfile, factors = 3, scores = c("regression"))
# 
# Uniquenesses:
#   col1  col2  col3  col4  col5  col6 
# 0.269 0.005 0.005 0.150 0.005 0.158 
# 
# Loadings:
#      Factor1 Factor2 Factor3
# col1 0.233   0.169   0.805  
# col2 0.179   0.936   0.294  
# col3 0.191   0.275   0.940  
# col4 0.847   0.224   0.287  
# col5 0.958   0.219   0.169  
# col6 0.262   0.864   0.167  
# 
#                  Factor1 Factor2 Factor3
# SS loadings      1.827   1.825   1.756
# Proportion Var   0.305   0.304   0.293
# Cumulative Var   0.305   0.609   0.901
# 
# The degrees of freedom for the model is 0 and the fit was 0.2353 

# 결과 설명
fact_result$uniquenesses <= 0.5
# Uniquenesses 항목은 통상적으로 0.5이하이면 유효하다고 보는데, 전부 0.5 이하이다.

# Loadings 항목에서 col4와 col5 컬럼은 Factor1의 값이 가장 크다.
# 이 둘(col4와 col5)은 묶어서 하나의 항목으로 축소해 볼 수 있다.
# 마찬가지로 col2, col6, 그리고 col1, col3으로 묶을 수 있다.
# Cumulative Var : 현재 정보 손실은 0.099(1-0.901)으로 적정한 상태이다.
# 이 값이 너무 크면(얼마? 요인 분석의 의미가 없어 진다.

# 기본 요인 적재량 보기
attributes( fact_result )
# $names
#  [1] "converged"    "loadings"     "uniquenesses" "correlation" 
#  [5] "criteria"     "factors"      "dof"          "method"      
#  [9] "rotmat"       "scores"       "n.obs"        "call"        
# 
# $class
# [1] "factanal"

dim(myfile)
# [1] 18  6

# loadings : 기본으로 제공되는 요인 적재량 보기
dim(fact_result$loadings)
# [1] 6 3

myloading <- fact_result$loadings

# 요인 부하량 막대 그래프 표현
# 각 요인별로 어느 변수가 많은 비율을 차지하는 지 시각화

mycolor <- rainbow(6)
myplot <- round(abs(myloading), 2)
barplot(myplot, main='Factor Loading', col=mycolor, legend=T, beside=TRUE)
# Factor_Loading.png

# 요인 점수 및 시각화
names(fact_result)
#  [1] "converged"    "loadings"     "uniquenesses" "correlation"  "criteria"     "factors"     
#  [7] "dof"          "method"       "rotmat"       "scores"       "n.obs"        "call"    

fact_result$scores # 요인 점수

# 시각화
name <- paste('data', c(1:16), sep='')
name

mycex = 0.8
mylwd = 5
mypos = 3

plot( fact_result$scores[, c(1:2)], main='Factor1과 Factor2 요인 점수 행렬', lwd = mylwd, col='red')
text( fact_result$scores[, 1], fact_result$scores[, 2], labels=name, cex=mycex, pos=mypos, col='blue')

# text(fact_result$loadings[, 1:2], colnames(myfile))

# 요인 적재량 추가
points( fact_result$loadings[, c(1:2)], pch=19, col='green', lwd = mylwd)
# 요인 적재량의 레이블 표시
text( fact_result$loadings[, 1], fact_result$loadings[, 2], labels=rownames(fact_result$loadings),
      cex=mycex, pos=mypos, col='red')

abline(h = 1.0, lty = 2)
abline(v = 1.0, lty = 2)
# Factor(요소)1과 Factor(요소)2 요인 점수 행렬.png


# 요인 점수 : 요인 적재량을 대상으로 각각의 사례가 추출된 요인을 
#             반영하고 있는 정도를 나타내는 점수를 말한다.
jumsu1 <- data.frame(myfile$col1, myfile$col3) 
jumsu2 <- data.frame(myfile$col4, myfile$col5) 
jumsu3 <- data.frame(myfile$col2, myfile$col6) 

# 요인별 산술 평균 계산
jumsu1_mean <- round((jumsu1$myfile.col1 + jumsu1$myfile.col3)/ncol(jumsu1), 2)
jumsu2_mean <- round((jumsu2$myfile.col4 + jumsu2$myfile.col5)/ncol(jumsu2), 2)
jumsu3_mean <- round((jumsu3$myfile.col2 + jumsu3$myfile.col6)/ncol(jumsu3), 2)

# 상관 관계 분석
fact_result_factor_df <- data.frame(jumsu1_mean, jumsu2_mean, jumsu3_mean)

cor(fact_result_factor_df)
#               jumsu1_mean jumsu2_mean jumsu3_mean
# jumsu1_mean   1.0000000   0.4667733   0.5009525
# jumsu2_mean   0.4667733   1.0000000   0.4687506
# jumsu3_mean   0.5009525   0.4687506   1.0000000

# 상관 관계 분석표에 보면 jumsu1_mean과 jumsu3_mean이 약간의 0.50 정도의 상관 관계를 가지고 있다는 것을 알 수 있다.
corrgram( cor(fact_result_factor_df), upper.panel=panel.conf )
# jumsu 상관 관계 분석표.png

