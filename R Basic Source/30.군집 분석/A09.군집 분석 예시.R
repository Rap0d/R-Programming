customers <- read.csv('mydata02.csv', header=T)

head( customers )# 데이터 정보 조회

# customers 변수에 들어 있는 데이터 테이블의 내부 구조를 조회
str( customers )
# 'data.frame':   150 obs. of  4 variables:
#  $ usage  : num  3.37 3.72 5.41 5.94 2.39 7.63 2.74 0.08 2.54 5.48 ...
#  $ amount : num  5.67 7.6 1.98 6.27 3.21 4.12 5.73 7 7.07 4.63 ...
#  $ period : num  7.81 2.08 6.86 1.29 5.65 5.71 3.09 3.22 2.01 4.07 ...
#  $ variety: num  0.5 5.37 0.26 1.49 6.35 0.78 2.12 2.5 6.03 3.96 ...

# customers 테이블의 각 변수 칼럼의 요약 통계량을 조회
summary( customers )
#      usage           amount          period         variety     
#  Min.   :0.050   Min.   :0.050   Min.   :0.010   Min.   :0.060  
#  1st Qu.:1.948   1st Qu.:2.260   1st Qu.:2.145   1st Qu.:1.762  
#  Median :3.655   Median :4.380   Median :4.170   Median :3.645  
#  Mean   :3.828   Mean   :4.153   Mean   :3.996   Mean   :3.712  
#  3rd Qu.:5.692   3rd Qu.:5.772   3rd Qu.:5.982   3rd Qu.:5.692  
#  Max.   :7.990   Max.   :7.990   Max.   :7.900   Max.   :7.740  

# 상자 수염 그래프를 이용한 각 변수 칼럼의 분포 비교
boxplot( customers, main='구매 이력 변수간 데이터 분포')
# 구매 이력 변수간 데이터 분포.png

# 계층적 군집 분석 패키지 설치 및 로딩
# cluster 패키지는 recommend 패키지라 인스톨하지 않아도 된다.
library( cluster )

# 계층적 군집 분석 실시
result <- hclust(dist(customers), method="ave")
result
# Call:
# hclust(d = dist(customers), method = "ave")
# 
# Cluster method   : average 
# Distance         : euclidean 
# Number of objects: 150 

# 계층적 군집 분석 그래프 그리기
plot(result, hang=-1)

# 시각화
rect.hclust(result, k = 3)
# 세개의 그룹으로 나눔.png

# 계층적 군집 분석으로 그룹핑된 관찰치
# 계층적 군집 분석 결과인 덴드로그램의 각 가지에 달린 개별 고객 아이디 넘버
# 제일 왼쪽 가지에 달린 고객 아이디 넘버가 90번이다.
result$order
#   [1]  90  19 139  28  46   4  44  58  82  34  77 119 101 131  18  23  27  79 146  52 109  43  47  98
#  [25] 102 108 114  75  13  35  83 148  14  30  54  65 115  38 124  68 138  37 129  48 126  12 121  29
#  [49]   3 110 118  61 142   6  33 144 150  22  50 116 137 120 122  99  15  95  59  55  94 128   5  57
#  [73]  11 141  21 135   9   2 107 132  72 104  36  64 106 143 105  93 100  40  81  56  67 133  25 147
#  [97]  49  31 145  71 134 149  76  10  20  17  85  86  42  16  41  62  32 127 140  60 111  53 125  80
# [121]  89  69  91 123   1  24 130 112  87  96  84  88  78   8  51  63  74  66  39 103  73   7 136  26
# [145]  45 113  92  97  70 117

# cutree : 원하는 군집 수로 자료를 분류해준다.
whatgroup <- cutree(result, k=3)

whatgroup # 각 항목들이 1, 2, 3 중의 하나으 그룹에 속해진다.
#   [1] 1 2 3 3 2 3 1 1 2 1 2 3 3 3 3 1 1 3 3 1 2 3 3 1 2 1 3 3 3 3 2 1 3 3 3 2 3 3 1 2 1 1 3 3 1 3 3 3
#  [49] 2 3 1 3 1 3 2 2 2 3 2 1 3 1 1 2 3 1 2 3 1 1 1 2 1 1 3 1 3 1 3 1 2 3 3 1 1 1 1 1 1 3 1 1 2 2 3 1
#  [97] 1 3 3 2 3 3 1 2 2 2 2 3 3 3 1 1 1 3 3 3 1 3 3 3 3 3 1 3 1 3 1 2 3 1 3 2 2 1 2 1 3 3 3 1 2 3 2 3
# [145] 2 3 2 3 1 3

customers2 <- data.frame( customers, group=whatgroup )

# group이라는 컬럼이 새로 생겼다.(값은 1~3까지....)
head( customers2 )
#   usage amount period variety group
# 1  3.37   5.67   7.81    0.50     1
# 2  3.72   7.60   2.08    5.37     2
# 3  5.41   1.98   6.86    0.26     3
# 4  5.94   6.27   1.29    1.49     3
# 5  2.39   3.21   5.65    6.35     2
# 6  7.63   4.12   5.71    0.78     3