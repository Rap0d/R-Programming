library(corrgram)
library(scatterplot3d)

par(family = 'AppleGothic')

# 파일 이름 : factor_analysis.csv
# 위의 파일을 이용하여 요인 분석을 수행하세요
# 
setwd('../25.요인 분석/')
data <- read.csv('factor_analysis.csv')
# 상관 계수를 이용하여 개략적인 특징을 파악해 보세요.
head(data)
str(data)
class(data)

# 변수의 주요 성분 분석
## 요인 분석에서 공통 요인으로 묶일 요소 수

# 주성분 분석 수행 함수
pc <- prcomp(data)
class(pc)
summary(pc)
# Importance of components:
#                           PC1    PC2    PC3    PC4     PC5     PC6
# Standard deviation     2.9724 1.5844 1.4889 0.6763 0.44834 0.34049
# Proportion of Variance 0.6163 0.1751 0.1546 0.0319 0.01402 0.00809
# Cumulative Proportion  0.6163 0.7914 0.9460 0.9779 0.99191 1.00000
## PC1 ~ PC3까지의 변동폭이 크므로 factor를 3으로 가정한다.

# 상관 계수를 그래프를 그려 보세요.
mColor <- rainbow(ncol(data))
plot(pc, main = '주 성분 분석 결과 시각화', col = mColor, ylim = c(0, 6))
abline(h = seq(0, 6, 1), lty = 2)
legend('topright', '', c('PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6'), fill = mColor)

# 주성분 요인수를 분석하세요.
## 첫 번째 성분이 변동량 61%, 두 번째 성분이 18%, 세 번째 성분이 15%를 차지한다.
## 이 3개의 변동량이 전체의 94%를 차지한다. 
## 전체 6개 성분 중 주 성분 변수를 3개로 가정할 수 있다.

# 주성분에 대하여 시각화를 수행해 보세요.
## 상관 계수 행렬
class(cor(data))
cor(data)
## 변수간 상관 관계 분석과 요인 수 분석
## 상관 관계 분석 : 요인 분석은 변수 간 상관성으로 공통성을 인식
corrgram(cor(data), upper.panel = panel.conf)

# 요인을 분석하세요.
## 상관 계수 행렬을 대상으로 초기 고유값으로 요인 수를 알아본다.
en <- eigen(cor(data))

## 초기 고유값 계산
en$values
# [1] 3.69391386 1.03419457 0.94752707 0.19286642 0.08178566 0.04971242

## 고유 벡터
en$vectors
#           [,1]       [,2]        [,3]       [,4]        [,5]        [,6]
# [1,] 0.3927278  0.2606205 -0.54819213  0.5976675 -0.11344385  0.32749236
# [2,] 0.4196373  0.3310316  0.45128226 -0.3526018 -0.03339597  0.62066384
# [3,] 0.4144774  0.2890788 -0.46606690 -0.5635109  0.21591790 -0.40405262
# [4,] 0.4147989 -0.5545170 -0.04007911 -0.1554791 -0.69859479 -0.08147389
# [5,] 0.3972015 -0.6017487  0.05300804  0.1144664  0.67155730  0.11501251
# [6,] 0.4099400  0.2633209  0.52363648  0.4045301 -0.01925539 -0.56956190

## 고유값을 이용한 시각화
plot(en$values, type = 'o', pch = 19)

## 요인 분석 : 요인 회전법 적용
### 요인 분석에서 해석이 어려운 한 요인을 높게 나타나도록 하기 위해 요인 축 회전
### 일반적으로 varimax 회전법을 사용한다.

## 주 성분 분석의 가정에 의한 3개 요인으로 분석
res <- factanal(data, factors = 3, rotation = 'varimax', scores = "regression")
res
# Call:
#   factanal(x = data, factors = 3, rotation = "varimax")
# 
# Uniquenesses: ## 유효성 판단값, 0.5이하면 유효 
#   col1  col2  col3  col4  col5  col6 
# 0.269 0.005 0.005 0.150 0.005 0.158 
# 
# Loadings: ## 요인 적재 값, 값이 +0.4 미만이면 중요도가 낮음
#   Factor1 Factor2 Factor3
# col1 0.233   0.169   0.805  
# col2 0.179   0.936   0.294  
# col3 0.191   0.275   0.940  
# col4 0.847   0.224   0.287  
# col5 0.958   0.219   0.169  
# col6 0.262   0.864   0.167  
# 
# Factor1 Factor2 Factor3
# SS loadings      1.827   1.825   1.756
# Proportion Var   0.305   0.304   0.293
# Cumulative Var   0.305   0.609   0.901
# 
# The degrees of freedom for the model is 0 and the fit was 0.2353 
## 적합한 요인의 개수라고 볼 수 있음 

