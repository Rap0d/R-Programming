# dim : 행렬 정보 보기 
dim(available.packages())

# 앞 행 6줄 보기
head(available.packages())

# 현 사용자의 세션 정보 보기 
sessionInfo()

# 이미 설치된 패키지 목록 
installed.packages()

# 이미 로딩되어 있는 패키지 목록 
search()

# ggplot으로 막대 그래프 그리기 
install.packages("ggplot2")

# ggplot 로드하기
library(ggplot2)

# plot 그래프 그려보기
x <- c('a', 'a', 'b', 'c')
x
qplot(x)

