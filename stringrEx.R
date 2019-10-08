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
