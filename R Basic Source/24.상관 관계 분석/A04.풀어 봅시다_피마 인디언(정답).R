pima_indian <- read.csv('pima-indians-diabetes.csv', header=FALSE)

colnames(pima_indian) <- c('pregnant', 'plasma', 'pressure', 'thickness', 'insulin', 'BMI', 'pedigree', 'age', 'class')

head(pima_indian)
colnames(pima_indian)
str(pima_indian)
dim(pima_indian) # 768   9

# 전체 변수간의 상관 계수 보기
cor(pima_indian, method='pearson')

# 색상으로 표현하기
# 동일한 색상으로 그룹을 표시하고, 색의 농도로 상관 계수를 나타낸다.
# install.packages('corrgram')
library(corrgram)

# corrgram 함수를 이용하여 상관 계수와 색의 농도를 이용하여 시각화 해준다.
# 범죄에 가장 영향을 미치는 변수는 외국인이다.
# 동일 색상으로 그룹화 표시
corrgram( pima_indian )
# 범죄_동일 색상으로 그룹화 표시.png

corrgram( pima_indian, upper.panel=panel.conf )
# 피마_위쪽에 상관 계수 추가.png

corrgram( pima_indian, lower.panel=panel.conf )
# 피마_아래 쪽에 상관 계수 추가.png

# install.packages('PerformanceAnalytics')
library(PerformanceAnalytics)

chart.Correlation(pima_indian, pch='+')

# 상관 계수가 큰 변수 4개만 추출하여 다시 그려 보도록 한다.
new_pima <- pima_indian[c("pregnant", "plasma", "BMI", "age", "class")]

head(new_pima)
summary( new_pima )
# pregnant          plasma           BMI             age            class
# Min.   : 0.000   Min.   :  0.0   Min.   : 0.00   Min.   :21.00   Min.   :0.000
# 1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.:27.30   1st Qu.:24.00   1st Qu.:0.000
# Median : 3.000   Median :117.0   Median :32.00   Median :29.00   Median :0.000
# Mean   : 3.845   Mean   :120.9   Mean   :31.99   Mean   :33.24   Mean   :0.349
# 3rd Qu.: 6.000   3rd Qu.:140.2   3rd Qu.:36.60   3rd Qu.:41.00   3rd Qu.:1.000
# Max.   :17.000   Max.   :199.0   Max.   :67.10   Max.   :81.00   Max.   :1.000

sd( new_pima$pregnant) # 3.369578
sd( new_pima$plasma) #  31.97262
sd( new_pima$BMI) #  7.88416
sd( new_pima$age) # 11.76023
sd( new_pima$class) #  0.4769514

cor(new_pima, method='pearson')
# pregnant    plasma        BMI        age     class
# pregnant 1.00000000 0.1294587 0.01768309 0.54434123 0.2218982
# plasma   0.12945867 1.0000000 0.22107107 0.26351432 0.4665814
# BMI      0.01768309 0.2210711 1.00000000 0.03624187 0.2926947
# age      0.54434123 0.2635143 0.03624187 1.00000000 0.2383560
# class    0.22189815 0.4665814 0.29269466 0.23835598 1.0000000

chart.Correlation(new_pima, pch='+')
# 상관 계수가 큰 변수 4개만 추출.png
# 당뇨병에 영향을 많이 미치는 변수는 plasma → BMI → age → pregnant 순이다.
# pregnant와 BMI 변수는 대체적으로 정규 분포 곡선을 유지하고 있다.
# pregnant와 age는 꼬리가 오른쪽인 양의 왜도 현상을  조금 보이고 있다.

# 피마 인더언_상관 관계 분석_문서.doc 문서에 정리 요망