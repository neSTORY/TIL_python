## kmeans(군집화)

iris 데이터로 kmeans(군집화)를 해보자

```R
iris_copy <- as.data.frame(iris)
iris_copy

names(iris_copy) # iris 데이터셋의 컬럼 이름 확인

sepal <- iris[1:2] # petal 관련 열 저장
sepal

petal <- iris[3:4]
petal
```

iris_copy라는 데이터프레임을 생성하고 알아보고 싶은 sepal과 petal을 따로 저장했다.



```R
# sepal, petal 열 데이터 정보확인

str(sepal)
summary(sepal)
summary(petal)

# NA 값이 있는지 확인

table(sepal, useNA = "ifany")
table(petal, useNA = "ifany")
```

데이터의 정보를 확인하고 NA값이나 결측치가 있는지 확인



```R
# 데이터들의 표준화를 진행

sepal_z <- as.data.frame(lapply(sepal, scale))
sepal_z

petal_z <- as.data.frame(lapply(petal, scale))
petal_z
```

꽃잎, 꽃받침의 두께, 길이는 범위가 다르기 때문에 표준화를 진행해줬다.



```R
# kmeans 진행

sepal_cluster <- kmeans(sepal_z,3)
sepal_cluster

# 3 clusters of sizes 49, 49, 52
# => (between_SS / total_SS =  65.8 %) 65.8%로 군집화가 잘 되진 않음

petal_cluster <- kmeans(petal_z,3)
petal_cluster

# 3 clusters of sizes 48, 50, 52
# => (between_SS / total_SS =  94.0 %) 94%로 군집화가 잘됨
```

표준화를 진행했으므로 kmeans를 진행해보고 군집화가 얼마나 잘 되있는지 확인해봤다.

추가로 각 클러스터 당 데이터의 개수를 알아봤다.



**iris 데이터를 클러스터링하고 클러스터별 꽃받침의 길이의 평균을 알아보자**

```R
iris_z <- as.data.frame(lapply(iris_copy, scale))
iris_z

iris_clusters <- kmeans(iris_z,3)
iris_clusters


iris_copy$cluster <- iris_clusters$cluster

aggregate(data=iris_copy, Sepal.Length~cluster, mean)

```

### aggregate 

groupby같은 느낌으로 여기서는 클러스터별 알고 싶은 컬럼의 평균을 구하려고 사용해봤다.

aggregate(data= data, 알고 싶은 컬럼 ~ 나눠줄 컬럼(그룹바이같은 느낌), 적용할 계산-평균, 합계 등)



---



## DBSCAN

kmeans만으로는 군집화를 잘 못하는 경우가 있다.

![image-20210907191408415](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907191408415.png)

데이터가 이런식으로 있으면 kmeans를 사용하면 가까운 데이터들끼리 군집화를 해주기 때문에

그림처럼 군집화가 될 수 있다. 우리는 파랑끼리 빨강끼리 군집화를 해주고 싶다. 그러나 데이터의 밀집도를 고려하지 않아서 좀 더 정확한 군집화가 진행되지 않는다. 이런 경우를 위해서 밀집도를 기준으로 데이터를 군집화해주는 DBSCAN 방식이 있다.



### 원리

반경 x(Eps) 이내에 점이 n(MinPts)개 이상 있으면 하나의 클러스터가 됨.

![image-20210907192044418](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907192044418.png)

그림을 보면 중심점을 기준으로 원을 그려서 반지름을 Eps라고 한다. 이 원안에 미리 정해준 MinPts(최소 점의 개수)를 만족하면 클러스터를 생성하게 된다.

![image-20210907191704255](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907191704255.png)

클러스터의 중심점을 corepoint라고 하고 클러스터에 들어가있지만 다른 클러스터의 중심점이 되지 못 하는 점을 border point라고 한다. 



연습하기 위한 데이터를 생성해보자

### sample

샘플함수는 랜덤한 수를 샘플링 해줄 때 사용한다. numpy에서 randn과 비슷한 역할을 해준다.

1~10까지의 수를 30개 생성해보자