## 여러 방식으로 요인 적재량 보기
attributes(res)
# $names
# [1] "converged"    "loadings"     "uniquenesses" "correlation"  "criteria"     "factors"     
# [7] "dof"          "method"       "rotmat"       "scores"       "n.obs"        "call"        
# 
# $class
# [1] "factanal"
res$loadings
# Loadings:
#   Factor1 Factor2 Factor3
# col1 0.233   0.169   0.805  
# col2 0.179   0.936   0.294  
# col3 0.191   0.275   0.940  
# col4 0.847   0.224   0.287  
# col5 0.958   0.219   0.169  
# col6 0.262   0.864   0.167  
# 
# Factor1 Factor2 Factor3
# SS loadings      1.827   1.825   1.756
# Proportion Var   0.305   0.304   0.293
# Cumulative Var   0.305   0.609   0.901

## all factor loadings value
print(res$loadings, cutoff = 0)

## 요인 점수 (요인 분석에서 추정된 값)
res$scores
# Factor1    Factor2    Factor3
# [1,] -0.9536135 -0.9663100  0.9561057
# [2,] -0.9536135 -0.9663100  0.9561057
# [3,] -0.9525837 -0.9952723  0.9781491
# [4,] -0.2543226 -1.0882619  0.8498464
# [5,] -1.0914886 -0.2472676  0.7830621
# [6,]  0.6513422 -0.7618637 -0.7770620
# [7,]  0.6502774 -0.7428198 -0.7744200
# [8,]  0.6502774 -0.7428198 -0.7744200
# [9,]  1.3485386 -0.8358094 -0.9027227
# [10,]  0.6513422 -0.7618637 -0.7770620
# [11,]  0.2488247  0.5689370 -0.4194070
# [12,] -1.0639020  0.9999696 -0.9409056
# [13,] -1.0628722  0.9710073 -0.9188622
# [14,] -0.3646110  0.8780177 -1.0471649
# [15,] -1.0628547  0.9759665 -0.9312049
# [16,]  2.0435182  0.3693182  1.3237255
# [17,]  1.2512776  1.4723271  0.5049916
# [18,]  0.2644633  1.8730547  1.9112451

## 요인 점수를 이용한 요인 loadings 시각화
plot(res$scores[, c(1:2)], main = 'Factor1, 2, 3의 요인 점수 행렬', lwd = 5, col = 'red')
## 산점도에 따른 레이블 표시
name <- paste('문제', c(1:10), sep = "")
text(res$scores[,1], res$scores[,2], labels = name, cex = 0.7, pos = 3, col = 'blue')

## 요인 적재량 추가
points(res$loadings[, 1], res$loadings[, 2], pch=19, col='green', lwd = 5)
text(res$loadings[, 1], res$loadings[, 2], labels = rownames(res$loadings), 
     cex = 0.7, pos = 3, col = 'red')
abline(h = 1.0, lty = 2)
abline(v = 1.0, lty = 2)

## Factor1과 Factor3를 이용한 요인 적재량 시각화
plot( res$scores[, c(1, 3)], main='Factor1과 Factor3 요인 점수 행렬', lwd = mylwd, col='red')
# 산점도에 따른 레이블 표시(문항 이름 : name)
# 산점도에 따른 레이블 표시(문항 이름 : name)
text(res$scores[, 1], res$scores[, 3], labels=name, cex=0.7, pos=3, col='blue')

# 요인 적재량 추가
points( res$loadings[, c(1, 3)], col='green', lwd = mylwd)
# 요인 적재량의 레이블 표시
text( res$loadings[, 1], res$loadings[, 3], labels=rownames(res$loadings),
      cex=0.7, pos=3, col='red')
abline(h = 1.0, lty = 2)
abline(v = 1.0, lty = 2)

Factor1 <- res$scores[, 1]
Factor2 <- res$scores[, 2]
Factor3 <- res$scores[, 3]

d3 <- scatterplot3d( Factor1, Factor2, Factor3, type='p' )

# 요인 적재량 표시
loadings1 <- res$loadings[,1]
loadings2 <- res$loadings[,2]
loadings3 <- res$loadings[,3]

d3$points3d(loadings1, loadings2, loadings3, bg='red', pch=21, cex=2, type='h')

# 요인 부하량 막대 그래프 표현
barplot(res$loadings, beside = T, col = rainbow(nrow(res$loadings)))

# 각 요인별로 어느 변수가 많은 비율을 차지하는 지 시각화
par(mfrow = c(1, 3))
pie(loadings1, beside = T)
pie(loadings2, beside = T)
pie(loadings3, beside = T)

# 요인 점수 및 시각화
par(mfrow = c(1, 1))
barplot(res$scores, beside = T)

# 요인별 산술 평균을 이용하여 변수의 갯수를 줄여 보세요.
fac01 <- (data$col4 + data$col5)
fac02 <- (data$col2 + data$col6)
fac03 <- (data$col1 + data$col3)

data_df <- data.frame(fac01, fac02, fac03)
cor(data_df)
#           fac01     fac02     fac03
# fac01 1.0000000 0.4687506 0.4667733
# fac02 0.4687506 1.0000000 0.5009525
# fac03 0.4667733 0.5009525 1.0000000

# 추려진 요인들을 이용하여 상관 관계 분석을 수행해 보세요.
## 상관관계분석표를 보면 fac02와 fac03이 0.5의 
## 양의 상관 관계를 가지고 있다는 것을 알 수 있다.
corrgram(cor(data_df), upper.panel = panel.conf)

