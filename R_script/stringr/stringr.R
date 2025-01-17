###############################################################################
library(stringr)

mystr <- '홍길동&10&역삼동&hong@naver.com=박영희&20&공덕동&park@daum.net'

# str_extract : 조건에 맞는 하나의 문자열 가져오기 
# vector로 가져옴 
test01 <- str_extract(mystr, '[0-9]{2}')
test01
mode(test01)

# str_extract_all : 조건에 맞는 모든 문자열 가져오기 
# list로 가져옴 
test02 <- str_extract_all(mystr, '[0-9]{2}')
test02
mode(test02) 
unlist(test02)

string <- 'hong1234kimu5678'
string

# length는 매개 변수의 개수만 가져온다.
# str_length를 사용해야 string의 길이를 가져올 수 있다.
length(string)
len <- str_length(string)
len

# length에 벡터 값을 넣으면 벡터의 개수를 잘 가져오는걸 볼 수 있다.
# str_length의 매개변수로 벡터 값을 넣으면 출력도 두개가 나온다. 
string2 <- c('hello', 'math')
length(string2)
len2 <- str_length(string2)
len2

# str_locate(string, findword)로 findword가 자리한 인덱스를 반환한다. 
findword <- 'kim'
loc <- str_locate(string, findword)
loc

## loc의 값을 이용하여 kim 글자 추출하기

kim <- str_sub(string, loc[1], loc[2])
kim

# subString(string, start, end)를 사용해서 부분 문자 추출 가능 
string_sub <- str_sub(string, 1, 9-1)
string_sub

# upper, lower을 사용하여 대소문자 변환
upper <- str_to_upper(string)
upper

lower <- str_to_lower(string)
lower

# str_replace, _all를 사용하여 문자열 치환 
string_rep <- str_replace(string, 'hong', 'lee')
string_rep

string_rep2 <- str_replace_all(string, '1234', '5678')
string_rep2

string_rep3 <- str_replace_all(string_rep2, '567', '143')
string_rep3

# 일부 문자를 빈 문자열로 치환 
string_rep4 <- str_replace_all(string_rep3, '[0-9]', '')
string_rep4

string5 <- 'aaa123'
string6 <- 'bbb445'

# str_c() 함수 : 문자열 결합(concat)
concat1 <- str_c(string5, string6)
concat1

# str_split : 문자열 split
# list로 반환됨 
string7 <- 'aaa,bbb,ccc'
split1 <- str_split(string7, ',')
split1
vec <- unlist(split1)
vec

# paste() 함수를 통해 문자열 결합 가능
# collapse, sep 옵션으로 구분자 삽입
# collapse는 벡터사용시, sep은 string 값이 들어올때 사용 
members <- c('hong10', 'kimu20', 'leesu30')
string_joun <- paste(members, collapse = ',')
string_joun

paste('hi', 'everyone', sep='/')

############################################################################3

mystr
delimiter <- '='

# simplify = TRUE 옵션은 벡터로 만들어 준다.
mysplit <- str_split( mystr, delimiter, simplify = TRUE)
mysplit

# init vector
vec <- c()

# for문으로 요소마다 split
for ( one in mysplit ){
  delimiter <- '&'
  mydata <- str_split( one, delimiter, simplify = TRUE)
  print(mydata)
  print("=======================================================")

  delimiter <- '@'
  idemail <- str_split( mydata[4], delimiter, simplify = TRUE)
  # print(idemail)
  print("*******************************************************")
  vec <- c(vec, c( mydata[1], mydata[2], mydata[3], idemail[1], idemail[2]))
}
vec

# 행렬로 생성 
mat <- matrix(vec, nrow=2, byrow = T)
mat

# 행렬을 데이터 프레임으로 바꾼 후 colnames 설정 
df <- as.data.frame( mat )
colnames(df) <- c('이름','나이','주소','아이디','메일주소')
df$나이

## 나이를 숫자로 변경 
sapply(df$나이, as.numeric)
df


###############################################################################
mystr <- '사과10=배20=감15=사과30'
mydata <- str_split( mystr, '=', simplify = TRUE)
mydata
vec <- c()
setfruits <- c() # 집합
for (one in mydata){
  name <- str_extract(one, '[가-힣]{1,}')
  qty <- str_extract(one, '[0-9]{2}')
  print(name)
  print(qty)
  setfruits <- c(setfruits, name)
  vec <- c(vec, name, qty)
}
setfruits

## fruits의 name을 하나만 설정 
setfruits <- unique(setfruits)
setfruits

vec
mat <- matrix(vec, ncol=2, byrow = T)
mat
dffruit <- as.data.frame(mat)
colnames(dffruit) <- c('과일', '수량')
dffruit
###############################################################################

string <- 'kim100usin/lee200sunsin'
spl <- str_split(string, '/', simplify = T)
vFn <- c()
vLn <- c()
vAg <- c()
for(i in spl) {
  fName <- str_extract(i, '[A-z]{1,3}')
  lName <- str_extract(i, '[A-z]{4,}')
  age <- str_extract(i, '[0-9]{2,}')
  vFn <- c(vFn, fName)
  vLn <- c(vLn, lName)
  vAg <- c(vAg, as.numeric(age) + 50)
}
v <- c(vFn, vLn, vAg); v
m <- matrix(v, nrow = 2, byrow = F); m
df <- as.data.frame(m); df
colnames(df) <- c('First Name', 'LastName', 'age'); df
