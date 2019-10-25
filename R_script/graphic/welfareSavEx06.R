# 지역별 연령대 비율 

library(ggplot2)

welfare <- read.csv('welfare.csv')
welfare$code_region

# 지역구분
mRegion <- c('서울', '수도권(인천/경기)', '부산/경남/울산', '대구/경북', '대전/충남', '강원/충북', '광주/전남/전북/제주도')

list_reg <- data.frame(code_region = c(1:7), region = mRegion)
list_reg

welfare <- left_join(welfare, list_reg, id = 'code_region')
welfare

welfare$age <- 2015 - welfare$birth + 1
welfare <- welfare %>% mutate(age_group = ifelse(age < 30, 'young', ifelse(age < 60, 'mid', 'old')))

# 지역별 / 연령별 그룹핑하여 빈도수 비율
reg_age_group <- welfare %>% group_by(region, age_group) %>% summarise(cnt = n()) %>% mutate(tot_group = sum(cnt)) %>% mutate(pct = round(100 * cnt / tot_group, 1))
reg_age_group

# geom col함수의 position 옵션 ~ dodge, dodge2 옵션
## dodge : bar 간격을 붙여 보여줌 
## dodge2 : bar 간격을 떼어줌
ggplot(data = reg_age_group, aes(x = region, y = pct, fill = age_group)) + geom_col(position = 'dodge2') + coord_flip() + theme_minimal(base_family = 'AppleGothic')
