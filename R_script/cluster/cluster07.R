data <- read.csv('snsdata.csv', header = T)

head(data)
summary(data)
dim(data)

table(is.na(data))

table(data$gender, useNA = 'ifany')

data$female <- ifelse(data$gender == 'F', 1, 0)

data$age <- ifelse(data$age > 10 & data$age < 20, data$age, NA)
boxplot(data$age)
summary(data$age)

df <- data.frame(A = c(1, 2, 3, 4), B = c('a', 'a', 'b', 'b'))
ave(df$A, df$B)

avgAge <- ave(data$age, data$gradyear, FUN = function(x) {mean(x, na.rm = T)})
avgAge

data$age <- ifelse(is.na(data$age), avgAge, data$age)
boxplot(data$age)

# 선호도 컬럼
interests <- data[5:40]
range(interests)
# [1]   0 327

# Z 점수 일반화
interestsZ <- as.data.frame(lapply(interests, scale))
interestsZ

# kmeans
teenClusters <- kmeans(interestsZ, 5)
names(teenClusters)

data$cluster <- teenClusters$cluster

# head 5
data[1:5, c('cluster', 'gender', 'age', 'friends')]

# aggregate() func : 집계 함수
# 군집별 평균 나이
aggregate(data = data, age ~ cluster, mean)

# 군집별 친구 수의 평균
aggregate(data = data, friends ~ cluster, mean)
aggregate(data = data, female ~ cluster, mean)

# 군집을 살펴 보면 각 그룹의 주요 관심 분야를 목록화할 수 있다.
# cluster4를 예를 들면 basketball, football, soccer, volleyball 등이 주요 관심 목록이다.
# 이러한 표를 고려하여 다섯 부류의 청소년들의 차이를 구분하면 된다.
# Princesses(공주), Brains(영리한 학생), Criminals(범죄자)
# Atheletes(운동 선수), Basket Case(무기력한 학생)
