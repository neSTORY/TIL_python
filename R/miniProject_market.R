# install.packages('arulesViz')
library(arules)
library('arulesViz')
library(cluster)
library(RColorBrewer)

# 1. 연관규칙
# Market_Basket_Optimisation 데이터를 분석하여 마트의 수익을 최대로 하기 위한 
# 다양한 전략을 세워보세요. (시각화도 함께 해주세요)
# ex) 상품 배치, 묶음 판매, 특정 상품에 대한 판매 전략 등

# 주어진 데이터를 활용하여 마트의 수익을 최대화하기위한 방법이 뭐가 있을까?
# -> 수요예측, 상품 배치를 통한 노동효율 상승, 묶음 판매 ..

market <- read.transactions("Market_Basket_Optimisation.csv", sep = ",")

inspect(market[1:20])

summary(market)
# density = 0.03으로 그 동안의 데이터셋과 비교하면 공백은 그렇게 많은건 아닌것 같다
# 7501건의 데이터와 119개의 아이템 확인

# 제일 많이 팔린 상품은 물, 계란, 스파게티, 감자튀김, 초콜릿이다
# 가장 많이 산 사람의 품목은 20개로 그렇게 많지는 않은것을 확인

sort(itemFrequency(market[1:30]), decreasing = T)
# 물이 전체의 3분의 1을 차지

# 많이 팔린 15개 품목 시각화
itemFrequencyPlot(market, topN=15, type="absolute")


# ============================================================================ #


market.rules <- apriori(market, parameter = list(support=0.006, confidence= 0.25, minlen=2))
market.rules
# 272개 규칙 생성
summary(market.rules)
# 지지도의 최대값은 0.06, 신뢰도 최대값은 0.57, 향상도 최대값은 4.1

# 향상도 상위 30개 출력
inspect(sort(market.rules, by="lift")[1:30])

# 연관규칙 시각화
plot(sort(market.rules, by="lift")[1:30], method="grouped")

# (통밀파스타, 올리브오일), (향신료, 고기), (물과 새우, 냉동야채) ... 순으로 있다.
# -> 묶음 판매를 한다면 이런 품목들을 묶어서 팔면 효율이 높을듯 하다.


# 좀 더 다양한 품목과 의외성을 갖는 제품들을 찾기 위해 더 많은 규칙을 찾아보자

# 향상도 기준 200개 규칙 모두 출력
inspect(sort(market.rules, by="lift")[1:100])
inspect(sort(market.rules, by="lift")[101:200])

# 의외성을 갖는 규칙들을 뽑아보자

# 3 {mineral water,shrimp} => {frozen vegetables}
# 16 {chocolate,olive oil} => {spaghetti}
# 26 {chocolate,ground beef} => {spaghetti}
# 58 {light cream} => {mineral water}


# ============================================================================ #



# 규칙들 중 상당수는 물과 연관된 규칙들이 많다.
# 물은 어떤 품목과 연관이 되어도 이상하지 않다. 
# 그렇다면 rhs에서 물을 제외한 품목들의 연관규칙을 찾아보자

# rhs에서 물이 포함된 boolean 형태로 만들었다.
market.rules@rhs %in% c("mineral water") # transactions에서 컬럼참조시 @를 사용한다!

# 물을 제외한 규칙을 보기위하여 !를 붙여 반대로 출력해보자
water.remove <- market.rules[!(market.rules@rhs %in% "mineral water")]

inspect(sort(water.remove, by="lift"))

# rmWater.df <- as.data.frame(inspect(water.remove))
# 
# rmWater.df[c("lhs","rhs","count")][1:30,]

# 여기서 의외성을 갖는 연관규칙을 찾아보자


# [60]  {mineral water,pancakes}          => {spaghetti}         0.011465138 0.3399209  0.03372884 1.952333  86
# [63]  {cereals}                         => {green tea}         0.006532462 0.2538860  0.02572990 1.921694  49
# [76]  {salmon}                          => {spaghetti}         0.013464871 0.3166144  0.04252766 1.818472 101
# [80]  {almonds}                         => {eggs}              0.006532462 0.3202614  0.02039728 1.782108  49
# [82]  {french fries,spaghetti}          => {chocolate}         0.007998933 0.2898551  0.02759632 1.769083  60
# [105] {green tea,spaghetti}             => {chocolate}         0.007065725 0.2663317  0.02652980 1.625512  53
# [114] {light mayo}                      => {french fries}      0.007332356 0.2696078  0.02719637 1.577479  55
# [121] {salmon}                          => {chocolate}         0.010665245 0.2507837  0.04252766 1.530617  80
# [123] {pancakes}                        => {spaghetti}         0.025196640 0.2650771  0.09505399 1.522468 189

# 이번에는 plot을 활용하여 그래프형태로 시각화를 해보자
plot(market.rules[1:50], method='graph', control=list(types='items'))
# 물을 뺀 규칙들 시각화
plot(water.remove[1:50], method="graph", control=list(types="items"),
     vertex.size = 3, # 점 크기
     vertex.label.cex = 5, # 점 레이블 크기
     vertex.label.dist=1
     )

# 물 다음으로 많은 연관 규칙을 갖는 스파게티는 만들때 같이 사용할만한
# 재료들과 연관이 높았다.

# 그중에서 herb&pepper는 많이 팔리는 품목 중 하나인 스파게티와도 또 고기와도
# 연관성이 높았다.

# 의외로 연어가 초콜릿, 스파게티와 향상도가 높았다.

# ============================================================================ #

# 향상도도 중요하지만 전체 건수가 높은 규칙들도 중요한 것 같다.
# 판매건수가 100건 이상이고 향상도도 2 이상인 규칙들을 찾아보자
inspect(sort(subset(water.remove, subset=(count>100 & lift>2), by="count")))

# 향상도도 높고 판매건수도 높은 연관규칙으로는 (ground beef, spaghetti),
# (herb & pepper, ground beef), (spaghetti, milk), (soup, milk),
# (chocolate, milk)가 있다.

# herb&pepper는 계속 튀어나오는걸 보아 얘는 정말 스파게티 또는 ground beef와
# 묶어서 판매하는게 좋을것 같다.

# ============================================================================ #

# <etc>

# 단가가 괜찮은 와인과 관련된 규칙들을 찾아보자
inspect(subset(market.rules, items %pin% "wine"))
# -> 프렌치와인과 스파게티, 레드와인과 계란을 사네..

# 내가 좋아하는 연어도 한번 보자
inspect(subset(market.rules, items %in% "salmon"))
# -> 연어랑 초콜릿은 참 의외다.

# ============================================================================ #

# 데이터프레임으로 변환 후 분석

market_df <- as(market.rules, "data.frame")
market_df

market_df_z <- as.data.frame(lapply(market_df[2:5], scale))
market_cluster <- kmeans(market_df_z, 3)

market_df$cluster <- market_cluster$cluster

market_df

ggplot(data=market_df[1:50,], aes(x=confidence,y=lift, col=cluster))+geom_point()
