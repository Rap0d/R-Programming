# install.packages('cvTools')
library(cvTools)
library(party)

myframe <- data.frame(col=c(1:10))
# myframe

cross <- cvFolds(n=nrow(myframe), K=5, R=2)
# str(cross)
# cross

# names(cross)

# cross$which

# cross$subsets[cross$which == 4, 2]

# K fold cross validation data creation
# 의사 검정 트리
k_value <- 3
r_value <- 2
cross <- cvFolds(n=nrow(iris), K=k_value, R=r_value)
# cross

# str(cross)
# length(cross$which)

# dim(cross$subsets)
# table(cross$which)

# 데이터 프레임의 관측치 적용 하기
# For Loop
R <- 1:r_value
K <- 1:k_value
cnt <- 0 # 총 시행 횟수 = k_value * r_value
accuracy <- numeric() # 분류 정확도를 위한 벡터

for(r in R) {
    for(k in K) {
        idx <- cross$subsets[cross$which == k, r]
        training <- iris[-idx,]
        testing <- iris[idx,]

        myformula <- Species ~ .
        model <- ctree(formula=myformula, data=training)

        pred <- predict(model, testing)
        mytable <- table(pred, testing$Species)

        # print(mytable)
        # print('==================================================')

        cnt <- cnt + 1
        accuracy[cnt] <- (mytable[1,1] + mytable[2,2] + mytable[3,3]) / sum(mytable)
    }
}
cnt

accuracy
round(100 * mean(accuracy), 4)