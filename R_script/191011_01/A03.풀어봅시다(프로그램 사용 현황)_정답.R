# plyr 패키지와 'progbook.csv' 파일을 이용하여 다음 물음에 답하세요.
# 프로그램의 이름과 판매 수량과 단가를 저장하고 있는 파일의 내용을 읽어 들인다.

programming <- read.csv('progbook.csv', header=T)

# 실습 : 프로그래밍별 총 판매 수량과 총 판매 금액
result1 <- ddply(programming, 'name', summarise, sum_qty=sum(qty), sum_price=sum(price))
#     name sum_qty sum_price
# 1  C언어      29     26000
# 2    JSP      15      9500
# 3 Python      35      3500
# 4   자바      19      9000

# 총 판매 금액으로 막대 그래프 그리기 
chart01 <- result1$sum_price
names(chart01) <- result1$name
chart01
barplot(chart01, col=rainbow(length(chart01)))

# 실습 : 프로그래밍별 최대 판매 수량과 최소 판매 금액
result2 <- ddply(programming, 'name', summarise, max_qty=max(qty), min_price=min(price))
# 출력 결과
#     name max_qty min_price
# 1  C언어      13      5000
# 2    JSP       7      2000
# 3 Python      15       900
# 4   자바      10      1000

# 최소 판매 금액으로 수평 막대 그래프 그리기 
# horiz = TRUE 옵션을 사용하면 된다.
chart02 <- result2$min_price
names(chart02) <- result2$name
chart02
barplot(chart02, col=rainbow(length(chart01)), horiz = TRUE)

# 실습 : 년도별 이름별 최대 판매 수량과 최저 가격 구하기

ddply(programming, c('year', 'name'), summarise, max_qty=max(qty), min_price=min(price))

#    year   name max_qty min_price
# 1  2000  C언어       6      5000
# 2  2000    JSP       7      3500
# 3  2000 Python       9       900
# 4  2000   자바       2      1000
# 5  2001  C언어      10      8000
# 6  2001    JSP       3      2000
# 7  2001 Python      15      1500
# 8  2001   자바       7      3000
# 9  2002  C언어      13     13000
# 10 2002    JSP       5      4000
# 11 2002 Python      11      1100
# 12 2002   자바      10      5000
