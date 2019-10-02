# 다음과 같은 벡터 객체를 생성하시오.
# 문제01) vector01 벡터 변수를 만들고, 'K' 문자가 5회 반복되도록 하시오.   
vector01 <- rep('K', 5)
# 문제02) vector02 벡터 변수에 1~10까지 숫자 중에서 홀수만 포함시키시오.
vector02 <- seq(1,10,2)
# 문제03) vector03에는 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.  
vector03 <- rep(seq(1,10,3), each = 3)
# 문제04) vector04에는 vector02~vector03가 모두 포함되는 벡터를 만드시오.    
vector04 <- c(vector02, vector03)
# 문제05) seq() 함수를 이용하여 25에서 -15까지 -5간격으로 벡터를 생성하시오.
vector05 <- seq(25, -15, -5)
# 문제06) seq() 함수를 이용하여 vector04에서 홀수번째 값들만 선택하여 vector05에 할당하시오.
vector06 <- vector04[seq(1, length(vector04), 2)]

vector01
vector02
vector03
vector04
vector05
vector06
