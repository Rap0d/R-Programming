# jumsunew.csv 파일을 이용하여 다음 물음에 답하시오.
# 

getwd()

score <- read.csv('jumsunew.csv')
score

# 각 과목들의 총점을 구하시오.
# 
tmp <- score[, c(3:5)]
score$total <- apply(tmp, 1, sum)
score

# 각 학생별로 평균 컬럼을 추가하되, 소수점 2자리까지 표시하시오.
# 
tmp <- score[,c(3:5)]
score$avg <- round(apply(tmp, 1, mean), 2)
score$avg

# 학생별로 합격 여부를 판단하는 컬럼을 추가하시오.
# 3과목의 평균이 60이상이면 합격이다.
# 
score$pass <- ifelse(score$avg >= 60, 'P', 'F')

# 각 과목별로 우수 또는 노력 컬럼을 판단하는 컬럼을 추가하시오.
# 점수가 50이상이면 우수, 미만이면 노력으로 추가한다.
# '우수'의 갯수가 2 이상인 행만 필터링하시오.
# 
tmp <- score[, c(3:5)]

score$good <- ifelse(tmp >= 50, 'good', 'bad')
# score$best <- ifelse((score$good.kor + score$good.eng + score$good.math) >= 2, 'best', 'soso')

i <- 1
ln <- length(score$good)
cnt <- 1
tmp <- 0

while(T) {
  print(score$good[[i]])
  
  if(score$good[[i]] == 'good') {
    tmp <- tmp + 1
    score$good[[i]]
  }
  
  if(i == length(score$good)) {
    break
  }
  
  i <- i + 5
  
  if(i > ln) {
    if(tmp >= 2) {
      score$effort <- 'best'
    }
    print('')
    i = i - (ln-1)
  }
}
str(score)
score

# other

file = read.csv('jumsunew.csv')
file

file$mean = round(apply(file[3:5], 1, mean), 2)
file

file$result = ifelse(file$mean >= 60, 'pass', 'fail')
file

file$koreffort = ifelse(file$kor >= 50, 'good', 'bad')
file$engeffort = ifelse(file$eng >= 50, 'good', 'bad')
file$matheffort = ifelse(file$math >= 50, 'good', 'bad')
file

tmp = file[8:10]
tmp
file$count <- 0
i = 1
while(i <= nrow(file)) {
  file[i,]$count = sum(tmp[i,] == 'good')
  i = i + 1
}
result = file[(file$count >= 2),]
result


# 국어 점수가 가장 높은 순으로 정렬하시오.
# 
ordering <- order(score$kor, decreasing = T)
ordering
sort_res <- score[ordering,]
sort_res

# 평균 점수가 가장 낮은 순으로 정렬하시오.
ordering <- order(score$avg)
ordering
sort_res_avg <- score[ordering,]
sort_res_avg
