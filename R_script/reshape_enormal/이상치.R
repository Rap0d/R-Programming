# 성별 : 1, 2
# 점수 : 1 ~ 5

# 이상치 : 표현하고자 하는 범주 바깥의 존재할 수 없는 값 

gender <- c(1, 2, 3, 1, 2, 1, 2)
score <- c(2, 3, 1, 5, 2, 20, 4)

outlier <- data.frame(gender = gender, score = score)
outlier

sort(unique(outlier$gender))
sort(unique(outlier$score))

table(outlier$gender)

# gender에서 1, 2가 아닌 값이면 NA로 치환
outlier$gender <- ifelse(outlier$gender != 1 & outlier$gender != 2, NA, outlier$gender)
outlier

# useNA = 'ifany' : NA 보기
table(outlier$gender, useNA = 'ifany')

# score에서 1~5가 아닌 값이면 NA로 치환
# condition의 값을 별도로 둘 수 있음 
cond <- outlier$score < 1 | outlier$score > 5 # T or F
outlier$score <- ifelse(cond, NA, outlier$score)
outlier

# useNA = 'ifany' : NA 보기
table(outlier$score, useNA = 'ifany')

library(dplyr)

# NA값 필터링 후 평균값 구하기 
outlier %>% filter(!is.na(gender) & !is.na(score)) %>% group_by(gender) %>% summarise(mean_score = mean(score))
# # A tibble: 2 x 2
# gender  mean_score
# <dbl>      <dbl>
#     1        3.5
#     2        3  

# boxplot : 데이터의 분포를 볼 수 있음
boxplot(score)

## ggplot2 에서 제공하는 데이터 셋을 이용한 이상치 확인
library(ggplot2)

str(mpg)
range(mpg$hwy)
sort(unique(mpg$hwy))

mybox <- boxplot(mpg$hwy)
attributes(mybox)

# stats : Dataframe의 통계 정보를 알려준다. 
mybox$stats

sort(mpg$hwy)
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

table(is.na(mpg$hwy))

# drv : 자동차 구동 방식
res <- mpg %>%  group_by(drv) %>% summarise(mean_hwy = mean(hwy, na.rm = T))
res                                            
