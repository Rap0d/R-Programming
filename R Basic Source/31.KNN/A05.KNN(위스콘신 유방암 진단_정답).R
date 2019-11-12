#########################################################
# 단계 : 데이터 준비하기
#########################################################
# 최근접 이웃(Nearest Neighbors)을 사용한 데이터 분류(Classification)
## 예제 : 암 샘플 분류 ----
## 단계 2 : 데이터 준비와 살펴보기 ----
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd) # 구조 확인
dim(wbcd) # 569  32

# id 속성 제거 : 환자에 대한 식별자 컬럼
wbcd <- wbcd[-1]

# wbcd$diagnosis : 진단 정보 컬럼
unique(wbcd$diagnosis) # "B"(양성) "M"(악성)
table(wbcd$diagnosis)
# B   M
# 357 212

# 팩터로서 진단 변수 변환
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))
# Benign Malignant
# 357       212

# 진단 변수의 비율
prop <- (357)/(357+212)
prop # 0.6274165
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# 세 속성에 대한 요약 정보 보기
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])
#########################################################
# 단계 : 데이터 정규화 하기
#########################################################
# KNN 알고리즘에서 거리의 계산은 입력 데이터의 측정 범위에 의존한다.
# area_mean의 평균은 551.1이고, smoothness_mean의 평균은 0.09587 이다.
# 이럴 경우에는 정규화를 이용하여 데이터의 분포를 일정하게 할 필요가 있다.

# min-max 정규화 함수 만들기
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# 정규화 함수 테스트 - 결과는 일치함
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# wbcd 데이터 정규화
# wbcd_n에서 _n은 normalize된 데이터라는 의미로 작성했다.
# 각 열별로 normalize 함수를 적용한 다음 data frame으로 변경하
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

# 정규화가 잘 되었는지 확인
summary(wbcd_n$area_mean)
#########################################################
# 단계 : 훈련 데이터와 테스트 데이터 생성
#########################################################
dim(wbcd_n) # 569  30

# 검정용 데이터를 100개로 사용하기로 한다.
# 만일 데이터가 연대순으로 유사한 값들이 서로 인접해 있는 경우에는 반드시 
# 샘플링 기법을 사용할 필요가 있다.
testing_row = 100 # 검정용 데이터 행수 
total_row = nrow(wbcd_n)
training_row = nrow(wbcd_n) - testing_row
wbcd_train <- wbcd_n[1:training_row, ]
wbcd_test <- wbcd_n[(training_row+1):total_row, ]

str(wbcd)

# 훈련 데이터와 테스트 데이터에 대한 라벨 생성
# 머신 러닝에서 보통 label이라 함은 정답을 의미한다.
# "Benign"(양성) "Malignant"(악성)
wbcd_train_labels <- wbcd[1:training_row, 1]
wbcd_test_labels <- wbcd[(training_row+1):total_row, 1]
#########################################################
# 단계 : 데이터에 적용하여 모델을 훈련 시키기
#########################################################
# 해당 데이터로 모델을 훈련시킨다.
# "class" 라이브러리 로드
library(class)
# help(knn)

# 훈련 데이터에 루트를 씌워서 가장 가까운 홀수로 만든다.
# 권장하는 방법이지, 이것이 가장 좋은 효율이 나온다고 장담은 못한다.
k_size <- floor(sqrt(training_row)) 
k_size <- ifelse(k_size %% 2 == 0, k_size + 1, k_size) 

# knn( training, testing, training_label, k사이즈)
# wbcd_test_pred : 예측 
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k=k_size)

class(wbcd_test_pred) #  "factor"
#########################################################
# 단계 : 해당 모델에 대한 성능 평가하기
#########################################################
# install.packages('gmodels')
library(gmodels)# "gmodels" 라이브러리 로드

# 예측값과 실제값의 교차표 생성
# x : 정답 정보, y : 에측 값 정보
# prop.chisq=FALSE : 카이 제곱 검정은 표시하지 않는다.

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

# 하단 그림에서 2%(Malignant가 정답인데 Benign라고 예측한 2개) 만이 잘못된 분류이다
# Total Observations in Table:  100 
# 
# 
#                    | wbcd_test_pred 
# wbcd_test_labels   |    Benign | Malignant | Row Total | 
#   -----------------|-----------|-----------|-----------|
          #   Benign |    (TN)61 |         0 |        61 | 
#                    |     1.000 |     0.000 |     0.610 | 
#                    |     0.968 |     0.000 |           | 
#                    |     0.610 |     0.000 |           | 
#   -----------------|-----------|-----------|-----------|
#          Malignant |         2 |    (TP)37 |        39 | 
#                    |     0.051 |     0.949 |     0.390 | 
#                    |     0.032 |     1.000 |           | 
#                    |     0.020 |     0.370 |           | 
#   -----------------|-----------|-----------|-----------|
#       Column Total |        63 |        37 |       100 | 
#                    |     0.630 |     0.370 |           | 
#   -----------------|-----------|-----------|-----------|

#########################################################
# 단계 : 해당 모델에 대한 성능 높이기
#########################################################
# 악성 조직은 매우 크게 자라기 때문(이상치 발생)에 거리 계산시 이상치에 대하여 
# 좀더 가중치를 부여하는 것이 바람직하다.
# 표준화된 변수를 사용하기 위하여 scale() 함수를 사용한다.
# diagnosis 컬럼을 제외한 나머지 컬럼에 z-score를 표준화시킨다.
wbcd_z <- as.data.frame(scale(wbcd[-1]))

# 변환이 정확하게 적용되었는지 확인
# z 점수로 표준화된 데이터의 평균은 항상 0이다.
summary(wbcd_z$area_mean)

# 훈련과 테스트 데이터셋 생성
wbcd_train <- wbcd_z[1:training_row, ]
wbcd_test <- wbcd_z[(training_row+1):total_row, ]

# 변경한 데이터로 분류
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k=k_size)

# 예측값과 실제값의 교차표 생성
# 아쉽게도 성능이 더 떨어 졌다.
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

#########################################################
# 단계 : 다른 k 값으로 분류해 보기
#########################################################
wbcd_train <- wbcd_n[1:training_row, ]
wbcd_test <- wbcd_n[(training_row+1):total_row, ]

# k 값을 바꿔 가면서 여러 가지를 점검해 보도록 한다.
k_size <- 1
wbcd_test_pred <- knn(train=wbcd_train, test=wbcd_test, cl=wbcd_train_labels, k=k_size)

CrossTable(x= wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE )

for( idx in c(5, 11, 15, 21, 27)){
    k_size <- idx
    wbcd_test_pred <- knn(train=wbcd_train, test=wbcd_test, cl=wbcd_train_labels, k=k_size)
    CrossTable(x= wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE )
    cat('###########################################################################')
}
