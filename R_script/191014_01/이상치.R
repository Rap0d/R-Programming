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

