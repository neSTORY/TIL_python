이미지 데이터의 픽셀이 100x100 픽셀이면
이 이미지 한 장의 차원은 100*100인 1만 차원이 된다
=> 이미지가 한 장당 10000개의 픽셀을 갖기 때문에 100차원이 아니라 10000차원이 된다.
이미지 한 장을 보통의 경우는 하나의 데이터 인스턴스로 봐야하기 때문에 행이 하나인 1만차원
으로 해석한다.


클러스터링? 특성이 비슷한 데이터끼리 묶어주는 머신러닝 기법
1. k값을 정해줌 -> k개의 중심점 생성(랜덤)
2. 각 중심점과 데이터 사이 거리를 구함
3. 가까운 중심점에 데이터를 할당
4. 각 클러스터에 소속된 데이터의 중심점을 구함
5. 중심점을 업데이트 -> 2번으로 이동
6. 2-5번 과정을 계속반복 -> 중심점 업데이트가 더 이상 발생하지 않을 때까지 반복

# rnorm : 평균이 0, 표준편차가 1인 랜덤데이터 생성
mean(rnorm(100))
sd(rnorm(100))

# class : 데이터 타입 리턴
class(rnorm(100)) # numeric : 벡터

x <- matrix(rnorm(100), nrow=5) # 5행인 행렬로 만들어줌
x # -> 5행 20열(5건의 데이터, 각각의 데이터는 20차원 데이터)

첫 번째 데이터(점)의 좌표 예시
(-0.5797314 -0.9340000 -0.6575662  0.08057641  0.5521594  0.8335417  0.4218999  0.4047983,
 ......, -0.6274794)

dist(x) # 점들 사이의 거리

x1 <- c(10,20,1,2,3,4)
y1 <- c(5,6,7,8,9,10)

a <- rbind(x1,y1)
a

dist(a)



teens <- read.csv("snsdata.csv")
str(teens)
table(teens$gender, useNA = "ifany") # 종류별 값 리턴 (value_counts랑 비슷)
# NA 값을 알고싶다면 useNA 파라미터 사용

summary(teens$age)

teens$age <- ifelse(teens$age>=13 & teens$age<20, teens$age, NA)
summary(teens$age)

mean(teens$age, na.rm = TRUE)

teens$gender <- ifelse(teens$gender=="F",1,0) # NA는 연산에 참여가 안됨
# NA를 M 또는 F로 대체

# 성별 값 자체에 초점을 두고(NA를 빼고)
teens$female <- ifelse(teens$gender=="F" & is.na(teens$gender),1,0)
# F이면서 NA값이 아니면 1 그 외는 0 => "여성"이냐 아니냐에 초점을 맞춤

teens$no_gender <- ifelse(is.na(teens$gender),1,0)
table(teens$no_gender) # NA인지 아닌지

table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")


str(teens)

aggregate(data=teens, age ~ gradyear, mean)
# gradyear -> age -> mean
# 졸업년도별로 나이들의 평균

aggregate(data=teens, age ~ gradyear, mean, na.rm=TRUE)

ave_age <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x,na.rm=TRUE))

2006 -> 18.65586
2007
...
2009

teens$age
table(ave_age)

teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

summary(teens$age)

head(teens,5)

interests <- teens[5:40]
interests

str(interests)

summary(interests)

# for (i in names(teens)[1]){
#   print(min(teens$i))
#   print(max(teens$i))
# }

# 각 열에 대한 최소값/최대값

apply(interests, 2, min)
apply(interests, 2, max)

apply(interests, 2, max)-apply(interests, 2, min)

# 최대값-최소값이 차이가 큰 컬럼들 때문에 유클리드 거리에 영향을 많이 끼치게된다.
# -> 표준화가 필요

# 1.
scale(interests)
class(scale(interests))

# 2.
interests_z <- as.data.frame(lapply(interests, scale))
head(interests_z, 5)

summary(interests$basketball)
summary(interests_z$basketball)

set.seed(12345)
teen_clusters <- kmeans(interests_z,5) # 5개 클러스터 생성
teen_clusters

# between_SS / total_SS =  12.0 %
# between_ss : 클러스터간 분산 정도 -> 클수록 클러스터링이 잘 된것이다.
# within_ss: 클러스터 내 데이터의 분산 정도 -> 작을수록 클러스터링이 잘 된것이다.

# total_ss = between_ss+within_ss

teens$cluster <- teen_clusters$cluster
head(teens,5)

# insight 추출 (클러스터의 특징을 추출)
aggregate(data=teens, age~cluster, mean)
#        (데이터, 관심있는 변수 ~ 그룹화변수, 적용함수)
aggregate(data=teens, female~cluster, mean)
aggregate(data=teens, friends~cluster, mean)


# 홍길동이란 친구(0.75, -0.1, ... , -0.08)
# 클러스터의 중심점(5개)
# 어느그룹에 속하는지 알고 싶으면?
# 홍길동 포함해서 표준화 작업을 하고(3001개) 군집화는 홍길동을 빼고(30000개) 클러스터의
# 중심점 5개랑 비교해서 가까운 곳을 찾으면 됨





teen_clusters$centers

teen_clusters$totss
