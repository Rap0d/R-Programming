# install.packages("dplyr")
library(ggplot2)
library(class) # knn 함수가 들어 있는 패키지
library(dplyr)

# 3장 : 과일 데이터 Knn
food <- read.csv('food_list.csv', header=T)
food

# 토마토 데이터 만들기
tomato <- data.frame(ingredient = "tomato", sweetness = 6, crunchiness = 4)
tomato

# 그래프 그리기(version : ggplot2)
ggplot(data=food,aes(x=sweetness,y=crunchiness)) + labs(title="What is tomato class?", subtitle = "토마토는 어디에 속할까요?", caption="3가지 카테고리로 분류된 데이터 분포입니다") + theme(plot.title = element_text(hjust=0.5)) + geom_point(aes(color=class, shape=class), size=6) + geom_text(aes(label=ingredient), vjust=-1, size = 5) + xlim(0, 11) + ylim(0, 12)

# k=1로 토마토를 예측해보기
tmt <- knn(select(food, sweetness, crunchiness), select(tomato, sweetness, crunchiness), food$class, k=1)
tmt

# 데이터프레임 만들기
# 포도, 완두콩, 오렌지, 토마토를 통해서 예측하기
unknown <- data.frame(ingredient = c("grape", "green bean", "orange", "tomato"), sweetness = c(8, 3, 7, 6), crunchiness = c(5, 7, 3, 4))
unknown

# 포도, 완두콩, 오렌지, 토마토를 통해서 k=3으로 예측해보기
prediction <- knn(select(food, sweetness, crunchiness), select(unknown,sweetness, crunchiness),  food$class, k=3)
prediction
