install.packages("arules")
library(arules)

# read.csv("groceries.csv") # 컬럼개수가 첫 번째 행으로 읽혀짐
# -> 이런 데이터는 read.transactions로 읽어줘야 함

groceries <- read.transactions("groceries.csv", sep=",")
# 9835행 169열 => 9835건의 거래, 169개 상품

summary(groceries)
# size -> 1개 산 데이터가 2159개, 2개 산 데이터가 1643..

# transactions의 데이터를 확인할 때는 inspect함수 사용
inspect(groceries)
inspect(groceries[1:10])

# 아이템의 빈도를 내림차순으로 정렬
sort(itemFrequency(groceries),decreasing = T)

# 아이템의 건수를 보고싶을땐 type파라미터를 "absolute"로 설정
itemFrequency(groceries, type="absolute")

# 컬럼을 지정해서 사용 가능
itemFrequency(groceries[,1:3])

# 시각화
itemFrequencyPlot(groceries, type="absolute")

# 가장 많이 팔린 20개만 시각화
itemFrequencyPlot(groceries, topN=20, type="absolute")

# 지지도가 0.1 이상인 상품 시각화
itemFrequencyPlot(groceries, support=0.1)

mat <- matrix(c(1,1,1,0,0,
         1,1,1,1,0,
         0,0,1,1,0,
         0,1,0,1,1,
         0,0,0,1,0),ncol = 5,byrow = T)
# ncol: 열의 개수 지정, byrow: 행 기준으로 데이터가 들어감(default값은 FALSE)       

mat

# 행 이름 변경하기
paste("row", 1:5) # 공백o
rownames(mat) <- paste0("row",1:5) # 공백x

mat # 변경 확인

# 열 이름 변경하기
colnames(mat) <- letters[1:5] # a~e까지

mat # 변경 확인

# row는 거래 데이터(장바구니)를 의미, col는 아이템 이름을 의미한다고 가정

str(mat)
class(mat)

# 행렬 데이터를 transactions 데이터로 변환
mat.trans <- as(mat, "transactions") # as(data, 변경class)
mat.trans

summary(mat.trans)
inspect(mat.trans)

# 데이터프레임으로 변경
df <- as.data.frame(mat)

# 데이터프레임을 트랜잭션으로 변경
df.trans <- as(df, "transactions")
# 경고가 나오는 이유는 데이터프레임이 수치데이터로 구성되어 있어서 발생

# 수치(numeric) 데이터가 저장된 데이터프레임 -> logical 데이터로 변환된 데이터프레임
df <- as.data.frame(sapply(df, as.logical))
df.trans <- as(df, "transactions")
df.trans

str(df.trans)
summary(df.trans)
inspect(df.trans)

# list데이터를 transactions 데이터로 변환

myList <- list(row1=c("a","b","c"),
             row2=c("a","d"),
             row3=c("b","e"),
             row4=c("a","d","e"),
             row5=c("b","c","d"))

myList
myList.trans <- as(myList, "transactions")
myList.trans # list는 변환이 잘 됨을 확인

summary(myList.trans)
inspect(myList.trans)

# ============================================================================= #

# groceries 데이터에 관해서 연관규칙 생성

groceryrules <- apriori(groceries, parameter = list(support=0.006, confidence=0.25, minlen=2))
# -> minlen의 default값은 공집합도 나타내기 때문에 2로 설정

groceryrules
inspect(groceryrules[300:350])
inspect(groceryrules[1:10])

summary(groceryrules)

# 보기 편하게 정렬을 해보자
inspect(sort(groceryrules, by="lift")[1:10])

# 관심있는 상품에 대한 연관규칙을 검색
# ex) beef와 함께 묶어서 판매할만한 상품?
beefrules <- subset(groceryrules, items %in% "beef")
inspect(beefrules)
inspect(sort(beefrules, by="lift")[1:5])

write(beefrules, file="beefrules.csv", sep=",", row.names=FALSE, quote=TRUE)

groceryrules_df <- as(groceryrules,"data.frame")
groceryrules_df










