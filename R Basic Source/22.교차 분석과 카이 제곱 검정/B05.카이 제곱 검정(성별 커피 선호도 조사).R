# 남여 각 20명에 대하여 커피 브랜드 A, B, C 사의 선호도를 조사했다고 가정하자.
# 이 선호도를 이용하여 카이 제곱 검증을 해보도록 한다.

# 1번 엑셀 파일에 대한 카이 제곱 검증 테스트

# 귀무 가설 : 성별에 따라서 선호하는 커피의 차이가 없다.

# 데이터 파일 로딩
chisq01 <- read.csv("카이제곱검정01.csv", header=T)

str(chisq01)

table(chisq01$gender)
# 남자 여자 
#   20   20 

table(chisq01$brand)
#  A  B  C 
# 12 13 15 

mytable <- table( gender=chisq01$gender, brand=chisq01$brand)
mytable 
#       brand
# gender A B C
#   남자 6 6 8
#   여자 6 7 7

# 분할표가 만들어 졌으면, chisq.test()를 이용하여 카이 제곱 검정을 수행할 수 있다.
chisq.test( mytable ) 
# Pearson's Chi-squared test
# 
# data:  mytable
# X-squared = 0.14359, df = 2, p-value = 0.9307

# p-value(0.9307) > 0.05 이므로 귀무 가설을 채택한다.
# 그러므로, 성별에 따라서 선호하는 커피의 차이가 없다.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 2번 엑셀 파일에 대한 카이 제곱 검증 테스트
# 데이터 파일 로딩
chisq02 <- read.csv("카이제곱검정02.csv", header=T)

str(chisq02)

table(chisq02$gender)
# 남자 여자 
#   20   20 

table(chisq02$brand)
#  A  B  C 
# 22  8 10 

mytable02 <- table( gender=chisq02$gender, brand=chisq02$brand)
mytable02
#       brand
# gender  A  B  C
#   남자  6  6  8
#   여자 16 2 2

# 분할표가 만들어 졌으면, chisq.test()를 이용하여 카이 제곱 검정을 수행할 수 있다.
# 다음 문장은 동일한 결과를 출력해 준다.
chisq.test( mytable02 )
# Pearson's Chi-squared test
# 
# data:  mytable02
# X-squared = 10.145, df = 2, p-value = 0.006265
# 
# Warning message:
# In chisq.test(mytable02) :
# 카이제곱 approximation은 정확하지 않을수도 있습니다

# 피셔의 정확 검증
# 카이 제곱 검정이 정확하지 않는 경우 경고 메시지가 나온다.
# 보통 데이터의 표본 수가 매우 적거나, 데이터가 한쪽으로 쏠림 현상이 있는 경우에 발생한다.
# 이럴 경우에는 피셔의 검증 방법(fisher.test() 함수)을 사용하면 된다.

fisher.test( mytable02 ) 
#         Fisher's Exact Test for Count Data
# 
# data:  mytable02
# p-value = 0.007716
# alternative hypothesis: two.sided