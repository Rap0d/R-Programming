# install.packages('party')
library(party)  

str(airquality)

# formula 생성 : Y변수 연속형
myformula = Temp ~ Solar.R + Wind + Ozone # 포물러 작성
 
# 분류 모델을 생성한다(formula를 이용)
air_ctree = ctree(formula=myformula, data=airquality)
mode(air_ctree)
class(air_ctree) # BinaryTree

air_ctree

plot(air_ctree) # y변수 연속형 : boxplot
# 의사 결정 트리 시각화.png

# <해설> 
# 온도에 가장 큰 영향을 미치는 첫 번째 영향 변수는 오존 수치(Ozone)이고, 
# 두 번째 영향 변수는 바람(Wind)으로 나타난다.