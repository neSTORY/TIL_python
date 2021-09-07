# -- iris k-means -- #

iris <- as.data.frame(iris)[1:4]
iris
names(iris)

sepal <- iris[1:2]
petal <- iris[3:4]

# summary(sepal)
# table(sepal, useNA = "ifany")
# 
# summary(petal)
# table(petal, useNA = "ifany")

# -> NA값 존재하지 않음.

sepal_z <- as.data.frame(lapply(sepal, scale))
sepal_z

sepal_clusters <- kmeans(sepal_z,3)
sepal_clusters
sepal$cluster <- sepal_clusters$cluster


petal_z <- as.data.frame(lapply(petal, scale))
petal_z

petal_clusters <- kmeans(petal_z,3)
petal_clusters
petal$cluster <- petal_clusters$cluster


iris_z <- as.data.frame(lapply(iris, scale))
iris_z

iris_clusters <- kmeans(iris_z,3)
iris_clusters

# 군집화는 sepal -> iris -> petal 순으로 잘 됐다.

iris$cluster <- iris_clusters$cluster
aggregate(data=iris, Sepal.Length~cluster, mean)

library(ggplot2)

# sepal
ggplot(data=sepal, aes(x=Sepal.Length,y=Sepal.Width, col=cluster))+geom_point()

# petal
ggplot(data=petal, aes(x=Petal.Length,y=Petal.Width, col=cluster))+geom_point()

# iris
ggplot(data=iris, aes(x=Sepal.Length,y=Petal.Length, col=cluster))+geom_point()
ggplot(data=iris, aes(x=Sepal.Width,y=Petal.Width, col=cluster))+geom_point()

# =============================================================================#

# kmeans -> 몇 개의 클러스터? 엘보(elbow)그래프 -> k+menas(k means++)
# k = 2,3,...,20
# 
# h- clustering
# 
# DBSCAN: 반경 x(Eps) 이내에 점이 n(MinPts)개 이상 있으면 하나의 클러스터가 됨
# x : 반경
# n : 점의 개수

# 점p가 반경 x(Eps)이내에 점을 n개 이상 가지고 있다면 -> 클러스터를 생성 -> 이때 p를
# 클러스터의 중심점 (core point)이라고 함


신문기사를 5개의 클러스터로 클러스터링(각 클러스터의 의미는 모름.-> 분류가 아님!!)
kmeans?
  
  
  텍스트데이터 -> 단어(형태소 분석)
  -> 불필요한 형태소(단어, stopwords, ex.은,는,이,가 ..)제거

신문기사 1: 기술, 공공, ..
  ...
신문기사 5: 한글, 에트리, ..
  
  
# DBSCAN
  
install.packages("fpc")
library(fpc)  
library(ggplot2)  


# sample : 샘플링 해주는 함수
sample(1:10,30,replace = T)
# 1~10까지 20개 default는 False -> 비복원
# 그래서 replace=TRUE로 해야지 복원추출이 가능해짐

data <- data.frame(cbind(c(sample(1:10,30,replace = T),sample(20:30,20,replace = T)),
c(sample(1:10,30,replace = T),sample(20:30,20,replace = T))))

data

ggplot(data)+
  geom_hline(yintercept = 1:30, colour="grey")+
  geom_vline(xintercept = 1:30, colour="grey")+
  geom_point(aes(x=X1, y=X2))+ # 점 찍는 코드
  theme_classic() # 테마

db <- dbscan(data, eps=sqrt(30), MinPts = 2)
db
str(db)
db$cluster # 50개의 데이터가 어떤 클러스터에 속하나
db$isseed # seed(corepoint)이냐 아니냐


#        0  1  2  3
# border 7  1  0  1
# seed   0 11 18 12
# total  7 12 18 13

# 0컬럼 : 노이즈(아웃라이어) => 7개
# 1컬럼 : 첫 번째 클러스터

# border: borderpoint
# seed: corepoint

# 반경(eps)이 줄어들거나 MinPts가 커지면 아웃라이어가 많아짐

