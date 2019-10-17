detach("package:plyr", unload = TRUE)
detach("package:dplyr", unload = TRUE)

# plyr가 dplyr보다 빠르게 로드해야함 
library(plyr)
library(dplyr, warn.conflicts = FALSE)

library(rJava)
library(xlsx)
# R정형데이터처리하기.xlsx 파일을 읽어 들이세요.
# 가전제품1~가전제품3 시트를 읽어 와서 하나의 데이터프레임(이름 : myframe)에 병합하시오.
# 단, 분기 구분이 있어야 하므로 quarter(분기 컬럼 이름)을 하나 추가하도록 한다.


setwd('../05.data io/')

myencoding = 'UTF-8'
filename = 'R정형데이터처리하기.xlsx'

sheets <- c(3:5)
myframe <- data.frame()
for( onesheet in sheets ){
  print(onesheet)
  dframe <- read.xlsx(file=filename, sheetIndex = onesheet, encoding=myencoding)
  dframe$quarter <- paste((onesheet-2), "사분기", sep='')
  myframe <- rbind(myframe, dframe)
}
myframe



# myframe에서 quarter가 1사분기인 경우만 출력하세요.
# 
ex1 <- filter(myframe, quarter %in% '1사분기')
ex1

# myframe에서 3사분기가 아닌 경우만 출력하세요.
# 
ex2 <- filter(myframe, quarter != '3사분기')
ex2

# 전체에서 불량품 수 40을 초과한 경우만 출력하세요. 
# 
ex3 <- filter(myframe, 불량품 > 40)
ex3

# 1일생산량이 100~150인 경우만 출력하세요.(between 사용)
# 
ex4 <- filter(myframe, between(X1일생산량, 100, 150))
ex4

# 1사분기이면서 1일생산량이 200이하인 경우만 출력하세요.
#
ex5 <- filter(myframe, quarter %in% '1사분기' &  X1일생산량 <= 200)
ex5

# 총생산량이 10000 이상이거나 불량품이 35이하인 경우만 출력하세요.
# 
ex6 <- filter(myframe, 총생산량 >= 10000 | 불량품 <= 35)
ex6

# # %in% 기호를 사용하면 코드를 좀 더 간결하게 작성할 수 있다.
# # %in% 기호와 c() 함수를 이용해 조건 목록을 입력하면 된다.
# 
# # 1사분기, 3사분기 데이터를 출력하시오.
# 
ex7 <- filter(myframe, quarter %in% c('1사분기', '3사분기'))
ex7

# 1사분기 정보를 변수 quarter1에 저장하시오.
# 
quarter1 <- filter(myframe, quarter %in% c('1사분기'))
quarter1

# 2사분기 정보를 변수 quarter2에 저장하시오.
# 
quarter2 <- filter(myframe, quarter %in% c('2사분기'))
quarter2

# 변수 quarter1의 1일생산량 평균을 구하시오.(mean 함수)
# 
ex8 <- mean(quarter1$X1일생산량)
ex8

# 변수 quarter2의 총생산량의 총합을 구하시오.(sum 함수)
# 
ex9 <- sum(quarter1$총생산량)
ex9

# 1사분기의 총생산량 컬럼만 추출하시오.
# 
ex10 <- quarter1 %>% select(총생산량)
ex10

# 전체에서 제품명과 1일생산량의 앞부분 10행까지만 추출하시오.
# 힌트 : head() 함수도 사용할 수 있다.
# 
ex11_1 <- myframe %>% select(제품명, X1일생산량)
ex11 <- head(ex11_1, 10)
ex11

# 출고량를 기준으로 오름차순으로 정렬하시오.
# 
ex12 <- myframe %>% arrange(출고량)
ex12

# 총생산량을 기준으로 내림차순으로 정렬하시오.
# 
ex12 <- myframe %>% arrange(desc(총생산량))
ex12

# 분기(quarter)별 오름차순 정렬 후, 불량품으로 내림차순 정렬하시오.
# 
ex13 <- myframe %>% arrange(quarter) %>%  arrange(desc(불량품))
ex13

# 불량률 컬럼을 만들어 보되, 소수점 3자리까지 표현하시오.
# 불량률 = 불량품 / 총생산량
ex14 <- myframe %>% mutate(불량률 = (round(불량품 / 총생산량, 5) * 100))
ex14

# result 컬럼을 만들어 보세요.
# result 컬럼은 불량률 컬럼이 얼마이상이면 'bad', 아니면 'good'이라는 값을 저장해야 한다.
# 힌트 : ifelse 함수를 사용하면 된다.
# 
ex15 <- ex14 %>% mutate(result = ifelse(불량률 < 0.4, 'good', 'bad'))
ex15

# 불량률 컬럼 기준으로 오름차순 정렬하시오.
# 
ex16 <- ex15 %>% arrange(불량률)
ex16

# 분기별로 총생산량의 평균과 불량품의 총합 및 도수를 구해 보세요(힌트 : n() 함수)
# n()을 사용할때 dplyr::n()를 통해서 명시한다. 
ex17 <- ex16 %>% group_by(quarter) %>% summarise(평균 = mean(총생산량), 불량품총합 = sum(불량품), 불량품도수 = dplyr::n())
ex17

