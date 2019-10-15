# 분석 07 : 성별 직업 빈도

# 남성 직업 빈도 상위 10개
# 빈도 수는 n() 함수를 사용하면 된다.
job_male <- welfare %>% filter(!is.na(job) & gender=='male') %>% 
    group_by(job) %>% summarise(cnt = n()) %>% 
    arrange(desc(cnt)) %>% head(10)

job_male

# 남성 직업 빈도 상위 10개.png
ggplot(data=job_male, aes(x=reorder(job, cnt), y=cnt)) + geom_col() + coord_flip()

# 여성 직업 빈도 상위 10개
job_female <- welfare %>% filter(!is.na(job) & gender=='female') %>% 
      group_by(job) %>% summarise(cnt = n()) %>% 
      arrange(desc(cnt)) %>% head(10)

job_female

# 여성 직업 빈도 상위 10개.png
ggplot(data=job_female, aes(x=reorder(job, cnt), y=cnt)) + 
    geom_col() + coord_flip()