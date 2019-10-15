# 분석 08 : 종교 유무에 따른 이혼율
class(welfare$religion)
table(welfare$religion)

# 코드 북 참조 : 1(종교 있음), 2(없음), 9(모름/무응답)
welfare$religion_txt <- ifelse(welfare$religion == 1, 'yes', 'no')
table(welfare$religion_txt)
# no  yes
# 8617 8047

tbl <- table(welfare$religion_txt)

df <- as.data.frame(tbl)
head(df)
colnames(df) <- c('종교유무', '빈도수')

# 종교 유무 빈도.png
ggplot(data=df, aes(x=종교유무, y=빈도수, color=종교유무, fill=종교유무)) + geom_bar(stat='identity')


# 이혼 여부 관련 변수 만들기
class(welfare$marriage)
table(welfare$marriage)

# 이혼 여부 코드 북 참조하여 전처리
# 값 : 1(marriage), 3(divorce), 이외는 NA으로 처리
welfare$group_marriage <- ifelse( welfare$marriage == 1, 'marriage', ifelse( welfare$marriage == 3, 'divorce', NA))

welfare$group_marriage <- ifelse(welfare$marriage==1, 'marriage', ifelse(welfare$marriage==3, 'divorce', NA))

length(welfare$group_marriage)
unique(welfare$group_marriage)
str(welfare)
head(welfare$group_marriage, 10)

table(welfare$group_marriage, useNA='always')
# divorce marriage
# 712     8431

table(is.na(welfare$group_marriage))
# divorce marriage  <NA> 
# 712    8431     7521 

712 + 8431 # 9143

# 혼인 상태 여부.png
mydata <- factor(welfare$group_marriage)
qplot(welfare$group_marriage, fill=mydata, color=mydata)

# 결혼 유무(결측치 제외)에 따라서 [종교 유무, 이혼 유무] 상태로 그룹핑한다.
# 빈도수 구하기
# tot_group : 종교 그룹 내의 총합
# pct : 종교 그룹 내에서의 이혼 유뮤에 대한 비율
religion_marriage <- welfare %>% filter(!is.na(group_marriage)) %>% 
      group_by(religion_txt, group_marriage) %>% 
      summarise(cnt = n()) %>% mutate(tot_group=sum(cnt)) %>% 
      mutate(pct = round(100 * cnt/tot_group, 1))

religion_marriage

4213 / 4541

# 종교 유무별 이혼의 비율 추출
divorce <- religion_marriage %>% 
      filter(group_marriage == 'divorce') %>% 
      select(religion_txt, pct)

divorce
# religion   pct
# no         8.3
# yes        7.2

# 이혼율 표.png
ggplot(data=divorce, aes(x=religion_txt, y=pct, fill=divorce$religion_txt)) + geom_col()

# 년령대, 이혼 유무에 따라서 그룹핑
ageg_marriage <- welfare %>% 
    filter(!is.na(group_marriage)) %>% 
    group_by(ageg, group_marriage) %>% 
    summarise(cnt = n()) %>% 
    mutate(tot_group=sum(cnt)) %>% 
    mutate(pct = round(100 * cnt/tot_group, 1))

ageg_marriage

# young 그룹은 제외하고, 이혼한 항목만 추출하기
ageg_divorce <- ageg_marriage %>% filter( ageg != 'young' & group_marriage == 'divorce') %>% select(ageg, pct)

ageg_divorce
# ageg     pct
#     1 middle   8.9
# 2 old      6.6

# 연령대별 이혼율(초년 제외).png
ggplot(data=ageg_divorce, aes(x=ageg, y=pct, fill=divorce$religion_txt)) + geom_col()

# 연령대, 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
    filter(!is.na(group_marriage) & ageg != "young") %>%
    group_by(ageg, religion, group_marriage) %>%
    summarise(n = n()) %>%
    mutate(tot_group = sum(n)) %>%
    mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

ageg_religion_marriage <- welfare %>%
    filter(!is.na(group_marriage) & ageg != "young") %>%
    count(ageg, religion_txt, group_marriage) %>%
    group_by(ageg, religion_txt) %>%
    mutate(pct = round(n/sum(n)*100, 1))

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>%
    filter(group_marriage == "divorce") %>%
    select(ageg, religion_txt, pct)

df_divorce

# 연령대별 종교 유무에 따른 이혼율.png
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion_txt )) + 
    geom_col(position = "dodge2")