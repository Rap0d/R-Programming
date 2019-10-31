# 범죄 빈도수가 분석된 데이터를 대상으로 변수들 간의 상관 계수를 통해서 상관 관계 분석을 해보도록 한다.
crime <- read.csv("범죄와외국등록일반.csv")
head( crime )

# 기술 통계량
summary( crime )
#       범죄           외국인      내국인
#  Min.   :  61.00   Min.   : 379   Min.   :17286
#  1st Qu.:  74.75   1st Qu.:1255   1st Qu.:26824
#  Median : 147.00   Median :1838   Median :32133
#  Mean   : 258.43   Mean   :2228   Mean   :35416
#  3rd Qu.: 223.00   3rd Qu.:2744   3rd Qu.:40118
#  Max.   :1194.00   Max.   :5665   Max.   :77330

# 표준 편차 : 0에 가까울수록 관측 값이 균일하다.
sd( crime$범죄) # [1] 313.8823
sd( crime$외국인) # [1] 1708.76
sd( crime$내국인) # [1] 14995.47

# cor() : 상관 계수를 구해준다.
# 피어슨 상관 계수를 이용하여 변수들 간의 상관 관계를 살펴 보도록 한다.
corr1 <- cor(crime$범죄, crime$외국인) # [1] 0.8493688

corr2 <- cor(crime$범죄, crime$내국인) # [1] 0.2461979

cor(crime$외국인, crime$내국인) # [1] 0.4708816

mat <- cbind(corr1, corr2)
colnames(mat) <- c('외국인 범죄', '내국인 범죄')

barplot(mat, main='범죄와 내외국인과의 상관 계수', ylim=c(0,1.0))

# 전체 변수간의 상관 계수 보기
cor(crime, method='pearson')
#         범죄 외국인  내국인
# 범죄    1.0000000  0.8493688 0.2461979
# 외국인  0.8493688  1.0000000 0.4708816
# 내국인  0.2461979  0.4708816 1.0000000

# 위의 예시에서 외국인과 범죄 간의 상관 계수가 가장 높은 것으로 나타난다.
# 대각선은 자기 자신과의 상관 관계를 의미한다.

# 색상으로 표현하기
# 동일한 색상으로 그룹을 표시하고, 색의 농도로 상관 계수를 나타낸다.
# install.packages('corrgram')
library(corrgram)

# corrgram 함수를 이용하여 상관 계수와 색의 농도를 이용하여 시각화 해준다.
# 범죄에 가장 영향을 미치는 변수는 외국인이다.
# 동일 색상으로 그룹화 표시
corrgram( crime )
# 범죄_동일 색상으로 그룹화 표시.png
# 위쪽에 상관 계수 추가

corrgram( crime, upper.panel=panel.conf )
# 범죄_위쪽에 상관 계수 추가.png

# 아래 쪽에 상관 계수 추가
corrgram( crime, lower.panel=panel.conf )
# 범죄_아래 쪽에 상관 계수 추가.png