```R
# sample(1:10,30)
# => 생성 불가 why? default값이 비복원추출이라서 한 번 생성한 수는 다시 생성하지 않는다.
# 그래서 파라미터 replace의 값을 TRUE로 설정해서 복원추출을 가능하게 해주자

sample(1:10,30, replace=T)
```

>  [1]  1  1  7  6  2  1  1  4  6  3  7  7  2  2  5  1  2  6  3 10  5  6  9  7  7  6  5  2  4  6

1~10까지의 랜덤한 수 30개를 생성하였다.



2개의 열, 50개의 행을 가진 데이터프레임을 생성해서 data변수에 넣어주자

```R
data <- data.frame(cbind(c(sample(1:10,30,replace = T),sample(20:30,20,replace = T)),
c(sample(1:10,30,replace = T),sample(20:30,20,replace = T))))

head(data)
```

> ​	X1 X2
> 1  5  1
> 2 10 10
> 3  1  4
> 4  1  9
> 5  2  8
> 6  8  3

이제 이 데이터프레임을 시각화 해보자

```R
ggplot(data)+
  geom_hline(yintercept = 1:30, colour="grey")+ 
  geom_vline(xintercept = 1:30, colour="grey")+
  geom_point(aes(x=X1, y=X2))+ # 점 찍는 코드
  theme_classic() # 테마
```

![image-20210907200329486](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907200329486.png)

**geom_hline**: 그래프에 수평선을 그어준다.

- yintercept 파라미터는 수평선을 그어주는 범위를 지정해준다.

- colour 파라미터는 수평선의 색을 지정해준다.

**geom_vline**: 그래프에 수직선을 그어준다.

**geom_point**: 각 데이터를 그래프에 점으로 표기해준다.

- aes : x축, y축을 지정해주는 역할

**theme_classic**: 그래프의 테마를 지정해주는 함수



데이터를 그래프에 표기해봤으니 이제 dbscan으로 군집화를 해보자

```R
library(fpc)  # dbscan을 사용하기 위한 라이브러리
library(ggplot2) # 시각화를 사용하기 위한 라이브러리

db <- dbscan(data, eps=sqrt(30), MinPts = 2)
db
```

> dbscan Pts=50 MinPts=2 eps=5.477226
>        1  2
> seed  30 20
> total 30 20

**dbscan** : dbscan을 해주는 함수

- eps : 군집화를 할 때 원(클러스터)의 범위를 지정해주는 파라미터
- MinPts: 클러스터 내 데이터의 최소 개수를 지정해주는 파라미터

**seed**: corepoint의 개수

1, 2 인 2개의 컬럼을 갖는 이유는 -> **2개의 클러스터를 생성했기 때문!**

       0  1  2  3
       border 7  1  0  1
       seed   0 11 18 12
       total  7 12 18 13
예를 들어 dbscan 값이 이렇게 나왔을 경우

**3개의 클러스터**를 가지고 **0**은 **아웃라이어의 개수**를 갖는 컬럼이다.

**border**는 borderpoint를 나타낸다.



cf) 반경(eps)이 줄어들거나 MinPts(최소 점 개수)가 커지면 아웃라이어가 많아진다.

=> 클러스터가 생성될 조건이 까다로워지기 때문



dbscan을 했으니까 시각화를 진행해보자

```R
library(RColorBrewer) # 클러스터의 색을 다르게 나타내주는 라이브러리
ggplot(data )+
  geom_hline(yintercept = 1:30, colour="grey")+
  geom_vline(xintercept = 1:30, colour="grey")+
  geom_point(aes(x=X1, y=X2, col=as.factor(db$cluster)))+
  geom_point(data=data[!db$isseed,], aes(X1,X2), shape=5)+
  theme_minimal()
```

![image-20210907200230952](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907200230952.png)



geom_point에서 col파라미터는 색을 다르게 해줄 컬럼을 지정해주는 역할을 한다.

**as.factor(db$cluster)**: as.factor를 사용해서 클러스터에 따라 다른 색을 지정해준다.

