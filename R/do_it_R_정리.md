## Part 3

### c( )

여러개의 문자, 숫자를 넣어줄 수 있는 함수이다. 주로 변수를 생성할 때 사용한다.

```R
var1 <- c(1,2,3,4,5)
var1
```

> var1
> [1] 1 2 3 4 5

콜론을 사용하여 연속된 숫자를 넣어줄 수 있다.

```R
var2 <- c(1:5)
var2
```

> var2
> [1] 1 2 3 4 5



### seq( )

연속된 숫자를 넣어줄 수 있는 함수이다. by를 사용하여 간격을 정해줄 수 있다.

```R
var3 <- seq(1,5,by=2)
var3
```

> var3
> [1] 1 3 5

### 변수 연산

파이썬의 배열처럼 브로드캐스팅 연산이 가능하다.

```R
var1 <- c(1:5)
var1+2
```

> var1+2
> [1] 3 4 5 6 7

변수간의 길이가 같다면 변수끼리의 연산도 가능하다.

```R
var1 <- c(1:5)
var2 <- seq(6,10)
var1+var2
```

> var1+var2
> [1]  7  9 11 13 15



### paste

여러 문자를 합쳐주는 함수. collapse 속성을 사용하여 기준을 통해 합쳐준다.

```R
str5 <- c("Hello!", "World", "is", "good!")
paste(str5, collapse = ",")
```

> paste(str5, collapse = ",")
> [1] "Hello!,World,is,good!"

### qplot

빈도 막대 그래프를 만들어주는 함수

```R
library(ggplot2)
x <- c("a", "a", "b", "c")
qplot(x)
```

![image-20210901202822904](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210901202822904.png)



qplot 내 파라미터(속성)을 설정하여 그래프의 형태를 바꿔줄 수 있다.

```R
qplot(data=mpg, x=hwy) # hwy에 대한 빈도그래프
qplot(data=mpg, x=drv, y=hwy, geom = "line") # x축에 drv, y축에 hwy를 line그래프로 표현
qplot(data=mpg, x=drv, y=hwy, geom = "boxplot") # boxplot 그래프로 표현
qplot(data=mpg, x=drv, y=hwy, geom = "boxplot",colour=drv) # color를 drv기준으로 바꿔줌
```

![image-20210901203312589](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210901203312589.png)



## Part 4



### data.frame

데이터프레임을 만들어주는 함수. padnas에서 DataFrame과 같은 역할

```R
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성

df_midterm <- data.frame(english, math)
df_midterm
```

>   english math
> 1      90   50
> 2      80   60
> 3      60  100
> 4      70   20



`$` : 데이터프레임에서 특정열을 참조할 때 사용. 이때 나온 컬럼은 판다스에선 시리즈로 불렀지만

R에서는 1차원 벡터이다.

```R
df_midterm$english
```

> [1] 90 80 60 70



한 번에 dataframe을 만들 수 있다.

```R
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm
```

>   english math class
> 1      90   50     1
> 2      80   60     1
> 3      60  100     2
> 4      70   20     2



### mean, max, min

데이터프레임열의 특정 값을 참조할 때 사용

```R
mean(df_midterm$english)
max(df_midterm$english)
min(df_midterm$english)
```

> mean(df_midterm$english)
> [1] 75
> max(df_midterm$english)
> [1] 90
> min(df_midterm$english)
> [1] 60

