# mysample <- read.csv("naive_bayes_test.csv", header=TRUE, stringsAsFactors = FALSE)
mysample <- read.csv("naive_bayes_test_mini.csv", header=TRUE, stringsAsFactors = FALSE)
dim(mysample)
str(mysample)

mysample$type <- factor(mysample$type)

str(mysample$type)
unique(mysample$type)
table(mysample$type)

# install.packages('tm')
library(tm)

# Corpus : 말뭉치
sms_corpus <- Corpus(VectorSource(mysample$text))

print(sms_corpus)

class(sms_corpus)  
length(sms_corpus) 

# 말뭉치의 내용 확인
inspect(sms_corpus[1:5])

corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)

# 불용어(stopwords) 주제의 분석 단어로써 큰 의미가 없는 단어를 말한다.
# 예를 들어서, 경제 지표를 얘기하고자 할 때 '경제'라는 단어가 불용어이다.
# 여기서는 you / a 등등
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation) # 구둣점
corpus_clean <- tm_map(corpus_clean, stripWhitespace) # 눈에 보이지 않는 글자들

class(corpus_clean)

# 말뭉치 정리 확인
inspect(sms_corpus[1:5])
inspect(corpus_clean[1:5])

# 문서-용어 희소 매트릭스 생성 help(DocumentTermMatrix)
# DocumentTermMatrix 함수는 말뭉치를 입력 받아서 희소 매트릭스를 만든다.
sms_sparse_matrix <- DocumentTermMatrix(corpus_clean)
class(sms_sparse_matrix) # "DocumentTermMatrix"    "simple_triplet_matrix"

# 행은 문서, 열은 단어의 형식으로 만들어 준다.
sms_sparse_matrix
inspect(sms_sparse_matrix)

# 훈련과 테스트 데이터셋 생성
total_row <- nrow(mysample)
total_row
training_row <- nrow(mysample) - 2
training_row

# 원시 데이터 프레임
mysample_train <- mysample[1:training_row, ] # 75%를 훈련용
mysample_test  <- mysample[(training_row+1):total_row, ]

# 문서 용어 매트릭스
sms_sparse_matrix_train <- sms_sparse_matrix[1:training_row, ]
sms_sparse_matrix_test  <- sms_sparse_matrix[(training_row+1):total_row, ]

# 말뭉치
sms_corpus_train <- corpus_clean[1:training_row]
sms_corpus_test  <- corpus_clean[(training_row+1):total_row]

# 스팸 비율 확인
prop.table(table(mysample_train$type))

prop.table(table(mysample_test$type))

findFreqTerms(sms_sparse_matrix_train, 1)

# Dictionary() : 문서 용어 매트릭스에서 특정 빈도수 이상 나타난 단어들을 문자열 벡터 형식으로 만들어 준다.
# sms_dict <- Dictionary(findFreqTerms(sms_sparse_matrix_train, 5))
# tm 버전 0.5이상은 Dictionary() 함수를 사용하지 말것
sms_dict <- findFreqTerms(sms_sparse_matrix_train, 1)
class(sms_dict)

# 훈련용과 테스트용 데이터 셋을 앞의 사전(sms_dict)에 있는 단어로만 제한하기
sms_train <- DocumentTermMatrix(sms_corpus_train, list(dictionary = sms_dict))
sms_test  <- DocumentTermMatrix(sms_corpus_test, list(dictionary = sms_dict))

inspect(sms_test)

# 나이브 베이즈 분류기는 일반적으로 분류적 특성을 가진 데이터에 대하여 적용하여 훈련을 한다.
# 따라서, 희소 매트릭스의 내용을 숫자가 아닌 분류의 타입으로 변경해야 한다.
# 즉, 0은 'No', 1이상은 'Yes'로 변환하여 처리해야 한다.
# 관련 함수를 다음과 같이 하나 만들도록 한다.
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}

# apply() convert_counts()를 사용한 훈련/테스트 데이터 추출
sms_train <- apply(sms_train, MARGIN = 2, convert_counts)
sms_train
sms_test  <- apply(sms_test, MARGIN = 2, convert_counts)
sms_test

# 데이터로 모델 훈련하기
# install.packages('e1071')
library(e1071) # 나이브 베이즈 구현 패키지

sms_classifier <- naiveBayes(sms_train, mysample_train$type)
class(sms_classifier) # [1] "naiveBayes"

# 모델 성능을 평가한다.(시간이 약간 걸린다.)
sms_test_pred <- predict(sms_classifier, sms_test)

library(gmodels) # help(CrossTable)

# prop.t : 테이블 비율 포함 여부
# prop.r : 행 비율 포함 여부
# dnn : dimnames names을 마음대로 부여하고 자 할 때 사용한다.
CrossTable(sms_test_pred, mysample_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

# 모델 성능을 향상하기위하여 라플라스 추정기를 변경해본다  help(naiveBayes)
sms_classifier2 <- naiveBayes(sms_train, mysample_train$type, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, mysample_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