geom_point(data=data[!db$isseed,], aes(X1,X2), shape=5)

=> 점을 찍는데 data[!db%isseed]가 시드가 아닌 것들을 지정해주기 때문에 아웃라이어들을 출력해준다.

shape는 점의 모양을 지정해주는 파라미터.(수가 높아질수록 더 많은 다각을 갖는 도형으로 출력해준다)



---

### DBSCAN 사용 시 적절한 Eps와 MinPts를 구하는 알고리즘

이 방법은 경험적 휴리스틱에 의한 방법으로

1. 모든 점(데이터)들에 대해 k(MinPts)번째로 가까운 점들과의 거리를 계산하고 

2. 거리를 기준으로 내림차순 정렬을 해준다.

3. 거리를 그래프로 그려준다. 

-  x축은 점들의 번호
-  y축은 내림차순으로 정렬된 거리(각각의 점들의 k번째로 가까운 거리)

4. elbow로 그려지면, 꺾이는 지점(낙차가 큰 지점)을 찾아준다.

- 이때의 k가 MinPts, y축 값이 eps로 생각하면 된다.

iris의 petal 데이터로 예를 들어보자

```R
petal <- iris[3:4]
petal

ggplot(petal)+
  geom_hline(yintercept = 0:7, colour="grey")+
  geom_vline(xintercept = 0:7, colour="grey")+
  geom_point(aes(Petal.Length,Petal.Width))+
  theme_minimal()
```

iris에서 petal과 관련된 데이터를 petal 변수에 넣어주고

petal 데이터를 시각화 해보자

![image-20210907212204726](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907212204726.png)

보통 k의 최소값은 컬럼의 개수 +1로 시작을 해준다.

petal의 열은 2개이므로 k는 3으로 시작하자

```R
disEps <- function(mydata, x, y){
  # mydata: 기준점
  # x, y: 나머지 점들의 x,y 좌표
  
  sqrt((mydata[1]-x)^2+(mydata[2]-y)^2)
}
```

우선 eps의 거리를 구해주는 함수를 생성하고

```R
k <- 3
dis <- c()
for (i in 1:nrow(petal)){ # i는 1~150까지 값
  dis <- c(dis,sort(apply(petal, 1, disEps, x <- petal[i,1], y <- petal[i,2]))[k+1])
  # print("===================================================")
}
print(dis)
```

1. k에 3을 넣어주고
2. 거리를 넣어줄 벡터값을 갖는 dis 변수 생성
3. 반복문을 통해 각 점들이 k+1번째로 가까운 (4번째로 가까운) 거리를 구하고 dis 변수에 넣어준다.



dis를 출력해보면

>   [1] 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000 0.1000000 0.1000000 0.0000000 0.0000000
>  [10] 0.1000000 0.0000000 0.0000000 0.1000000 0.1414214 0.1000000 0.1000000 0.1414214 0.1000000
>  [19] 0.1414214 0.1000000 0.1000000 0.1000000 0.2000000 0.1414214 0.2236068 0.0000000 0.1000000
>  [28] 0.0000000 0.0000000 0.0000000 0.0000000 0.1000000 0.1000000 0.0000000 0.0000000 0.1000000
>  [37] 0.0000000 0.1000000 0.0000000 0.0000000 0.1000000 0.1000000 0.0000000 0.2236068 0.2236068
>  [46] 0.1000000 0.0000000 0.0000000 0.0000000 0.0000000 0.1000000 0.0000000 0.1414214 0.1000000
>  [55] 0.1000000 0.1414214 0.2000000 0.2000000 0.1414214 0.1414214 0.2000000 0.2236068 0.2000000
>  [64] 0.1000000 0.3162278 0.1414214 0.0000000 0.2236068 0.0000000 0.1414214 0.1000000 0.1000000
>  [73] 0.1414214 0.2000000 0.1000000 0.1414214 0.1414214 0.1414214 0.0000000 0.2000000 0.1414214
>  [82] 0.2000000 0.1414214 0.1414214 0.0000000 0.1000000 0.1000000 0.1000000 0.1000000 0.1000000
>  [91] 0.1414214 0.1000000 0.1000000 0.2000000 0.1000000 0.1414214 0.1000000 0.1000000 0.5099020
> [100] 0.1000000 0.2236068 0.1000000 0.2000000 0.2000000 0.1414214 0.2236068 0.2000000 0.3000000
> [109] 0.2000000 0.2828427 0.1000000 0.2000000 0.1414214 0.1000000 0.2236068 0.2000000 0.2236068
> [118] 0.2236068 0.3605551 0.1000000 0.1414214 0.2000000 0.3000000 0.1000000 0.1414214 0.2828427
> [127] 0.1000000 0.1000000 0.1000000 0.2828427 0.2828427 0.3000000 0.1414214 0.2000000 0.4123106
> [136] 0.2236068 0.1414214 0.2236068 0.1000000 0.2000000 0.1414214 0.2000000 0.1000000 0.2000000
> [145] 0.2000000 0.1414214 0.1000000 0.1414214 0.2000000 0.1414214

