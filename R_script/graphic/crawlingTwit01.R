# install.packages('twitteR')
library(twitteR)
library(stringr)

# API 인증을 위한 변수 목록 셋팅
apiKey <-  "FpsU8XFv3ay94i8VkpLF3d1an" 
apiSecret <- "NKmcD0sAHq68t9goETyD4KQovkM0USIdB5HWrtOJHL1MTSnZ3s" 
accessToken="231983354-W0eaMyHM3D1YbYRZMvLcBaS2nz0hpgXw7fzfxmiY"
accessTokenSecret="Tuf563H6Iz0xwATMdDiGnimvDXgrZcIntugtmPmJ4cq67"

setup_twitter_oauth(consumer_key = apiKey, consumer_secret = apiSecret, access_token = accessToken, access_secret = accessTokenSecret)

# [1] "Using direct authentication"
# Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?
# 의 형식으로 물어 보는 데, 로컬 캐싱 내용을 사용할 것인가를 물어 보는 것이다.
# 2를 눌러서 새로운 인증을 시도로 하도록 한다.

searchWord <- 'London'
keyword <- enc2utf8( searchWord ) # base 패키지에 있음(인코딩 함수)
keyword

# Warning message:
#   In doRppAPICall("search/tweets", n, params = params, retryOnRateLimit = retryOnRateLimit,  :
#                     300 tweets were requested but the API can only return 42
searchResult <- searchTwitter(searchString = keyword, n = 300, lang = 'ko') #300개

class(searchResult) # "list"

tw_result <- twListToDF(searchResult)
head(tw_result, 2)

str(tw_result)

# 저장할 파일 이름
filename = paste('twitter(', searchWord ,').txt', sep='')
write.csv(tw_result, filename, quote = F, row.names = F)

# 텍스트, 생성횟수, 리트윗 횟수, 위치 정보 등등
colnames(tw_result)

bigdata_text <- tw_result$text
head(bigdata_text)

# install.packages('KoNLP')
library(KoNLP)
useSejongDic()
# buildDictionary(ext_dic = c('sejong', 'woorimalsam'))

# 명사 추출 후 list를 vector으로 변환한다.
bigdata_noun <- sapply(bigdata_text, extractNoun, USE.NAMES = F)
bigdata_noun <- unlist(bigdata_noun)
bigdata_noun
length(bigdata_noun)

# 2글자 이상만 추출하기
bigdata_noun <- Filter(function(x){ nchar(x) >= 2}, bigdata_noun)

# 참고로 gsub 대신에 정규 표현식을 사용해도 된다.
# bigdata_noun <- gsub('[A-Za-z0-9]', '', bigdata_noun) # 영어와 숫자 제거
# bigdata_noun <- gsub('[~!@#$%^&*()/_+|?:;]', '', bigdata_noun) # 특수 문자 제거
# bigdata_noun <- gsub('[ㄱ-ㅎ]', '', bigdata_noun) # 자음 제거
# bigdata_noun <- gsub('[ㅜ|ㅠ]', '', bigdata_noun) #1개 이상의 ㅜ와 ㅠ를 제거
bigdata_noun <- str_extract(bigdata_noun, '[A-z]{3,}')
bigdata_noun <- gsub(keyword, '', bigdata_noun) # keyword 제거

word_table <- table(bigdata_noun)
tmp <- sort(word_table, decreasing = T)
# for (idx in 1:6) {
#   if(tmp[idx] > 200) {
#     tmp[idx] <- tmp[idx] - 100
#   } else {
#     tmp[idx] <- tmp[idx] - 30
#   }
# }
head(tmp)
word_table <- sort(tmp, decreasing = T)

# install.packages('wordcloud2')
library(wordcloud2)

wordcloud2(data = tmp, fontFamily = 'Nanum Gothic', size = 10, color = 'random-light', backgroundColor = 'black') + WCtheme(1)

