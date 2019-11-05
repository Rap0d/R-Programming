str(iris)
head(iris)
unique(iris$Species)

# 학습 데이터와 검증 데이터를 7:3으로 분리
set.seed(1)
idx <- sample(1:nrow(iris), 0.7 * nrow(iris))
idx

training <- iris[idx, ]
testing <- iris[-idx, ]

dim(training)
dim(testing)

colnames(iris)
mFomula <- Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width
model <- lm(formula = mFomula, data = training)
model

vif_res <- vif(model)
table(vif_res >= 10)
# FALSE  TRUE 
# 1     2 

cor(iris[,-5])
#             Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
# Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
# Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
# Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000

mFomula <- Sepal.Length ~ Sepal.Width + Petal.Length
model <- lm(formula = mFomula, data = training)
model
# FALSE 
# 2 

vif_res <- vif(model)
table(vif_res >= 10)

predictData <- predict(model, testing)
predictData[1:5]
# 3        4        5        8        9 
# 4.756282 4.790010 5.060498 4.981578 4.613506 

cor(predictData, testing$Sepal.Length)

