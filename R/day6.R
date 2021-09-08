# 거리행렬

a <- matrix(rnorm(100), nrow=5) # 5행 20열
# 5건의 데이터, 20차원

dist(a)

# hclust함수 method파라미터
# single: 최단거리
# complete: 최장거리
# average: 평균

plot(hclust(dist(a), method="single"))
plot(hclust(dist(a), method="complete"))
plot(hclust(dist(a), method="average"))

install.packages("mlbench")
library(mlbench)

data(Glass)
Glass

mydata <- Glass
table(Glass$Type)

s_data <- scale(mydata[, -10])
s_data

hc <- hclust(dist(s_data), method="average")
plot(hc, hang= -1)

# 7개 클러스터로 나눌 경우
rect.hclust(hc, k=7, border="blue") # rectangle

# 최적의 클러스터 개수를 구함
install.packages("fpc")
library(fpc)

opt_clust <- numeric(19)
opt_clust

library(cluster)

# k는 클러스터의 개수
for (k in 2:20){
  opt_clust[[k]] <- pam(s_data,k)$silinfo$avg.width
}

opt_clust
 
max(opt_clust) # 0.4112153
best_num <- which.max(opt_clust)

cat("최적의 클러스터 개수 : ", best_num)

cluster::pam(s_data,2)$silinfo$avg.width
# 0.4112153 -> 실루엣 값(0~1)
# 실루엣 값이 1에 가까울수록 클러스터링이 잘 됨

3 -> 0.2501838
4 -> 0.2827879
..
20 -> 0.2160421


#=============================================================================#


# kmeans 클러스터링 - 엘보우 그래프
library(ggplot2)

iris
str(iris)
irisScale <- scale(iris[,-5])
irisScale

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species))+
  geom_point()

ggplot(iris, aes(x=Petal.Length, y=Petal.Width, col=Species))+
  geom_point()

kmax <- 10
wss <- rep(NA, kmax)
wss
rclust <- list()

for (i in 1:kmax){
  irisCluster <- kmeans(irisScale, i)
  wss[i] <- irisCluster$tot.withinss
  rclust[[i]] <- irisCluster$size
  # withinss: 클러스터 내의 데이터 사이 거리 제곱 합 벡터
  # tot.withinss : withinss의 총합
}
rclust

plot(1:kmax, wss, type="b") # 엘보우그래프
# 3이 팔꿈치 부분

res <- kmeans(irisScale,3)
str(res)

plot(iris, col=res$cluster)

iris$Species
res$cluster

table(predicted=res$cluster, Actual=iris$Species)


#=============================================================================#


knn : k개 이웃을 참조 -> 관심 대상 데이터의 예측

국 영 수 합/불
50 50 50 불
90 90 90 합
...

100 100 100 ??
  
ex) k가 3이라면, 가장 까가운 3명의 데이터 검색(유클리디안 거리)
    -> 합/불 다수결? 합격:2, 불합격:1 => 합격

국 영 수 과
50 50 50 50
90 90 90 90
...
100 100 100 ???

  ex) k가 3이라면, 가장 까가운 3명의 데이터 검색(유클리디안 거리)
      -> 과학점수? 3명 과학점수 -> 90,95,90 -> 평균 92.xx => 예측


#=============================================================================#


wbcd <- read.csv("wisc_bc_data.csv")
str(wbcd)

wbcd <- wbcd[-1] # id열 제외

table(wbcd$diagnosis)

factor(wbcd$diagnosis, labels =c("Benign","Mallignant")) # factor: 범주형
wbcd$diagnosis <- factor(wbcd$diagnosis, labels =c("Mallignant", "Benign"), levels=c("B","M")) # factor: 범주형


wbcd$diagnosis # 문자형

# 비율
prop.table(table(wbcd$diagnosis))

round(prop.table(table(wbcd$diagnosis))*100,1)

summary(wbcd)
summary(wbcd["points_worst"])
summary(wbcd[c("points_worst","dimension_worst","texture_worst")])
# 파이썬과 다르게 여러 컬럼을 참조하고싶으면 컬럼들을 벡터화해서 참조

normalize <- function(x){
  return((x-min(x)/(max(x)-min(x))))
}

normalize(c(1,2,3,4,5))
normalize(c(10,20,30,40,50))

head(wbcd,3)

wbcd_n <- as.data.frame(lapply(wbcd[2:31],normalize))

summary(wbcd_n)
str(wbcd_n)
nrow(wbcd_n)

# 1 ~ 469번 까지 데이터 -> knn모델 생성
# 470~569번까지 데이터를 -> knn모델에 입력 -> 출력(예상되는 진단 결과)


apply 함수 : 벡터, 행렬 -> 함수 적용 -> 결과 도출

1) apply: 행렬의 행 또는 열 방향 함수 적용
sum(1:10)

m <- matrix(1:9,ncol = 3)
class(apply(m,1,sum))

apply(iris[,1:4], 2, sum)
colSums(iris[,1:4])

lapply :(벡터/리스트, 함수) 결과물이 리스트로 나옴
myfunc <- function(x){
  x*2
}

res <- lapply(1:3, myfunc)
unlist(res)

lapply(iris[,1:4], sum)
as.data.frame(matrix(unlist(lapply(iris[,1:4], mean)),2))

sapply() : lapply와 거의 똑같음. 차이점이 결과물이 벡터 또는 행렬로 나온다.

lapply(iris[,1:4], mean)
sapply(iris[,1:4], mean)

tapply() : 그룹별로 연산하는 apply 함수

1:10%%2

table(1:10 %%2 ==1)

ex) 1~10까지 수에 대해 짝수그룹/홀수그룹 각각의 합

x <- 1:10
sum(x[x%%2==0])
sum(x[x%%2!=0])

tapply(1:10, x%%2==1, sum) # 가운데에 그룹을 나눠줄 기준을 넣어줌. 이때 길이는 그룹전체와 같아야함

rep(1,10)

tapply(1:10, rep(1,10), sum)
# 첫 번째 파라미터 : 1 2 3 4 5 6 7 8 9 10
# 두 번째 파라미터 : 1 1 1 1 1 1 1 1 1 1

# iris에서 Species 별로 Sepal.Length의 평균

tapply(iris$Sepal.Length, iris$Species, mean)


#=============================================================================#


wbcd_train_labels <- wbcd[1:469, 1] # knn 모델 생성 과정 사용 데이터
wbcd_test_labels <- wbcd[470:569,1] # 모델 테스트 사용 데이터
knn()

wbcd_train <- wbcd_n[1:469,]
wbcd_test <- wbcd_n[470:569,]

library(class)

pred <- knn(train=wbcd_train, test=wbcd_test,
            cl=wbcd_train_labels, k=21)
pred # 테스트 데이터에 대한 예측값
wbcd_test_labels # 실제값값

install.packages("gmodels")
library(gmodels)

CrossTable(x=wbcd_test_labels, y=pred) # 교차표(예측값과 실제값을 비교)

write.csv(data.frame(pred),"pred.csv")

head(read.csv("train.csv"),2)
head(read.csv("test.csv"),2)
head(read.csv("gender_submission.csv"),2)

# df <- data.frame(PassengerId=아이디저장된변수이름, Survived=예측결과가 저장된 변수이름)
# write.csv(df,"제출파일명.csv")





















