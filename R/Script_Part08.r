변수:
- 연속 변수: ex) 나이, 가격
- 범주 변수: 이산 ex) 동물, 합격/불합격

척도(scale):
  관측값을 나타내는 level(수준)
- 서열척도: 관측값 사이에서 순서가 있음, 연산이 불가능
  ex) 직급(사원, 대리, 과장, 부장, ..)

- 명명척도: 관측값 사이에서 순서가 없음, 종류에 따른 빈도수 조사
  ex) 혈액형, 성별

- 등간척도: 관측값 사이에서 순서가 있음, 연산 가능
  ex) 섭씨온도(20도는 10도의 2배, 2배 따뜻해지는 것은 아님)
      섭씨(0도) <-> 화씨(32도)
      
- 비율척도
  ex) 미터(20미터는 10미터의 2배, 2배 길다)

ex) 나이 데이터 통계 분석
서열척도 분석: 어린이 < 청소년 < 청년 < 장년 < 노인



#### 08-2 ####

## -------------------------------------------------------------------- ##
library(ggplot2)

# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

# x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)


#### 08-3 ####

## -------------------------------------------------------------------- ##
library(dplyr)

df_mpg <- mpg %>% 
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()


#### 08-4 ####

## -------------------------------------------------------------------- ##
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()


#### 08-5 ####

## -------------------------------------------------------------------- ##
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


## -------------------------------------------------------------------- ##
## 1.산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)


## 2.평균 막대 그래프

# 1단계.평균표 만들기
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

# 2단계.그래프 생성하기, 크기순 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()


## 3.빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

## 4.선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

## 5.상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()



## -------------------------------------------------------------------- ##


mydata <- read.csv("examscore.csv", header=TRUE) # header=TRUE 는 default
mydata$gender
mydata[,3] # 3번 열 출력
mydata[1,] # 1번 행 출력

mytable <- table(mydata$gender) # value_counts 역할
mytable

pie(mytable, labels=names(mytable), main="pie chart")
pie(mytable, labels=c("여자","남자"), main="파이차트")
text(0.3,0.3, "33.33%")
text(-0.3,-0.3, "66.67%")

plot(mydata$midterm, mydata$final,
     xlab="중간고사",
     ylab="기말고사",
     main="제목")

mean(mydata$midterm)
median(mydata$midterm)

hist(mydata$midterm)
abline(v=mean(mydata$midterm), col="red") # v: 수직선
abline(v=median(mydata$midterm), col="blue")

quantile(mydata$midterm)

var(mydata$midterm)
sd(mydata$midterm)


res <- table(mydata$final)
names(sort(-res)[1])


# 최빈수 리턴해주는 함수 정의

myMode <- function(x){
  imsi <- table(x)
  res <- names(sort(-imsi)[1])
  return(res)
}
myMode(mydata$final)

rep(0,10) # 0을 10번 반복

a <- c(1:10)
a
a[1:5] <- c(5,3,1,4,2)
a

a[a<5] <- "low"
a


mydata$midterm
mydata$final

# 상관계수 구하기
cor(mydata$midterm,mydata$final)

plot(mydata$midterm,mydata$final)
abline(v=mean(mydata$midterm))
abline(h=mean(mydata$final))

zx <- (mydata$midterm-mean(mydata$midterm))/sd(mydata$midterm)
zy <- (mydata$final-mean(mydata$final))/sd(mydata$final)

sum(zx*zy)/(length(mydata$midterm)-1) # 상관계수 구하기
# zx*zy => x축, y축을 곱한 면적, 1,3사분면은 양수, 2,4사분면은 음수

sign(zx*zy) # 양수면 1, 음수면 -1

as.factor(sign(zx*zy)) # as.factor: 범주형으로 만들어주는 함수

c("blue","red")
c("blue","red")[as.factor(sign(zx*zy))] # -1,1에 해당하는 값이 blue, red로 바껴서 들어감


plot(mydata$midterm,mydata$final,
     col=c("blue","red")[as.factor(sign(zx*zy))])
abline(v=mean(mydata$midterm))
abline(h=mean(mydata$final))


회귀분석: 독립변수(x)로 종속변수(y)를 예측
혼입변수: 모델에는 포함되지 않지만, 종속변수에 영향을 미치는 변수

모델 => 몸무게(x)*기울기 + 바이어스(절편)
ex)혼입변수: 건강상태에 따라 식사량이 달라지고, 그에 따라 몸무게에 변화가 생김,
   운동량에 따라 식사량이 달라지고, 몸무게가 변화


회귀분석에서는 종속변수가 연속인 값을 말하고, 넓은 범위에서 범주형은 분류를 말함

선형회귀분석: 독립변수와 종속변수간에 직선 관계가 있는 것
선형이란? 독립변수가 증가하면, 종속변수가 증가/감소

