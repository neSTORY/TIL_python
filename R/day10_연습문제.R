library(arules)


data(Epub)
Epub

summary(Epub)
# -> 15729건의 데이터와 936가지의 책이 있음을 확인
# -> Max값이 58인데 58권을 빌린 사람이 있음..

inspect(Epub[1:10])

# 많이 빌리는 도서 목록
sort(itemFrequency(Epub,type="absolute"), decreasing = T)[1:20]
itemFrequencyPlot(Epub, type="absolute", topN=20) # ,상위 20개 시각화
itemFrequencyPlot(Epub, support=0.012) # 지지도가 0.012 이상인 도서

# 연관규칙분석 적용
Epubrules <- apriori(Epub, parameter = list(support=0.001, confidence=0.1, minlen=2))

summary(Epubrules) # 120개의 규칙 생성

# 지지도, 신뢰도, 향상도 확인
# 향상도가 매우 높음-> 확인해 볼 필요가 있음
inspect(sort(Epubrules, by="lift")[1:20])

# 지지도를 중위값으로 넣어서 규칙생성을 해보자
Epubrules2 <- apriori(Epub, parameter = list(support=0.0012, confidence=0.25, minlen=2))
summary(Epubrules2)

inspect(sort(Epubrules2, by="lift")[1:30])

# -> 책의 일련번호가 비슷한것의 향상도가 높음
# -> 시리즈이거나 같이 읽어야 의미있는 책인것 같다.
# -> 그런데 count는 전체 데이터에 비해 매우 적은걸 봐선 특정 사람들만 읽는 전문서적인듯 하다.

# !! support=0.001 설정한 연관규칙에서 doc_6e7,8,9 관련 1,2,3번 규칙에서 
# 8,9번을 읽은 사람들이 7번을 읽을 읽을 조건부확률이 가장 높은걸 보아 doc_6e7이
# 시리즈의 첫 번째 순서인것 같다.

doc_506rules <- subset(Epubrules2, items %in% "doc_506")
inspect(doc_506rules)
# -> 506, 507도 관련이 높은걸 볼 수 있음

# 그렇다면 제일 많이 빌린 책들의 연관규칙분석은 어떨까?
# 10권만 뽑아서 규칙을 확인해 보자

most <- as.data.frame(sort(itemFrequency(Epub,type="absolute"), decreasing = T)[1:10])
most <- as.vector(row.names(most))
most

mostRules <- subset(Epubrules, items %in% most)
inspect(mostRules)

# -> 많이 빌린다고 해서 규칙의 향상성이 높은건 아니다.




















