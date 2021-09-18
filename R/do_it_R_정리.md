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

### write

**write.csv()**를 이용해 데이터프레임을 저장할 수 있다.

```R
write.csv(df_midterm, file = "df_midterm.csv")
```



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



### summary

판다스의 describe와 같은 역할 , 각 열의 평균, 1사분위 수, 중위값, 평균, 3사분위 수 등을 알려주는 함수

```R
summary(df_midterm)
```

> english          math           class    
>
>  Min.   :60.0   Min.   : 20.0   Min.   :1.0  
>  1st Qu.:67.5   1st Qu.: 42.5   1st Qu.:1.0  
>  Median :75.0   Median : 55.0   Median :1.5  
>  Mean   :75.0   Mean   : 57.5   Mean   :1.5  
>  3rd Qu.:82.5   3rd Qu.: 70.0   3rd Qu.:2.0  
>  Max.   :90.0   Max.   :100.0   Max.   :2.0  



### read.excel()

엑셀 파일을 불러와 데이터 프레임을 만드는 함수다.

```R
df_exam_novar <- read_excel("excel_exam_novar.xlsx")
df_exam_novar
```

> New names:
> * `1` -> `1...1`
> * `1` -> `1...2`
> * `50` -> `50...3`
> * `50` -> `50...5`
> > df_exam_novar
> A tibble: 7 x 5
>
>   `1...1` `1...2` `50...3`  `98` `50...5`
>     <dbl>   <dbl>    <dbl> <dbl>    <dbl>
> 1       2       1       60    97       60
> 2       3       2       25    80       65
> 3       4       2       50    89       98
> 4       5       3       20    98       15
> 5       6       3       50    98       45
> 6       7       4       46    98       65
> 7       8       4       48    87       12

여기서 보면 New names 라 하면서 1행의 데이터의 값이 자동으로 컬럼으로 생성된걸 확인할 수 있다.

그런데 1행의 데이터는 변수명이 아닌 필요한 정보이므로 컬럼명으로 들어가는걸 막아야 한다.



그럴때는 **col_names** 파라미터를 사용하면 된다.

```R
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar
```

> New names:
> * `` -> ...1
> * `` -> ...2
> * `` -> ...3
> * `` -> ...4
> * `` -> ...5
> > df_exam_novar
> A tibble: 8 x 5
>
>    ...1  ...2  ...3  ...4  ...5
>   <dbl> <dbl> <dbl> <dbl> <dbl>
> 1     1     1    50    98    50
> 2     2     1    60    97    60
> 3     3     2    25    80    65
> 4     4     2    50    89    98
> 5     5     3    20    98    15
> 6     6     3    50    98    45
> 7     7     4    46    98    65
> 8     8     4    48    87    12

1행의 데이터가 살아있는걸 볼 수 있다.



## Part 5

### head

데이터 앞부분 확인하는 함수

데이터프레임의 6행까지를 출력해 주는 함수이다.

```R
exam <- read.csv("csv_exam.csv")

head(exam)
# head(exam, 10)
```

> id class math english science
> 1  1     1   50      98      50
> 2  2     1   60      97      60
> 3  3     1   45      86      78
> 4  4     1   30      98      58
> 5  5     2   25      80      65
> 6  6     2   50      89      98



### tail

데이터 뒷부분을 확인하는 함수

데이터프레임의 마지막부터 6행까지를 출력해주는 함수

마찬가지로 콤마 뒤 숫자로 행을 추가적으로 보거나 줄일 수 있다.

```R
tail(exam)
# tail(exam, 10)
```

>   id class math english science
>   15 15     4   75      56      78
>   16 16     4   58      98      65
>   17 17     5   65      68      98
>   18 18     5   80      78      90
>   19 19     5   89      68      87
>   20 20     5   78      83      58

### dim, str

**dim**: 행, 열의 개수를 벡터로 출력하는 함수

```R 
dim(exam)
```

> [1] 20  5

**str**: 데이터프레임의 구조를 알려주는 함수. 판다스의 info랑 비슷하다

```R
str(exam)
```

> 'data.frame':	20 obs. of  5 variables:
>  $ id     : int  1 2 3 4 5 6 7 8 9 10 ...
>  $ class  : int  1 1 1 1 2 2 2 2 3 3 ...
>  $ math   : int  50 60 45 30 25 50 80 90 20 50 ...
>  $ english: int  98 97 86 98 80 89 90 78 98 98 ...
>  $ science: int  50 60 78 58 65 98 45 25 15 45 ...



### rename

컬럼의 이름을 바꿔줄 수 있는 함수. 주의할 점은 사용하려면 dplyr 패키지를 로드해야한다는 점이다.

```R
library(dplyr)

df_new <- rename(df_new, v2 = var2)  # var2를 v2로 수정
df_new
```

> df_new
> var1 v2
> 1    1  2
> 2    2  3
> 3    1  2

재밌는점은 판다스같은 경우 바꿀것 = 기존것 이었는데 여기서는 반대라는 점이다.

종종 헷갈릴 수 있을것 같다.



### 파생변수 생성

변수를 조합하거나 함수를 적용해 새 변수를 만들어 데이터프레임에 추가할 수 있다. (새 열)

```R
df$var_sum <- df$var1 + df$var2       # var_sum 파생변수 생성
df
```

>  var1 var2 var_sum
>  1    4    2       6
>  2    3    6       9
>  3    8    1       9 

