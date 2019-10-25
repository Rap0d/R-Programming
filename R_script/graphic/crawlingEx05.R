library(rJava)
library(KoNLP)
library(stringr)
library(dplyr)
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(wordcloud2)

# font_import()
theme_set(theme_gray(base_family = 'D2Coding'))

cleaner <- function(x) {
  # res <- str_extract_all(x, '\\w{2,}')
  res <- str_replace_all(x, '\\W', ' ')
  return(res)
}

setwd('R Basic Source/12.워드 클라우드/워드클라우드(국정원)/')

twit <- read.csv('twitter.csv', header = T, fileEncoding = 'UTF-8')
twit

colnames(twit) <- c('x', 'no', 'id', 'regdate', 'contents')
head(twit)

head(twit$contents)

twit$contents <- cleaner(twit$contents)
twit$contents

# 명사 추출
buildDictionary(ext_dic = c('sejong', 'woorimalsam'))
nouns <- extractNoun(twit$contents)
# nounsS <- SimplePos22(twit$contents)
# nounsM <- MorphAnalyzer(twit$contents)
nounsM


# nouns 는 리스트로 반환되므로 unlist로 벡터화 시킨다.
wordcount <- table(unlist(nouns))

newFrame <- as.data.frame(wordcount, stringaAsFactor = F)
newFrame

newFrame <- rename(newFrame, word = Var1, freq = Freq)
colnames(newFrame)

# 음절이 2글자 이상인 단어만 추출
class(newFrame$word)
newFrame$word <- as.vector(newFrame$word)
newFrame <- filter(newFrame, nchar(word) >= 2)
newFrame

top20 <- newFrame %>% arrange(desc(freq)) %>% head(20)
top20

ordering <- arrange(top20, freq)$word
ordering

# ggplot 사용 옵션 확인
# aes : aesthetics
## fill, color옵션이 색상을 결정
# geom_col : 막대 그래프를 그려주는 옵션
## 기본 값으로 누적된 그래프를 그려주며 요약된 표를 이용하여 막대그래프를 그릴때 사용
# coord_flip() : horiz 옵션과 동일
# theme_bw(base_family = 'D2Coding') : 폰트 문제 해결
## theme 은 다양함
# scale_x_discrete(limit = ordering) : 내림차순
ggplot(data = top20, aes(x = word, y = freq, fill = word, color = word)) + ylim(0, max(top20$freq + 100)) + geom_col() + coord_flip() + scale_x_discrete(limit = ordering) + geom_text(aes(label = freq), hjust = -0.3) + theme_bw(base_family = 'D2Coding')

# 색상 팔레트
## 팔레트를 불러와서 슬라이싱 가능
display.brewer.all()
pallette1 <- brewer.pal(8, 'Dark2')
pallette2 <- brewer.pal(9, 'Blues')[5:9]

top100 <- newFrame %>% arrange(desc(freq)) %>% head(100)
wordcloud2(top100, fontFamily = 'D2Coding', rotateRatio = 0, shuffle = T, size = 1.5, color = pallette2)

