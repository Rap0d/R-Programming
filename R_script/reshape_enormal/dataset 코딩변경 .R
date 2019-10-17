# 코딩 변경 : 가독성을 위한 코딩 변경
# 최초 코딩 내용을 용도에 맞게 변경하는 작업.
# 이러한 코딩 변경은 데이터의 가독성, 척도 변경, 인코딩 변경등이 있다.

# 1, 2의 숫자를 남성, 여성 등으로 변경하면 가독성이 좋아짐
# like enum : 척도



dataset <- read.csv('dataset.csv', header = T)
dataset <- subset(dataset, dataset$price >= 2 & dataset $ price <= 8)
nrow(dataset)

# dataset$새컬럼[조건식] <- '값'
unique(dataset$resident)
dataset$resident2[dataset$resident == 1] <- '서울시'
dataset$resident2[dataset$resident == 2] <- '인천시'
dataset$resident2[dataset$resident == 3] <- '대전시'
dataset$resident2[dataset$resident == 4] <- '대구시'
dataset$resident2[dataset$resident == 5] <- '부산시'

head(dataset[c('resident', 'resident2')])

# job : 공무원, 회사원, 개인사업
unique(dataset$job)
dataset$job2[dataset$job == 1] <- '공무원'
dataset$job2[dataset$job == 2] <- '회사원'
dataset$job2[dataset$job == 3] <- '개인사업'
head(dataset[c('job', 'job2')])

# 척도 변경
sort(unique(dataset$age))
dataset$age2[dataset$age <= 30] <- '청년층'
dataset$age2[dataset$age <= 60 & dataset$age > 30] <- '중년층'
dataset$age2[dataset$age > 60] <- '장년층'
head(dataset[c('age', 'age2')])

survey <- dataset$survey
maxval <- max(survey)
csurvey <- maxval + 1 - survey
dataset$survey2 <- csurvey
head(dataset[c('survey', 'survey2')])