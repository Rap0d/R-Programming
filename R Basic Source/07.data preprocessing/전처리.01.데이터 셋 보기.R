getwd()
setwd('R Basic Source/07.data preprocessing/')
# 단계. 데이터 셋 보기
dataset = read.csv("dataset.csv", header=TRUE)   # 헤더가 있는 경우

str(dataset) 
# 'data.frame':   300 obs. of  7 variables:
#  $ resident: int  1 2 NA 4 5 3 2 5 NA 2 ...
#  $ gender  : int  1 1 1 2 1 1 2 1 1 1 ...
#  $ job     : int  1 2 2 NA 3 2 1 2 1 2 ...
#  $ age     : int  26 54 41 45 62 57 36 NA 56 37 ...
#  $ position: int  2 5 4 4 5 NA 3 3 5 3 ...
#  $ price   : num  5.1 4.2 4.7 3.5 5 5.4 4.1 675 4.4 4.9 ...
#  $ survey  : int  1 2 4 2 1 2 4 4 3 3 ...
 
# -- 데이터셋 전체 보기
print( head(dataset) ) # 콘솔 창으로 전체 보기
View(dataset)  # 뷰어창 출력
 
head(dataset) 
#   resident gender job age position price survey
# 1        1      1   1  26        2   5.1      1
# 2        2      1   2  54        5   4.2      2
# 3       NA      1   2  41        4   4.7      4
# 4        4      2  NA  45        4   3.5      2
# 5        5      1   3  62        5   5.0      1
# 6        3      1   2  57       NA   5.4      2

tail(dataset) 
#     resident gender job age position price survey
# 295        2      1   1  20        1   3.5      5
# 296        1      5   2  26        1   7.1      2
# 297        3      1   3  24        1   6.1      2
# 298        4      1   3  59        5   5.5      2
# 299        3      0   1  45        4   5.1      2
# 300        1      1   3  27        2   4.4      2

 
# 단계. 데이터 셋 구조 보기
names(dataset) # 변수명(컬럼)
# [1] "resident" "gender"   "job"      "age"      "position" "price"    "survey"  

attributes(dataset) # names(열이름), class, row.names(행이름)

 
# 단계. 데이터 셋 조회 
dataset$age # dataset의 age 컬럼 출력

dataset$resident # dataset의 resident 컬럼 출력

length(dataset$age) # age 컬럼의 데이터 갯수
 
# 조회된 결과를 변수에 저장하는 방식
# dataset의 gender 컬럼을 변수 x에 저장한다.
x = dataset$gender                              
x

y = dataset$price
y

# 산점도 형태로 구매 가격 변수 조회하기
plot(dataset$price)                              
 
# $기호 대신 [""]기호를 이용한 변수 조회
dataset["gender"] 
dataset["price"]
 
# 색인(index)으로 칼럼 조회 
dataset[2] # 두 번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체
 
# --dataset에서 2개 이상 칼럼 조회
dataset[c("job","price")]
dataset[c(2,6)] 
 
dataset[c(1,2,3)] 
dataset[c(1:3)] 
dataset[c(2,4:6,3,1)] 
 
# dataset의 특정 행/열을 조회하는 경우
dataset[, c(2:4)] # 2~4열
dataset[ c(2:4), ] # 2~4행 전체
dataset[-c(1:100), ]# 1~100행은 제외