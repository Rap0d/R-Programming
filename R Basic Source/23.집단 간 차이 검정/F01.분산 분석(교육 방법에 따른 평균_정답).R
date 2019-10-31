mydata = read.csv("three_sample.csv", header=TRUE)
head(mydata)

range(mydata$score)

# 데이터 정제/전처리 - NA, outline 제거
mydata = subset(mydata, !is.na(score), c(method, score))
head(mydata)     # method, score

plot(mydata$score) # 50 이상의 ontlier 발견
# 분산 분석(산점도_before).png

boxplot(mydata$score) # ontlier 확인

barplot(mydata$score)
# 분산 분석(막대 그래프).png

mean(mydata$score) # 14.45

sort(mydata$score)

# outlier 제거 - 평균(14) 이상 제거
length(mydata$score) # 91
mydata2 = subset(mydata, score <= 10) 
length(mydata2$score) # 88(3개 제거)

# 정제된 데이터 보기
x = mydata2$score

# 박스 차트에서 정제된 데이터 확인하기
boxplot(x)
# 분산 분석(박스 차트).png

plot(x)
# 분산 분석(산점도_after).png

# 세 집단 subset 작성하기
# method: 1:방법1, 2:방법2, 3:방법3
mydata2$method2[mydata2$method==1] = "방법1"
mydata2$method2[mydata2$method==2] = "방법2"
mydata2$method2[mydata2$method==3] = "방법3"

# 교육 방법 별 빈도 수를 구해 본다.
table(mydata2$method2)
# 방법1 방법2 방법3
#    31    27    30

# 교육 방법을 변수 x에 저장
x <- table(mydata2$method2)

# 교육 방법에 따른 시험 성적 평균 구하기
y <- tapply(mydata2$score, mydata2$method2, mean)
y
#    방법1    방법2    방법3
# 4.187097 6.800000 5.610000

df <- data.frame(교육방법=x, 성적=y)
df
#       교육방법.Var1 교육방법.Freq     성적
# 방법1         방법1            31 4.187097
# 방법2         방법2            27 6.800000
# 방법3         방법3            30 5.610000

# 분산 분석의 동질성 검정은 bartlett.test() 함수를 사용한다.
# bartlett.test(종속변수 ~ 독립변수, data=dataSet)
bartlett.test(score ~ method2, data=mydata2)
#         Bartlett test of homogeneity of variances
#
# data:  score by method2
# Bartlett's K-squared = 3.3157, df = 2, p-value = 0.1905

# p-value = 0.1905 > 0.05이므로 귀무가설을 채택한다.
# 즉, 세 집단의 분포 형태가 동질하다고 볼 수 있다.

# 동질한 경우 : aov() - Analysis of Variance(분산 분석)
# 동질하지 않은 경우 - kruskal.test()

# 분산 검정(집단이 3개인 경우 분산분석이라고 함)
# aov(종속변수 ~ 독립변수, df_data=df_data set)

# 귀무가설 : 세 집단의 평균에 차이가 없다.
result = aov(score ~ method2, data=mydata2)
names(result)

# aov()의 결과값은 summary()함수를 사용해야 p-value 확인
summary(result)
#             Df Sum Sq Mean Sq F value   Pr(>F)
# method2      2  99.37   49.68   43.58 9.39e-14 ***
# Residuals   85  96.90    1.14
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’

# p-value = 9.39e-14 < 0.05이므로 귀무 가설을 기각한다.
# 즉, 교육 방법에 따른 세 집단 간 실기 시험의 평균에 차이가 있다.

# F 검정 통계량으로 가설 검정
# 신뢰 수준 95%에서의 표준화 변수의 값은 1.96이다.
# F 검정 통계량 43.58은 ±1.96 보다 크기 때문에 귀무 가설을 기각한다.

# 사후검정
thsd <- TukeyHSD( result )
thsd$method2
#              diff      lwr        upr       p adj
# 방법2-방법1  2.612903  1.9424342  3.2833723 2.084165e-10
# 방법3-방법1  1.422903  0.7705979  2.0752085 3.976611e-06
# 방법3-방법2 -1.190000 -1.8656509 -0.5143491 1.910760e-04

# 방법2-방법1
6.800000 - 4.187097 

plot(thsd)

# 분산 분석의 사후 검정(Post Hoc Tests)은 분산 분석에서
# '3가지 교육 방법에 따른 실기시험의 평균에 차이가 있다.'라는
# 결론을 내렸다면 구체적으로 어떤 교육 방법 간에 차이가 있는지는 보여주는
# 부분이다.
# 여기서 방법2와 방법1의 집단 간 평균의 차(diff)가 가장 큰 것으로 나타났다.

# 분산 분석의 사후 검정.png