var1 컬럼과 var2 컬럼을 합쳐서 var_sum 컬럼을 생성했다.



### ifelse

조건을 기준으로 값을 나눠줄 때 사용한다.

```R
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")

# -> mpg$total이 20이상이면 "pass", 아니면 "fail"
```

ifelse에서 조건을 더 주고 싶다면 이렇게 사용하면 된다.

```R
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))
```

else에 해당하는 부분에 다시 ifelse를 사용하면 된다.



### table

해당 데이터 값의 빈도표를 생성해줌

```R
table(mpg$test)
```

> fail pass 
>  106  128 

### dplyr 패키지

데이터 처리를 하는데 사용하는 패키지이다.

###  filter

조건에 맞는 행을 추출

```R 
exam <- read.csv("csv_exam.csv")

exam %>% filter(class == 1) # class ==1인 행만 출력

# 1반이 아닌 경우
exam %>% filter(class != 1)
```

>   id class math english science
> 1  1     1   50      98      50
> 2  2     1   60      97      60
> 3  3     1   45      86      78
> 4  4     1   30      98      58
>
>    id class math english science
> 1   5     2   25      80      65
> 2   6     2   50      89      98
> 3   7     2   80      90      45
> 4   8     2   90      78      25
> 5   9     3   20      98      15
> 6  10     3   50      98      45
> 7  11     3   65      65      65
> 8  12     3   45      85      32
> 9  13     4   46      98      65
> 10 14     4   48      87      12
> 11 15     4   75      56      78
> 12 16     4   58      98      65
> 13 17     5   65      68      98
> 14 18     5   80      78      90
> 15 19     5   89      68      87
> 16 20     5   78      83      58

조건을 여러개를 줄 수도 있다.

```R
# 1반이면서 수학 점수가 50점 이상인 경우 -> and
exam %>% filter(class == 1 & math >= 50)

# 수학 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우 -> or
exam %>% filter(math >= 90 | english >= 90)
```

> exam %>% filter(class == 1 & math >= 50)
> id class math english science
> 1  1     1   50      98      50
> 2  2     1   60      97      60
>
> exam %>% filter(math >= 90 | english >= 90)
> id class math english science
> 1  1     1   50      98      50
> 2  2     1   60      97      60
> 3  4     1   30      98      58
> 4  7     2   80      90      45
> 5  8     2   90      78      25
> 6  9     3   20      98      15
> 7 10     3   50      98      45
> 8 13     4   46      98      65
> 9 16     4   58      98      65

### select

열을 추출하는 함수. 제외하는 용도로도 사용할 수 있다

```R
exam %>% select(math) # math 추출
exam %>% select(class, math, english) # class, math, english 변수 추출
exam %>% select(-math, -english) # math, english 제외
```



### arrange

정렬해주는 함수

```R
exam %>% arrange(math)         # math 오름차순 정렬
exam %>% arrange(desc(math))   # math 내림차순 정렬

# 여러 조건을 기준으로 정렬 가능
exam %>% arrange(class, math)
```



### mutate

새로운 변수 추가를 해주는 함수. 파생변수를 만드는것이다.

```R
exam %>%
  mutate(total = math + english + science) %>%  # 총합 변수 추가
  head
```

mutate(새로운 변수명 = 기존 변수들 )



### summarise

통계치를 산출해주는 함수이다.

```R
exam %>% summarise(mean_math = mean(math))
```

>   mean_math
> 1     57.45

mean_math라는 컬럼명을 지정해줬는데, 지정하지 않아도 수식이 컬럼명으로 들어간다.

>   mean(math)
> 1      57.45



### group_by

집단별로 나누는 함수. 이것만 사용해서는 결과를 못 얻고 다른 함수들과 같이 사용한다.

```R
exam %>% 
  group_by(class) %>%                   # class별로 분리
  summarise(mean_math = mean(math))
```

> A tibble: 5 x 2  
>
> class mean_math
>   <int>     <dbl>
> 1     1      46.2
> 2     2      61.2
> 3     3      45  
> 4     4      56.8
> 5     5      78 



여러 통계치를 볼 수 있다

```R
exam %>% 
  group_by(class) %>%                   # class별로 분리
  summarise(mean_math = mean(math),     # math 평균
            sum_math = sum(math),       # math 합계
            median_math = median(math), # math 중앙값
            n = n())                    # 해당 class 학생 수
```

> class mean_math sum_math median_math     n
>   <int>     <dbl>    <int>       <dbl> <int>
> 1     1      46.2      185        47.5     4
> 2     2      61.2      245        65       4
> 3     3      45        180        47.5     4
> 4     4      56.8      227        53       4
> 5     5      78        312        79       4



### left_join

데이터를 가로로 합쳐주는 함수

```R
test1 <- data.frame(id = c(1, 2, 3, 4, 5),           
                    midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 5),           
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = "id")  # id 기준으로 합쳐서 total에 할당
total                                        # total 출력
```

>   id midterm final
> 1  1      60    70
> 2  2      80    83
> 3  3      70    65
> 4  4      90    95
> 5  5      85    80

### bind_rows

데이터를 세로로 합쳐주는 함수

```R
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b)  # 데이터 합쳐서 group_all에 할당
group_all 
```

>    id test
> 1   1   60
> 2   2   80
> 3   3   70
> 4   4   90
> 5   5   85
> 6   6   70
> 7   7   83
> 8   8   65
> 9   9   95
> 10 10   80