library(RColorBrewer)
ggplot(data )+
  geom_hline(yintercept = 1:30, colour="grey")+
  geom_vline(xintercept = 1:30, colour="grey")+
  geom_point(aes(x=X1, y=X2, col=as.factor(db$cluster)))+
  geom_point(data=data[!db$isseed,], aes(X1,X2), shape=5)+
  theme_minimal()

# data[!db$isseed,] # data에서 seed가 아닌것들만 출력




#===========================================================================#

# iris$Petal.Length, iris$Petal.Width
# -> 시각화
# -> minpts, eps 조정 -> 3개 클러스터 생성

irisData <- iris[3:4]
irisData

ggplot(irisData)+
  geom_hline(yintercept = 0:7, colour="grey")+
  geom_vline(xintercept = 0:7, colour="grey")+
  geom_point(aes(x=Petal.Length, y=Petal.Width))+ # 점 찍는 코드
  theme_classic() # 테마


db2 <- dbscan(irisData, eps = 0.23, MinPts = 4)
db2

# summary(iris)

ggplot(irisData)+
  geom_hline(yintercept = 0:7, colour="grey")+
  geom_vline(xintercept = 0:7, colour="grey")+
  geom_point(aes(x=Petal.Length, y=Petal.Width, col=as.factor(db2$cluster)))+
  geom_point(data=irisData[!db2$isseed,], aes(Petal.Length,Petal.Width), shape=9)+
  theme_minimal()


# ============================================================================ #

# 몰라도 괜찮음

# DBSCAN 할 때 적절한 MinPts(k)와 eps값을 결정하는 방법
# cf) MinPts(k) 값은 데이터의 차원+1부터 설정해보는게 좋음

data <- data.frame(cbind(c(sample(1:10,30,replace = T),sample(20:30,20,replace = T)),
                         c(sample(1:15,30,replace = T),sample(15:30,20,replace = T))))
data

ggplot(data)+
  geom_hline(yintercept = 1:30, colour="gray")+
  geom_vline(xintercept = 1:30, colour="gray")+
  geom_point(aes(x=X1, y=X2))+ # 점 찍는 코드
  theme_classic() # 테마


disEps <- function(mydata, x, y){
  # mydata: 기준점
  # x, y: 나머지 점들의 x,y 좌표
  
  sqrt((mydata[1]-x)^2+(mydata[2]-y)^2)
}


# 1, 2번 진행

# =======================================================================#

1) 모든 점(데이터)들에 대해 k번째로 가까운 점들과의 거리를 계산
ex) 데이터 50건
데이터 1번 ~ 50번의 각 데이터에 대해 나머지 49개의 데이터와의 거리를 계산

2) 거리를 기준으로 내림차순 정렬

# =======================================================================#

k <- 3
dis <- c()
for (i in 1:nrow(data)){ # i는 1~50까지 값
  dis <- c(dis,sort(apply(data, 1, disEps, x <- data[i,1], y <- data[i,2]))[k+1])
  # print("===================================================")
}
print(dis) # 50개의 기준점 각각에 대해 4(k+1의 값)번째 가까운 점과의 거리

# =======================================================================#

3) 그래프를 그리자
- x축은 점들의 번호
- y축은 내림차순 정렬된 거리

# =======================================================================#

ggplot()+
  geom_point(aes(x=1:length(dis),y=sort(dis,decreasing = T)))+
  theme_bw()

# =======================================================================#


4) elbow로 그려지면, 꺾이는 지점을 찾는다
-> 찾았다면 이때의 k가 MinPts, y축 값이 eps

# => eps를 3.4로 해보자

# =======================================================================#

# MinPts=2, Eps=3.5

db <- dbscan(data, eps = 4,MinPts = 4)

ggplot(data)+
  geom_hline(yintercept = 1:30, colour="grey")+
  geom_vline(xintercept = 1:30, colour="grey")+
  geom_point(aes(x=X1, y=X2, col=as.factor(db$cluster)))+
  geom_point(data=data[!db$isseed,], aes(X1,X2), shape=10)+
  theme_minimal()


# k+1 했으니까 아웃라이어 구할때 k로 넣는게아니라 k+1로 넣어야하는거 아닌가?

  
  