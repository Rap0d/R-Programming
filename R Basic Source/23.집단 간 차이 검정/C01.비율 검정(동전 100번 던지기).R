# 파일 이름 : 비율 검정(동전 100번 던지기).R

# 연구 환경
# 동전 던지기를 100번 시행했더니 42번 나왔다고 가정하자.
# 이때 동전의 앞면이 나오는 비율이 50%라고 얘기할 수 있나요?

# 앞면과 뒷면을 2개의 집단이라고 보면 2진단에 대한 비율 검정이다.

# 귀무 가설 : '두 그룹의 비율이 같다'

# prop.test(성공한횟수, 전체시도회수)
prop.test(42, 100, p=0.5)
# 
#         1-sample proportions test with continuity correction
# 
# data:  42 out of 100, null probability 0.5
# X-squared = 2.25, df = 1, p-value = 0.1336
# alternative hypothesis: true p is not equal to 0.5
# 95 percent confidence interval:
#  0.3233236 0.5228954
# sample estimates:
#    p 
# 0.42

# 풀이하기
# 수행된 결과를 보면 p-value( 0.1336 ) > 0.05이므로 귀무 가설이 채택되었다.

# 귀무 가설은 '두 그룹의 비율이 같다'이므로, 앞면이 나올 확률은 50%라고 볼 수 있다. 

# 이는 신뢰 구간(0.3233236, 0.5228954)으로도 확인이 가능한데, 
# 0.5가 신뢰 구간에 포함이 되어 있는 것으로도 확인이 가능하다.