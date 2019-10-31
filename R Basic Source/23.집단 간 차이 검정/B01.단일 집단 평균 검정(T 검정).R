# 연구 환경
# 국내에서 생산된 노트북 평균 사용 시간이 5.2시간이다.
# A회사에서 생산된 노트북 평균 사용 시간과 차이가 있는 지를 검정하기 위해서 
# A회사의 노트북 150대를 랜덤으로 선정하여 검정을 실시해보도록 한다.
# 
# 귀무 가설 : 국내에서 생산된 노트북과 A회사에서 생산된 노트북의 평균 사용 시간에 차이가 없다. 

# 단일 표본의 평균 계산하기
data <- read.csv('one_sample.csv', header=T)
str(data)

# time 컬럼 : 사용 시간
x <- data$time

# 데이터 분포/결측치 제거하기
head(x)
range(x) # 결측치 때문에 파악 안됨
summary(x) # 결측치가 41개이다.

# 데이터 정제 후 평균에 대한 통계치를 계산해본다.
mean(x, na.rm=T) # NA 제외 평균(방법1)
# [1] 5.556881

x1 <- na.omit( x ) # NA 제외 평균(방법2)
mean(x1) # [1] 5.556881

library(stats)

# shapiro 테스트의 귀무 가설은 "x1의 데이터 분포는 정규 분포이다."이다.
shapiro.test(x1)
#         Shapiro-Wilk normality test
# 
# data:  x1
# W = 0.99137, p-value = 0.7242

0.7242 > 0.05 # TRUE
# 연산 결과가 TRUE이므로 귀무 가설 채택
# p-value > 0.05이므로 귀무 가설을 채택한다.
# 이 데이터는 정규 분포를 따른다고 볼 수 있다.


# 시각화를 이용하여 정규 분포 인지를 개략적으로 확인할 수 있다.
hist(x1)
# savePlot('x1 변량의 히스토그램.png', type='png')


# 정규성 가정이 만족되는지 그래프로 확인해보기
# Q-Q plot 그래프에서 대각선 참조선을 따라서 값들이 분포하게 되면 정규성을 만족한다고 할 수 있다. 만약 한 쪽으로 치우치는 모습이라면 정규성 가정에 위배되었다고 본다.
# 하지만 사람마다 그래프가 치우쳤다는 것에 대한 기준이 다르기 때문에 결과 해석이 굉장히 주관적이다.

# x 축은 표준 정규 분포의 quantile
# y 축은 샘플 데이터(여기서 x1)의 quantile
qqnorm(x1) # 정규 분포의 QQ Plot 그리기
qqline(x1, lty=1, col='blue') # 정규 분포의 Q1과 Q3을 연결해주는 직선 그리기
# savePlot('정규 분포 시각화.png', type='png')

# 평균 차이 검정
# 양측 검정 : x1 객체와 기존 모집단의 평균 5.2시간 비교하기
t.test(x1, mu=5.2)
#         One Sample t-test
# 
# data:  x1
# t = 3.9461, df = 108, p-value = 0.0001417
# alternative hypothesis: true mean is not equal to 5.2
# 95 percent confidence interval:
#  5.377613 5.736148
# sample estimates:
# mean of x 
# 5.556881

# 결과를 보면 95%의 신뢰 수준에서 신뢰 구간은 5.377613 ~ 5.736148이다.
# 평균은 5.556881이다. <- 우리는 5.2라고 물어 보았었다.
# p-value < 0.05 이므로, 귀무 가설을 기각한다.
# 따라서, 국내에서 생산된 노트북과 A회사에서 생산된 노트북의 평균 사용 시간에 차이가 있다.라고 볼 수 있다.


# 방향성을 갖는 연구 가설 검정 
t.test(x1, mu=5.2, alter='greater', conf.level=0.95)
#         One Sample t-test
# 
# data:  x1
# t = 3.9461, df = 108, p-value = 7.083e-05
# alternative hypothesis: true mean is greater than 5.2
# 95 percent confidence interval:
#  5.406833      Inf
# sample estimates:
# mean of x 
# 5.556881

7.083e-05 < 0.05
# p-value < 0.05 이므로, 귀무 가설을 기각한다.
# A회사에서 생산된 노트북의 평균 사용 시간이 국내에서 생산된 노트북 사용 시간보다 더 길다고 할 수 있다.

# 귀무 가설에 대한 임계 값
# stats 패키지의 qt() 함수를 사용하면 된다.
# qt(p-value, df)
qt(7.083e-05, 108)
# [1] -3.946073
# t 검정 통계량이 절대값 3.946073 보다 크기 때문에 귀무 가설을 기각할 수 있다.

# T 검정 변수 보기
# result 변수에 저장된 컬럼 이름들을 확인한 뒤 각 컬럼에 저장된 T-검정 관련 정보를 확인할 수 있다.
tresult <- t.test(x1, mu=5.2, alter='greater', conf.level=0.95)
names(tresult)

tresult <- t.test(x1, mu=5.2)
names(tresult)

if( tresult$p.value > 0.05 ){
  cat('귀무가설 채택')
}else{
  cat('귀무가설 기각')
}
tresult$parameter # 자유도
tresult$conf.int # 신뢰 구간