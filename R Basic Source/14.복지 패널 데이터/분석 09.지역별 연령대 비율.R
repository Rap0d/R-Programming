# 분석 09 : 지역별 연령대 비율
str(welfare)
table(welfare$code_region)

myregion <- c('서울','수도권','경상남도','경상북도','전라남도','전라북도','경기도')
list_region <- data.frame(code_region=c(1:7), region=myregion)

list_region

welfare <- left_join(welfare, list_region, id='code_region')
str(welfare)
welfare$region

welfare %>% select(code_region, region) %>% head(20)

# 지역별, 년령대 별로 그룹화하여 빈도수와 비율을 구하시오
# 비율은 해당 지역에 대하여 해당 년령대의 비율이다.
region_ageg <- welfare %>% group_by(region, ageg) %>% 
                    summarise(cnt = n()) %>% 
                    mutate(tot_group=sum(cnt)) %>% 
                    mutate(pct = round(100 * cnt/tot_group, 1))
region_ageg

32.4 + 42.2 +25.4

ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg)) + geom_col() + coord_flip()

ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg)) + geom_col(position='dodge') + coord_flip()

# 지역별 old의 비율 그래프(old만 보여 주기)
list_order_old <- region_ageg %>% filter(ageg=='old') %>% arrange(pct) %>% select(region, pct)

list_order_old

ggplot(data=list_order_old, aes(x=reorder(region, pct), y=pct, fill=region, colour=region)) + geom_col() + coord_flip()