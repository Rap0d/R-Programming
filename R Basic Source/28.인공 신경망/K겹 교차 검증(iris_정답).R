# install.packages('cvTools') # 교차 검정을 위한 패키지
# install.packages('party')
library(party)
library(cvTools)

# 1부텨 10까지의 정수를 5겹으로 나누기
myframe <- data.frame(col=c(1:10))
myframe
cross <- cvFolds(n=nrow(myframe), K=5, R=2)
str(cross)
cross

names(cross)
# [1] "n"       "K"       "R"       "subsets" "which"  

cross$which

# K겹 교차 검정 데이터 생성
k_value = 3
r_value = 2
cross <- cvFolds(n=nrow(iris), K=k_value, R=r_value)
 
# 교차 검정 데이터 구조 보기
str(cross)
length(cross$which)

dim(cross$subsets)
# [1] 150   2

table(cross$which)

# 데이터 프레임의 관측치 적용 하기
# 반복문 사용하기
R=1:r_value
K=1:k_value
cnt = 0
accuracy <- numeric() # 분류 정확도

for( r in R ){
  cat('\nR=', r, '\n')
  
  for( k in K){
    idx <- cross$subsets[ cross$which == k, r]
    
    testing <- iris[ idx, ]
    cat('testing : ', nrow(testing), '\n')
    
    # training 생성
    myformula <- Species ~ .
    
    training <- iris[ -datas_idx, ]
    cat('training : ', nrow(training), '\n')
    
    # model 생성
    model <- ctree(formula = myformula, data = training )
    pred <- predict(model, testing)
    mytable <- table(pred, test$Species )
    print( mytable )
    print('=============================================')
    cnt <- cnt + 1
    accuracy[cnt] <- (mytable[1,1] + mytable[2,2] + mytable[3,3]) / sum(mytable)
  } # outer for K
} # outer for R

cnt
# [1] 6

accuracy
round(100*mean(accuracy), 4)

