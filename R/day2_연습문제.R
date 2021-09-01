library(dplyr)

# 1.시험 점수 변수 만들고 출력하기

df <-  data.frame(student=c("A","B","C","D","E"),
                score=c(80, 60, 70, 50, 90))

# 2.전체 평균 구하기

mean(df$score)

# 3.전체 평균 변수 만들고 출력하기

avg <- mean(df$score)
avg

# 4.data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요.

df1 <- data.frame("제품"=c("사과","딸기","수박"),
                  "가격"=c(1800,1500,3000),
                  "판매량"=c(24,38,13))
df1

# 5.앞에서 만든 데이터 프레임을 이용해서 과일 가격 평균, 판매량 평균을 구해보세요

df1 %>%
  summarise(avg_price = mean(df1$가격),
            avg_sale = mean(df1$판매량))

# 6.

# 6-1.
mpg <- ggplot2::mpg
mpg

# 6-2.
mpg <- rename(mpg, city = cty, highway = hwy)
head(mpg)

# 6-3.
# sol-1. 두 개의 벡터 생성 후 합치기
low_dipl <-   mpg %>%
              filter(displ<=4) %>% 
              summarise(under4_avg = mean(highway))
high_dipl <-  mpg %>%
              filter(displ>4) %>% 
              summarise(over4_avg = mean(highway))
cbind(low_dipl,high_dipl)


# sol-2. 연비 4를 기준으로 그룹화하여 summarise하기
mpg %>% 
  mutate(under4 = (displ<=4)) %>% 
  group_by(under4) %>% 
  summarise(avg_highway = mean(highway)) %>% 
  arrange(desc(under4))

# -> 배기량이 4이하인 자동차가 평균적으로 연비가 더 높다

# 6-4.
mpg %>%
  group_by(manufacturer) %>% 
  filter(manufacturer=="audi"|manufacturer=="toyota") %>%
  summarise(mean_city = mean(city))
# -> toyota의 도시연비가 더 높다

# 6-5.
mpg %>%
  group_by(class) %>%
  filter(class=="suv"|class=="compact") %>% 
  summarise(mean_city = mean(city))
# -> 소형차가 suv보다 도시연비가 더 높다

# 7.

sam <- read.csv("samsung.csv")
# head(sam)

# 7-1.
sam <- sam %>% 
            select(-Date)

# 7-2.
apply(sam,2,min)
apply(sam,2,max)
apply(sam,2,mean)
apply(sam,2,sd)

# 7-3.
# 정규화
head(apply(sam,2, function(x){(x-min(x))/(max(x)-min(x))}))
# 표준화
head(apply(sam, 2, function(x){(x-mean(x))/sd(x)}))

# 7-4.
difHigh <- c()
for (i in 1:length(sam$High)){
  if (i != length(sam$High))
  difHigh <- append(difHigh,sam$High[i+1]-sam$High[i])
}
cat("High열의 최대값은",max(abs(difHigh)),"입니다.")

difLow <- c()
for (i in 1:length(sam$Low)){
  if (i != length(sam$Low))
    difLow <- append(difLow,sam$Low[i+1]-sam$Low[i])
}

cat("Low열의 최대값은",max(abs(difLow)),"입니다.")