150개의 데이터들의 4번째로 가까운 데이터와의 거리가 들어가있는 것을 확인할 수 있다.

```R
ggplot()+
  geom_point(aes(x=1:length(dis),y=sort(dis,decreasing = T)))+
  theme_bw()
```

![image-20210907212736999](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907212736999.png)

이 거리를 시각화 해본다면 이런 그래프가 나오게 된다.

여기서 낙차가 큰 지점을 구한다면

![image-20210907212931796](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907212931796.png)

이 빨간선이 낙차가 큰 지점이 된다. 이때 빨간선의 y축 값은 eps가 되고(대략 0.25로 정하자)

검은선을 기준으로 왼쪽에 있는 데이터들은 outlier가 된다. 

왜 왼쪽데이터들은 아웃라이어가 되냐?

=> eps를 기준으로 왼쪽데이터들은 거리가 지정한 eps보다 더 멀기 때문에 클러스터 안에 포함되지 못 하기 때문에 아웃라이어가 되게 된다.

여기서 구한 eps(0.25)를 기준으로 dbscan을 통한 시각화를 해보면

```R
db <- dbscan(petal, eps = 0.25, MinPts = 3)
db

ggplot(petal)+
  geom_hline(yintercept = 0:7, colour="grey")+
  geom_vline(xintercept = 0:7, colour="grey")+
  geom_point(aes(x=Petal.Length, y=Petal.Width, col=as.factor(db$cluster)))+
  geom_point(data=petal[!db$isseed,], aes(Petal.Length,Petal.Width), shape=10)+
  theme_minimal()
```

![image-20210907213607133](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210907213607133.png)



> dbscan Pts=150 MinPts=3 eps=0.25
>        	0  1  2  3
> border 3  0  0  2
> seed   0 50 49 46
> total  3 50 49 48

3개의 클러스터가 생성되고 iris에서 50개씩 3개의 다른 종으로 구분됐지만 거의 근접하게 분배가 된 것을 볼 수 있다. (50개, 49개, 48개)



이때 주의할 점이 위에서 거리를 통해 구한 아웃라이어의 개수는 12개이지만 우리는 k+1 번째로 가까운 거리를 구했기 때문에 시각화를 통해 나온 아웃라이어는 5개라는걸 주의해야한다.

=> 이 부분에서 많은 혼란이 있었음. 거리를 시각화해서 eps를 구할 때 아웃라이어가 12개가 나왔는데 petal데이터를 시각화할때는 k를 3으로 넣어서 5개의 아웃라이어가 나왔기 때문에 k를 4개로 넣어야하는것이 아닌가? 라는 혼란이..

결론은 **적절한 MinPts와 eps를 구하기 위해서는 k(MinPts)+1 번째로 가까운 거리들을 구하고 낙차가 큰 지점에 선을 그어서 적절한 eps를 구할 수 있다는 것이다.** (논문을 읽긴했지만 정확하게 이해할 수 없었음.. 아마도 k+1을 구하는 이유는 자기자신과의 거리를 포함하기 때문에 k+1을 구한것이 아닐까?)

