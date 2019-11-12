# 예제 : 자주 구매된 식료품 식별 ----
# install.packages('arules')
library(arules)
groceries <- read.transactions("groceries.csv", sep = ",")
dim(groceries)
summary(groceries) # item의 수와 트랜잭션의 수를 요약 통계량으로 보여 준다. 
# a density of 0.02609146는 매트릭스에서 0이 아닌 칸의 비율을 말한다.
# 영업 시간 총 거래건수 = 9835 * 169 * 0.02609146 = 43,367 개
# 거래 건수당 평균 구매 개수 = 43,367 / 9835 = 4.409456024개

# whole milk의 거래 비율 : 2513 / 9835 = 0.255516014
# 즉, 거의 4회당 1번은 판매된다.

# 물건 1개만 팔린 건수가 2159건이다.
# 물건 32개가 팔린 적이 단 1건이 있었다.

# 처음 5개의 거래 내역 확인
# 3번째 거래는 {whole milk} 단 하나이다.
inspect(groceries[1:5])

# 식료품의 빈도 확인
itemFrequency(groceries[, 1:3])
itemFrequency(groceries)
# 제품은 희소 행렬에 알파벳 순으로 정렬이 되어 있다.
# 예를 들어서 애기 화장품은 0.06% 정도 거래 되었다.
# abrasive cleaner artif. sweetener   baby cosmetics 
# 0.0035587189     0.0032536858     0.0006100661 

class(groceries)
# 식료품의 빈도 시각화
# 지지도가 10% 이상인 항목을 보여 주기
itemFrequencyPlot(groceries, support = 0.1)

# 지지도에 대한 내림 차순으로 보여 주기
itemFrequencyPlot(groceries, topN = 20)

# 처음 5개 거래에 대한 희소 매트릭스 시각화
image(groceries[1:5])

# 100개 식료품의 무작위 샘플 시각화
image(sample(groceries, 100))

# 기본 설정
apriori(groceries)

# 규칙을 좀 더 학습히기 위해 지지도(support)와 신뢰도(confidence) 설정 변경
groceryrules <- apriori(groceries, parameter = list(support =
                          0.006, confidence = 0.25, minlen = 2))
groceryrules

## 4단계 : 모델 성능 평가 ----
# 식료품 연관 규칙의 요약
summary(groceryrules)

# 처음 3개 규칙 확인
inspect(groceryrules[1:3])

## 5단계 : 모델 성능 향상 ----

# lift로 규칙 정렬
inspect(sort(groceryrules, by = "lift")[1:5])

# 딸기류 아이템을 포함하는 규칙의 부분 규칙 찾기
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)

# CSV 파일에 규칙 쓰기
write(groceryrules, file = "groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# 규칙들을 데이터 프레임으로 변환
groceryrules_df <- as(groceryrules, "data.frame")
str(groceryrules_df)
