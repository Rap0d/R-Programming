# c는 combine의 줄인말
# 1반 학생들의 국어 시험 점수
# 벡터 : 동일한 형태의 자료를 1차원 형태로 저장하는 자료 구조
# c() 커맨드를 이용하여 만들수 있다.
ban1 = c(99, 91, 95, 90, 84)
 
# 2반 학생들의 국어 시험 점수
ban2 = c(97, 70, 92, 91, 72)
 
# 여러 커맨드를 한 줄에 적을 때는 세미 콜론으로 분리 
ban1 ; ban2
 
# 더하기 연산은 각 요소별 덧셈을 수행한다.
add = ban1 + ban2
add

mul = ban1 * ban2
mul

equi = ban1 == ban2
equi
sum(equi) # TRUE인 항목에 대하여 카운트 한다.

# 각 요소별 간의 곱의 결과를 합산한다.
result = ban1 %*% ban2
result

# 모든 학생들의 국어 점수
# ban1의 요소들과 ban2의 요소들을 합쳐서 새로운 벡터를 생성한다.
score = c(ban1, ban2)
score

# seq() 함수를 이용한 벡터 객체 생성하기
# seq() 함수는 증가 값에 의해서 순차적으로 
# 값(sequence value)을 증가시켜서 벡터 자료를 만들어준다.
seq(1,10,2) # sequence value 함수 -> 2씩 증가
# [1] 1 3 5 7 9

# rep()함수 이용 벡터 생성
rep(1:3, 3) # replicate value 함수
# [1] 1 2 3 1 2 3 1 2 3

rep(1:3, each=3) 
# [1] 1 1 1 2 2 2 3 3 3


somedata = c(seq(10,100,10))
somedata = seq(10,100,10)
class(somedata)

somedata[1]

somedata[c(1, 5, 7)]

# 1번째를 제외하고 나머지 
result = somedata[-1]
result

# 1-3까지 제외하고 나머지 
somedata[-1:-3]
somedata[-c(1:3)]

somedata[somedata != 50]

somedata[somedata > 70]

myvec <- seq(1:6)

mat_a <- matrix(myvec, nrow = 3)

mat_a <- matrix(myvec, ncol = 3)

mat_b <- matrix(myvec, nrow = 2)

mat_c <- matrix(myvec, nrow = 2, byrow = T)

# 행 / 열 이름 부여 
mydim <- list(c('kim', 'park'), c('korea', 'eng', 'math'))
mat_d <- matrix(myvec, nrow = 2, byrow = T, dimnames = mydim)


x = c(1:5)
y = seq(-1,-5,-1)

mode(x)
class(x)

# 각 항목을 제곱하여 더하기 
result = x %*% x
result

mode(result)
class(result)

temp = c(x, y)
temp
class(temp)

# bind
mat_c <- cbind(x, y)
mat_c

mat_r <- rbind(x, y)
mat_r

dim(mat_r)


# t : transform(전치)
mat_r_t = t(mat_r)
mat_r_t
dim(mat_r_t)

# 행렬의 곱 연산 
result = mat_r %*% mat_r_t
result
