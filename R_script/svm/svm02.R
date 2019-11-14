library(kernlab)

str(iris)
unique(iris$Species)

idx <- sample(1:nrow(iris), 0.6 * nrow(iris))
training <- iris[idx, ]
testing <- iris[-idx, ]

model <- ksvm(Species ~ ., data = training, kernel = 'vanilladot')
pred <- predict(model, testing)
prop.table(table(pred == testing$Species))

