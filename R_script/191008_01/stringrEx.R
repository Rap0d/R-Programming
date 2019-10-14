library(stringr)

# data 객체를 대상으로 문제에 맞게 정규 표현식을 적용하여 문자열 처리

data <- c('2017-02-05 수입3000원', '2017-02-06 수입4500원', '2017-02-07 수입2500원')
data

# ex1 날짜별 수입을 다음과 같이 출력
# '3000원' '4500원' '2500원'

m <- c()
for(i in data) {
  m <- c(m, str_extract_all(i, '\\d{4}[가-힣]{1}'))
}
unlist(m)

# ex2 위 벡터에서 연속하여 2개 이상 나오는 모든 숫자를 제거
# '-- 수입원' '-- 수입원' '-- 수입원' 

m <- c()
for(i in data) {
  m <- c(m, str_replace_all(i, '\\d{2}', ''))
}
unlist(m)

# ex3 위 벡터에서 -를 /로 치환
# 2017/02/05

m <- c()
for(i in data) {
  m <- c(m, str_replace_all(i, '-', '/'))
}
unlist(m)

# ex4 모든 원소를 쉼표에 의해 하나의 문자열로 합치기 
# 2017-02-05 수입3000원,2017-02s-05 수입3000원,2017-02-05 수입3000원

paste(data, collapse = ',')


#########################

# --------------------------
# 다음 문자열을 정규 표현식을 이용하여 풀어 보세요.
# 문자열에서 소괄호 안의 수치는 1개당 단가이다.
# str1 <- '사과 3(1000)개, 밤 5(500)개, 배 4(2000)개만 주세요.'
#
# 출력 결과
# 총 구입 갯수 : 12개
# 총 판매 금액 : 13500원
# --------------------------
str1 <- '사과 3(1000)개, 밤 5(500)개, 배 4(2000)개만 주세요.'
price <- c()
qty <- c()
res <- 0

price <- c(str_extract_all(str1, '\\(\\d{3,}\\)'))
price <- c(str_extract_all(price, '\\d{3,}'))
price <- unlist(price)

qty <- c(str_extract_all(str1, '\\d{1}\\('))
qty <- c(str_extract_all(qty, '\\d{1}'))
qty <- unlist(qty)

res <- as.integer(price) * as.integer(qty)
res

tot <- 0
i <- 1
while (i <= length(res)) {
  tot <- tot + res[i]
  i <- i + 1
}

# 다음과 같은 주소지 정보가 있다.
# 마지막 번지와 관련된 정보를 추출하고자 한다.
# 
# mydata <- c('강원원주시웅비2길8'), '강원도철원군서면와수로181번길7-16', '강원평창군봉평면태기로68', '강원강릉시강변로410번길36')
# 
# 출력 결과
# 2길8
# 181번길7-16
# 68
# 410번길36
# ----------------------------
mydata <- c('강원원주시웅비2길8', '강원도철원군서면와수로181번길7-16', '강원평창군봉평면태기로68', '강원강릉시강변로410번길36')
v <- c()
regex <- '\\d{1,}(\\w{1,}-?\\d{1,})?'
for(i in mydata) {
  ro <- str_extract_all(i, regex)
  v <- c(v, ro)
}

# 다음 항목들 중에서 올바른 이메일 주소들만 정규 표현식을 이용하여 아이디와 메일 주소를 추출하세요.
# 메일 주소의 id는 반드시 알파벳 소문자로 시작해야 한다.
# id는 반드시 4글자 이상이어야 한다.
# mydata1 <- c('abcd@naver.com', '1aaa@daum.net', 'xyz1@daum.net', 'xyz@daum.net')
# 
# 출력 결과
# 아이디 : abcd, 메일 종류 : naver.com
# 아이디 : xyz1, 메일 종류 : daum.net
# ------------------------------

mydata1 <- c('abcd@naver.com', '1aaa@daum.net', 'xyz1@daum.net', 'xyz@daum.net')

vec <- c()

for(i in mydata1) {
  tmp1 <- str_extract(i, '(^[a-z]{1})(\\w{3,})')
  tmp2 <- str_extract(i, '@([a-z]{4,}).(\\w{1,})')
  tmp2 <- str_replace(tmp2, '@', '')
  if(is.na(tmp1) | is.na(tmp2)) {
    next()
  } else {
    vec <- c(vec, tmp1, tmp2)
  }
} 
vec

i <- 1

# 1
tot

# 2
v

# 3
while (i <= length(vec)) {
  cat('id:', vec[i], ', mail : ', vec[i+1], '\n')
  i <- i + 2
}

