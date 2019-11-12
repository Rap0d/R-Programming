################################################################################
# 데이터 셋 만들기
################################################################################
# iris 데이터에서 간략히 테스트 하기 위하여 컬럼 Sepal.Length, Sepal.Width, Species만 사용하도록 한다.
data <- iris[, c("Sepal.Length", "Sepal.Width", "Species")]
head(data)

set.seed(123)
################################################################################
# 데이터 셋 분류하기
################################################################################
# data를 train:valid:test=3:1:1로 분류한다.
# idx 설정
idx <- sample(x = c("train", "valid", "test"), size = nrow(data), replace = TRUE, prob = c(3, 1, 1))

# idx에 따라 데이터 나누기
train <- data[idx == "train", ]
valid <- data[idx == "valid", ]
test <- data[idx == "test", ]
################################################################################
# 산점도를 이용하여 데이터 분포 확인
################################################################################
# 산점도를 그려서 train, valid, test 데이터의 분포를 확인해보자.
# install.packages("scales")
library(scales)
# 이제 alpha 함수를 사용할 수 있다!
 
# train 산점도 그리기
plot(formula = Sepal.Length ~ Sepal.Width, data = train, col = alpha(c("purple", "blue", "green"), 0.7)[train$Species], main = "train - Classification Species")
 
# valid 표시하기
points(formula = Sepal.Length ~ Sepal.Width, data = valid, pch = 17, cex = 1.2, col = "red")
 
# test 표시하기
points(formula = Sepal.Length ~ Sepal.Width, data = test, pch = 15, cex = 1.2, col = "orange")
 
# 범례 그리기
legend("topright", c(levels(data$Species), "valid", "test"), pch = c(1, 1, 1, 17, 15), col = c(alpha(c("purple", "blue", "green"), 0.7), "red", "orange"), cex = 0.9)
################################################################################
# 입력(x)과 출력(y) 데이터로 분리
################################################################################
# x는 3번째 열을 제외한다는 의미로 -3
train_x <- train[, -3]
valid_x <- valid[, -3]
test_x <- test[, -3]
 
# y는 3번째 열만 필터링한다는 의미로 3
train_y <- train[, 3]
valid_y <- valid[, 3]
test_y <- test[, 3]
################################################################################
# knn 알고리즘 적용하기(k = 1)
################################################################################
# install.packages("class")
library(class)

# k = 1 일 때
set.seed(1234)
knn_1 <- knn(train = train_x, test = valid_x, cl = train_y, k = 1)
 
# train 산점도 그리기
plot(formula = Sepal.Length ~ Sepal.Width, data = train, col = alpha(c("purple", "blue", "green"), 0.7)[train$Species], main = "KNN (k = 1)")

# knn valid 결과 표시하기
points(formula = Sepal.Length ~ Sepal.Width, data = valid, pch = 17, cex = 1.2, col = alpha(c("purple", "blue", "green"), 0.7)[knn_1])
 
# 범례 그리기
legend("topright", c(paste("train", levels(train$Species)), paste("valid", levels(valid$Species))), pch = c(rep(1, 3), rep(17, 3)), col = c(rep(alpha(c("purple", "blue", "green"), 0.7), 2)), cex = 0.9)

# 산점도 그래프를 보면 setosa는 잘 분류된다.
# 반면 versicolor와 virginica는 분류 오류가 있음을 확인할 수 있다.

# 분류 정확도 계산하기
table(knn_1, valid_y)
# valid_y
# knn_1        setosa versicolor virginica
# setosa          8          0         0
# versicolor      0          7         5
# virginica       0          3         4

accuracy_1 <- sum(knn_1 == valid_y) / length(valid_y)
accuracy_1
################################################################################
# k = 21
################################################################################
set.seed(1234)
knn_21 <- knn(train = train_x, test = valid_x, cl = train_y, k = 21)

plot(formula = Sepal.Length ~ Sepal.Width, data = train, col = alpha(c("purple", "blue", "green"), 0.7)[train$Species], main = "KNN (k = 21)")

# knn valid 결과 표시하기
points(formula = Sepal.Length ~ Sepal.Width, data = valid, pch = 17, cex = 1.2, col = alpha(c("purple", "blue", "green"), 0.7)[knn_21])

# 범례 그리기
legend("topright", c(paste("train", levels(train$Species)), paste("valid", levels(valid$Species))), pch = c(rep(1, 3), rep(17, 3)), col = c(rep(alpha(c("purple", "blue", "green"), 0.7), 2)), cex = 0.9)

