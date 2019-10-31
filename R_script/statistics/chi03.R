# 교육 수준(education)과 흡연율(smoke) 간의 관련성을 분석하기 위한 연구 가설을 수립하고, 각 단계별로 가설을 검정하시오. [독립성 검정]
# 귀무 가설(H0) : 교육 수준과 흡연율 간의 관련성은 없다.
# 연구 가설(H1) : 교육 수준과 흡연율 간의 관련성은 있다.
# 
# 단계1: 파일 가져오기
# 단계2: 코딩 변경(변수 리코딩)
# 단계3: 교차 분할표 작성
# 단계4: 독립성 검정
# # CrossTable() 함수 사용
# 
# 단계5: 검정 결과 해석

library(ggplot2)
library(gmodels)

smoke <- read.csv('smoke.csv', header = T)
smoke
unique(smoke$education)
unique(smoke$smoke)

smoke$education2 <- factor(smoke$education, levels = c(1, 2, 3), labels = c('대졸', '고졸', '중졸'))
smoke$education2

smoke$smoke2 <- factor(smoke$smoke, levels = c(1, 2, 3), labels = c('과대흡연', '보통흡연', '비흡연'))
smoke$smoke2

mTable <- table(smoke$education2, smoke$smoke2)
mTable

mFrame <- data.frame(mTable)
colnames(mFrame) <- c('학력', '흡연여부', '빈도수')

mFrame

ggplot(mFrame, aes(x = 학력, y = 빈도수, fill = 흡연여부, col = 흡연여부)) + geom_col(position = 'Dodge') + theme_minimal(base_family = 'AppleGothic')

CrossTable(smoke$education2, smoke$smoke2, chisq = T)

# Pearson's Chi-squared test 
# ------------------------------------------------------------
# Chi^2 =  18.91092     d.f. =  4     p =  0.0008182573 

# 검정 결과 p 값이 0.05보다 작으므로 귀무 가설을 기각 한다. 