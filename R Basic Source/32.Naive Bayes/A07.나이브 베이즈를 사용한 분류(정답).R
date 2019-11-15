smsdata <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)
colnames(smsdata)
dim(smsdata)#  5559    2

# type : 메일의 종류(햄/스팸), text : 메일의 내용
str(smsdata) # 5559 obs. of  2 variables:

# 문자열 벡터를 Factor 형으로 변환하기
smsdata$type <- factor(smsdata$type)
str(smsdata$type)

unique(smsdata$type)
# [1] ham  spam
# Levels: ham spam

table(smsdata$type)
# ham spam
# 4812  747

# 텍스트 마이닝(tm) 패키지를 사용하여 말뭉치(Corpus) 생성
library(tm)
vecsrc <- VectorSource(smsdata$text) # text -> vector
corpus <- Corpus( vecsrc ) # vector -> corpus

# 말뭉치(corpus) : 텍스트 문서의 모음집
# sms 말뭉치 확인
print(corpus)
# <<SimpleCorpus>>
#   Metadata:  corpus specific: 1, document level (indexed): 0
# Content:  documents: 5559

class(corpus) # [1] "SimpleCorpus" "Corpus"
length(corpus) # 5559 엑셀 파일의 행수와 동일

# inspect 함수는 말뭉치의 내용을 보여 준다.
inspect(corpus[1:3]) # 1번째 부터 3번째 까지의 내용

# tm_map() 함수는 말뭉치로 변환(mapping 이라고 한다.)해주는 함수이다.
# tm_map() 사용하여 말뭉치 정리  help(tm_map)
clean <- tm_map(x=corpus, FUN=tolower)
clean <- tm_map(x=clean, FUN=removeNumbers)

# help(tm_map)

# 불용어(stopwords) 주제의 분석 단어로써 큰 의미가 없는 단어를 말한다.
# 예를 들어서, 경제 지표를 얘기하고자 할 때 '경제'라는 단어가 불용어이다.
# 여기서는 you / a 등등
clean <- tm_map(clean, removeWords, stopwords())

# getTransformations() : 변형 방법을 목록으로 보여 주는 함수
getTransformations() # help(getTransformations)
clean <- tm_map(clean, removePunctuation) # 구둣점
clean <- tm_map(clean, stripWhitespace) # 눈에 보이지 않는 글자들

class(clean)

# 말뭉치 정리 확인
inspect(corpus[1:3])
inspect(clean[1:3])
# hope good week just checking
# kgive back thanks
# also cbe pay

sparse_matrix <- DocumentTermMatrix(clean[1:3])

sparse_matrix
inspect(sparse_matrix)
# Docs also back cbe checking good hope just kgive thanks week
# 1    0    0   0        1    1    1    1     0      0    1
# 2    0    1   0        0    0    0    0     1      1    0
# 3    1    0   1        0    0    0    0     0      0    0

# 문서-용어 희소 매트릭스 생성
# DocumentTermMatrix 함수는 말뭉치를 입력 받아서 희소 매트릭스를 만든다.
sparse_matrix <- DocumentTermMatrix(clean)
class(sparse_matrix) # "DocumentTermMatrix"    "simple_triplet_matrix"
# 행은 문서, 열은 단어의 형식으로 만들어 준다.
sparse_matrix
inspect(sparse_matrix)

# 훈련과 테스트 데이터 셋을 분리한다.(3대1)
total_row <- nrow(smsdata)
training_row <- floor(0.75 * nrow(smsdata)) # 4169.25

# 원시 데이터 프레임
smsdata_train <- smsdata[1:training_row, ] # 75%를 훈련용
smsdata_test  <- smsdata[(training_row+1):total_row, ]

# 문서 용어 매트릭스
sparse_matrix_train <- sparse_matrix[1:training_row, ]
sparse_matrix_test  <- sparse_matrix[(training_row+1):total_row, ]

# 말뭉치
corpus_train <- clean[1:training_row]
corpus_test  <- clean[(training_row+1):total_row]

# 스팸 비율 확인
prop.table(table(smsdata_train$type))
# ham       spam
# 0.8647158 0.1352842

prop.table(table(smsdata_test$type))
# ham       spam
# 0.8683453 0.1316547

# 위의 결과를 보면 훈련용, 점검용 둘다 약 13%정도의 스팸율을 보이고 있다.

# 워드 클라우드 시각화를 수행해본다.
# install.packages('wordcloud')
library(wordcloud)

wordcloud(corpus_train, min.freq = 30, random.order = FALSE)

# 훈련 데이터를 스팸과 햄으로 구분
span_train <- subset(smsdata_train, type == "spam")
ham_train  <- subset(smsdata_train, type == "ham")

# 스팸과 햄에 대하여 따로 그려 보기
wordcloud(span_train$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham_train$text, max.words = 40, scale = c(3, 0.5))

# help(findFreqTerms)
# findFreqTerms() 함수는 단어의 빈도 수를 찾기 위해서 사용하는 함수이다.
# 5번 이상 나온 단어들의 목록 출력
findFreqTerms(sparse_matrix_train, 5)

# Dictionary() : 문서 용어 매트릭스에서 특정 빈도수 이상 나타난 단어들을
# 문자열 벡터 형식으로 만들어 준다.
# sms_dict <- Dictionary(findFreqTerms(sparse_matrix_train, 5))
# tm 버전 0.5이상은 Dictionary() 함수를 사용하지 말것
sms_dict <- findFreqTerms(sparse_matrix_train, 5)
class(sms_dict)

# 훈련용과 테스트용 데이터 셋을 앞의 사전(sms_dict)에 있는 단어로만 제한하기
training <- DocumentTermMatrix(corpus_train, list(dictionary = sms_dict))
testing  <- DocumentTermMatrix(corpus_test, list(dictionary = sms_dict))

inspect(testing)

# 나이브 베이즈 분류기는 일반적으로 분류적 특성을 가진 데이터에 대하여 적용하여 훈련을 한다.
# 따라서, 희소 매트릭스의 내용을 숫자가 아닌 분류의 타입으로 변경해야 한다.
# 즉, 0은 'No', 1이상은 'Yes'로 변환하여 처리해야 한다.
# 관련 함수를 다음과 같이 하나 만들도록 한다.
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}

inspect(training)

# apply() convert_counts()를 사용한 훈련/테스트 데이터 추출
training <- apply(training, MARGIN = 2, convert_counts)
testing  <- apply(testing, MARGIN = 2, convert_counts)

# 데이터로 모델 훈련하기
# install.packages('e1071')
library(e1071) # 나이브 베이즈 구현 패키지

sms_classifier <- naiveBayes(training, smsdata_train$type)
class(sms_classifier) # [1] "naiveBayes"

# 모델 성능을 평가한다.(시간이 약간 걸린다.)
prediction <- predict(sms_classifier, testing)

library(gmodels) # help(CrossTable)

# prop.t : 테이블 비율 포함 여부
# prop.r : 행 비율 포함 여부
# dnn : dimnames names을 마음대로 부여하고 자 할 때 사용한다.
CrossTable(prediction, smsdata_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

# 모델 성능을 향상하기위하여 라플라스 추정기를 변경해본다  help(naiveBayes)
sms_classifier2 <- naiveBayes(training, smsdata_train$type, laplace = 1)
prediction2 <- predict(sms_classifier2, testing)
CrossTable(prediction2, smsdata_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