종속변수(y) = 기울기(w)*독립변수(x)+b(절편)
몸무게 = 200*1그릇 + 0.1
y = wx + b

w:회귀계수(200), 독립변수 x가 1씩 증가한다면 y는 w만큼 증가한다
절편: 독립변수가 0이면 y=b(절편) => 독립변수가 0일때 종속변수 y값

회귀분석을 하는 이유?
회귀모델 -> 예측

점수=w*공부시간+기본점수

모델 예시 => 점수=w*공부시간+기본점수
모델 적합도 : 공부시간과 점수의 관계가 데이터에 얼마나 잘 들어맞는지 검증


cars # R에 내장돼 있는 데이터

plot(cars$speed, cars$dist)
scatter.smooth(cars)

# outliers가 있으면 회귀분석 결과가 왜곡됨 (=>이상치,극단치때문에 결과에 영향을 끼침)

par(mfrow=c(1,2)) # 1행 2열
boxplot(cars$speed, main="speed")
boxplot(cars$dist, main="speed")

# 선형회귀분석은 독립변수와 종속변수가
# 정규분포를 따를 때 잘 됨

par(mfrow=c(1,2)) # 1행 2열
plot(density(cars$speed, main="speed"))
plot(density(cars$dist, main="speed"))


install.packages("e1071") # 분포도 그릴 때 사용하는 패키지(왜도,첨도)

library(e1071)
skewness(cars$speed) # 왜도:데이터가 치우친 정도
skewness(cars$dist)

kurtosis(cars$speed)
# 첨도:확률분포 그래프의 뾰족한 정도 뾰족한 정도가 3에 가까우면 정규분포에 가깝다
kurtosis(cars$dist)

# 왜도가 0, 첨도가 1일 때 완전한 정규분포

# lm함수 : 회귀분석
# 종속변수 ~ 독립변수

# lm(dist~speed, data=cars)

# y(dist) = 3.932 * x(speed) + (-17.579)
# => speed가 5이하일땐 음수가 나옴 => 그만큼 정확성이 떨어짐

# 정규분포? 평균을 중심으로 좌우가 대칭
# 왜도와 첨도로 정규성 확인
# 왜도? 비대칭성을 나타내는 척도


model <- lm(dist~speed, data=cars)
summary(model)

Residuals(잔차): 실제값 - 예측값
coefficients(회귀계수)

Multiple R-squared: 0.6511의 의미?
  -> dist의 분산을 speed가 약 65%를 설명한다(높을수록 정확함)

Adjusted R-squared: 다중회귀분석에서 사용

F-statistic : p-value가 0.05보다 작으면 유의미한 예측결과가 나왔다

# 0+는 절편을 제거 -> 기울기만 보겠다
model <- lm(dist~0+speed, data=cars)
summary(model)


par(mfrow=c(1,1))
mydata
plot(mydata$midterm, mydata$final)
abline(5,2)
# 기울기 2, 교차점 5
# abline => y=1*x+5
abline(-10,2,col="red")

# 이런식으로 직선을 그어서 회귀선이 어디에 잘 맞는지 찾는 것


# 잔차(residual): 예측값-실제값 => error
# RSS(residual sum of square) 잔차 제곱의 합

mydata[, 3:4]

rss <- function(data, line_info){
  x <- data[,1] # 독립변수
  y <- data[,2] # 종속변수
  intercept <- line_info[1] # 가상회귀모델 절편
  slope <- line_info[2] # 가상회귀모델 기울기
  Hx <- slope*x+intercept
  result <- sum((y-Hx)^2)
  result
  
  
  # print(Hx) # 예측 기말 점수
  # print(y) # 실제 기말 점수
  # print(y - Hx) # ERROR
  # print(sum((y-Hx)^2)) # ERROR의 제곱의 합 = cost
  # 회귀모델의 목표는 cost를 최소로 하는 slope와 intercept를 찾는 것
  
}

# 가상의 회귀모델 = y절편:5, 기울기:1
# 가상의 회귀모델에 대한 RSS를 출력해보자

rss(mydata[, 3:4],c(5,1))

res <- optim(par=c(1,1), fn=rss, data=mydata[,3:4])
# par=c(1,1) => 초기 절편과 기울기 값
res


lm(final ~ midterm, mydata)

기울기 = 상관계수*(y의 표준편차/x의 표준편차)
x <- mydata$midterm
y <- mydata$final

s <- cor(x,y)*(sd(y)/sd(x))
s # 기울기

b <- mean(y)-s*mean(x) # 절편
b

# 예측 테스트
# 어떤 사람이 중간고사를 85점 받았다면 기말고사 예측?
yhat <- s*85+b
print(yhat)



