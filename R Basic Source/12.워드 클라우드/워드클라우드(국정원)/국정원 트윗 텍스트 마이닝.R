# 데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T, stringsAsFactors = F, fileEncoding = "UTF-8")

library(dplyr)

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호, id = 계정이름,
                  regdate = 작성일, contents = 내용)

library(stringr)
# 특수 문자들을 제거한다.
twitter$contents <- str_replace_all(twitter$contents, "\\W", " ")
head(twitter$contents)

library(KoNLP)
# 트윗에서 명사를 추출한다. (시간이 약간 걸린다.)
nouns <- extractNoun(twitter$contents)

# 명사 list를 문자열 벡터로 변환시켜, 단어별 빈도 표를 생성한다.
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환시킨다.
newframe <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명을 적절한 이름으로 변경한다.
newframe <- rename(newframe, word = Var1, freq = Freq)

# 음절이 두 글자 이상 단어만 추출하도록 한다.
newframe <- filter(newframe, nchar(word) >= 2)

# 상위 20개 추출
top20 <- newframe %>%
  arrange(desc(freq)) %>% head(20)

top20

order <- arrange(top20, freq)$word

library(ggplot2)
ggplot(data = top20, aes(x = word, y = freq, fill=word, color=word)) +  
  ylim(0, max(top20$freq) + 100) + geom_col() + coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3) # 빈도 표시

library(RColorBrewer)
palette <- brewer.pal(8,"Dark2") # 색상 목록 생성
# palette <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성

set.seed(1234) # 난수 고정

library(wordcloud)

wordcloud(words = newframe$word,    # 단어
          freq = newframe$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = palette)            # 색상 목록

# library(wordcloud2)
# word_table <- table(newframe$word)
# wordcloud2(word_table, fontFamily = '맑은 고딕', size = 4, color = 'random-light', backgroundColor = 'black')