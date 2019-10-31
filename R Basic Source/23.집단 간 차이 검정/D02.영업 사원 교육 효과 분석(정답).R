# 귀무 가설 : 영업 사원들의 실적을 향상 시키기 위한 
# 집체 교육과 멘토링 교육 방법에는 차이가 없다.

mymethod <- read.csv('mymethod.csv', header=TRUE)
head(mymethod)

str(mymethod)
# 'data.frame':	63 obs. of  3 variables:
# $ id         : int  1 2 3 4 5 6 7 8 9 10 ...
# $ method     : int  1 1 1 1 1 1 1 1 1 1 ...
# $ performance: int  27 5 21 99 14 23 20 9 28 15 ...

dim(mymethod) # 63  3

# method : 영업 역량 강화(1 : 집체 교육, 2 : 멘토링 교육)
unique(mymethod$method ) # [1] 1 2
mymethod$method

mymethod$performance # performance(영업 실적)

# 전처리 하기
# 입사 6개월 이내 인력은 performance의 값이 99인데 점검 사항에서 배제하도록 한다.
# 집체 교육(method == 1), 멘토링 교육(method == 2)
groupa <- subset(mymethod, method == 1 & performance < 99)
groupa
groupb <- subset(mymethod, method == 2 & performance < 99)
groupb

groupAcount <- length(groupa$method)
groupAmean <- round(mean(groupa$performance), 2)
groupAcount # 22
groupAmean # 16.41

groupBcount <- length(groupb$method)
groupBmean <- round(mean(groupb$performance), 2)
groupBcount # 35
groupBmean # 29.23

groupcount <- c(groupAcount, groupBcount)
groupmean <- c(groupAmean, groupBmean)
groupcount # 22 35
groupmean # 16.41 29.23

# grouptable : 그룹의 빈도 수와 평균 값을 저장하고 있는 data frame
grouptable <- data.frame(GrpFreq=groupcount, GrpMean=groupmean)
grouptable
# GrpFreq GrpMean
# 1      22   16.41
# 2      35   29.23

# 분석 데이터가 정규 분포를 이루는 지 검정한다.
# yes이면 t-test를, no이면 wilcox.test 분석을 수행하면 된다.
var.test(groupa$performance, groupb$performance)
#         F test to compare two variances
#
# data:  groupa$performance and groupb$performance
# F = 1.0648, num df = 21, denom df = 34, p-value = 0.8494
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#  0.502791 2.427170
# sample estimates:
# ratio of variances
# 1.06479

# p-value = 0.8494 > 0.05 보다 크므로 분포의 형태가 동질하다.
# 즉, t.test()를 이용하여 모집단의 평균 값을 검정해야 한다.

# 양측 검정
t.test(groupa$method, groupb$performance, alter='two.sided', conf.int=TRUE, conf.level=0.95)
# Welch Two Sample t-test
#
# data:  groupa$method and groupb$performance
# t = -20.26, df = 34, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#     -31.06012 -25.39702
# sample estimates:
#     mean of x mean of y
# 1.00000  29.22857

# p-value < 2.2e-16 < 0.05 보다 작으므로 귀무 가설을 기각한다.
# 영업 사원들의 실적을 향상 시키기 위한 집체 교육과 멘토링 교육 방법에는 차이가 있다.

help(t.test)
# 단측 검정
t.test(groupa$method, groupb$performance, alter='greater', conf.int=TRUE, conf.level=0.95)

# Welch Two Sample t-test
#
# data:  groupa$method and groupb$performance
# t = -20.26, df = 34, p-value = 1
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     -30.58456       Inf
# sample estimates:
#     mean of x mean of y
# 1.00000  29.22857
# p-value = 1 > 0.05 보다 크므로 귀무 가설을 채택한다.

t.test(groupa$performance, groupb$method, alter='greater', conf.int=TRUE, conf.level=0.95)
