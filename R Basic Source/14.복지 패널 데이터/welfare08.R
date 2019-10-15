filename = 'welfare.csv'
welfare <- read.csv(filename, header=T)

table(welfare$religion)

welfare$religion_txt <- ifelse(welfare$religion == 1, 'yes', 'no')
tbl <- table(welfare$religion_txt)

df <- as.data.frame(tbl)
head(df)
colnames(df) <- c('종교유무', '빈도수')

ggplot(data=df, aes(x=종교유무, y=빈도수, color=종교유무, fill=종교유무)) + geom_bar(stat='identity')

# 이혼 여부
table(welfare$marriage)

# 1과 3이외에는 NA로 처리

welfare$group_marriage <- ifelse(welfare$marriage==1, 'marriage', ifelse(welfare$marriage==3, 'divorce', NA))

length(welfare$group_marriage)
unique(welfare$group_marriage)
table(welfare$group_marriage, useNA='always')

chartdata <- as.data.frame(table(welfare$group_marriage))
colnames(chartdata) <- c('결혼유무', '빈도수')
ggplot(data=chartdata, aes(x=결혼유무, y=빈도수, fill=결혼유무, color=결혼유무)) + geom_bar(stat='identity') + labs(title='결혼 유무별 빈도수')

# 종교와 결혼 유무에 대한 비율 
# tot_group : 종교 그룹 내의 총합
# pct : 종교 그룹 내에서의 총합 이혼 유무에 대한 비율
religion_marriage <- welfare %>% filter(!is.na(group_marriage)) %>% group_by(religion_txt, group_marriage) %>% summarise(cnt=n()) %>% mutate(tot_group=sum(cnt)) %>% mutate(pct=round(100 * cnt/tot_group, 1))

religion_marriage

# 종교 유무별 이혼의 비율 추출
divorce <- religion_marriage %>% filter(group_marriage=='divorce') %>% select(religion_txt, pct)

divorce

ggplot(data=divorce, aes(x=religion_txt, y=pct, color=religion_txt, fill=religion_txt)) + geom_col() + scale_x_discrete(limits=c('yes', 'no')) + labs(x='종교', y='비율', title='종교 유무별 이혼 비율')