# 산점도 그래프를 보면 k = 1 일 때보다 조금 더 잘 분류되었음을 직관적으로 알 수 있다.
 
# 분류 정확도 계산하기
table(knn_21, valid_y)
# valid_y
# knn_21       setosa versicolor virginica
# setosa          8          0         0
# versicolor      0          5         1
# virginica       0          5         8

accuracy_21 <- sum(knn_21 == valid_y) / length(valid_y) 
accuracy_21
################################################################################
# 최적의 k 값 구해보기
################################################################################
# k가 1부터 train 행 수까지 변화할 때 분류 정확도 구하기
# 반복문 for 를 이용하여 k가 1부터 train 행 수까지 변화할 때 분류 정확도가 몇 % 되는지 그래프를 그려보고 최적의 k를 확인해 보자.

# 분류 정확도 사전 할당
accuracy_k <- NULL

# kk가 1부터 train 행 수까지 증가할 때 (반복문)
for(idx in c(1:nrow(train_x))){
  # k가 kk일 때 knn 적용하기
  set.seed(1234)
  knn_k <- knn(train = train_x, test = valid_x, cl = train_y, k = idx)

  # 분류 정확도 계산하기
  accuracy_k <- c(accuracy_k, sum(knn_k == valid_y) / length(valid_y))
}

# k에 따른 분류 정확도 데이터 생성
valid_k <- data.frame(k = c(1:nrow(train_x)), accuracy = accuracy_k)
colnames(valid_k)

# k에 따른 분류 정확도 그래프 그리기
plot(formula = accuracy ~ k, data = valid_k, type = "o", pch = 20, main = "validation - optimal k")

# # 그래프에 k 라벨링 하기
# with(valid_k, text(accuracy ~ k, labels = rownames(valid_k), pos = 1, cex = 0.7))

# 분류 정확도가 가장 높으면서 가장 작은 k의 값 구하기
sort(valid_k$accuracy, decreasing = T)
maxdata <- max(valid_k$accuracy) # 0.8518519
maxdata
min_position <- min(which(valid_k$accuracy ==maxdata))
min_position

# min_position의 값과 그래프에서 확인해 보면 적정 k값을 확인할 수 있다.
# 그럼 이제 k가 min_position의 값을 가질 때 모델이 얼마나 분류가 잘 되는지 test 데이터를 이용해서 표현해보자.

# 최적의 k 값에 test 데이터 적용하기
set.seed(1234)
knn_optimization <- knn(train = train_x, test = test_x, cl = train_y, k = min_position)

# # Confusion Matrix 틀 만들기
# result <- matrix(NA, nrow = 3, ncol = 3)
# rownames(result) <- paste0("real_", levels(train_y))
# colnames(result) <- paste0("clsf_", levels(train_y))
# result
# 
# # Confusion Matrix 값 입력하기
# result[1, 1] <- sum(ifelse(test_y == "setosa" & knn_optimization == "setosa", 1, 0))
# result[2, 1] <- sum(ifelse(test_y == "versicolor" & knn_optimization == "setosa", 1, 0))
# result[3, 1] <- sum(ifelse(test_y == "virginica" & knn_optimization == "setosa", 1, 0))
# 
# result[1, 2] <- sum(ifelse(test_y == "setosa" & knn_optimization == "versicolor", 1, 0))
# result[2, 2] <- sum(ifelse(test_y == "versicolor" & knn_optimization == "versicolor", 1, 0))
# result[3, 2] <- sum(ifelse(test_y == "virginica" & knn_optimization == "versicolor", 1, 0))
# 
# result[1, 3] <- sum(ifelse(test_y == "setosa" & knn_optimization == "virginica", 1, 0))
# result[2, 3] <- sum(ifelse(test_y == "versicolor" & knn_optimization == "virginica", 1, 0))
# result[3, 3] <- sum(ifelse(test_y == "virginica" & knn_optimization == "virginica", 1, 0))
# 
# # Confusion Matrix 출력하기
# result

# 최종 정확도 계산하기
table(prediction=knn_optimization, answer=test_y)
# 해석
# setosa와 virginica 품종은 분류가 잘 되었다.
# 그리고 실제 versicolor의 7건은 virginica로 분류가 잘못 되었다.
# 최종적으로 이 데이터에 대한 모델의 분류 정확도는 75.86% 라고 결론 지을 수 있다.

# 정확도
accuracy <- sum(knn_optimization == test_y) / sum(result)
accuracy