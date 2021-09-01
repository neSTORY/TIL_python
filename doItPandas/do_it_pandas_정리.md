## Part 2

loc 속성 사용시 이중 대괄호로 여러개 행을 참조할 수 있다.

```python
df.iloc[[0,3]]
```

![image-20210902030112553](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210902030112553.png)

### tail

행의 뒷 부분부터 참조해주는 함수.

리턴해주는 자료의 데이터타입은 series가 아니라 dataframe로 리턴해준다.



### unique, nunique

`unique` 함수는 해당하는 컬럼, 데이터프레임에서 존재하는 값들의 종류를 리턴해준다.

set을 사용하여 중복을 제거한거랑 같은 결과라 생각하면 된다.

```python
df.groupby("continent")["country"].unique()
```

> ```
> continent
> Africa      [Algeria, Angola, Benin, Botswana, Burkina Fas...
> Americas    [Argentina, Bolivia, Brazil, Canada, Chile, Co...
> Asia        [Afghanistan, Bahrain, Bangladesh, Cambodia, C...
> Europe      [Albania, Austria, Belgium, Bosnia and Herzego...
> Oceania                              [Australia, New Zealand]
> Name: country, dtype: object
> ```



`nunique` 함수는 값의 종류마다 몇 개의 값을 갖고 있는지 리턴해주는 함수이다. (데이터의 빈도수)

```python
df.groupby("continent")["country"].nunique()
```

> ```
> continent
> Africa      52
> Americas    25
> Asia        33
> Europe      30
> Oceania      2
> Name: country, dtype: int64
> ```



## Part 3



**시리즈 메서드 정리**

|  시리즈 메서드  |                    설명                    |
| :-------------: | :----------------------------------------: |
|     append      |           2개 이상의 시리즈 연결           |
|    describe     |              요약 통계량 계산              |
| drop_duplicates |         중복값이 없는 시리즈 반환          |
|     equals      | 시리즈에 해당 값을 가진 요소가 있는지 확인 |
|   get_values    |    시리즈 값 구하기(values 속성과 동일)    |
|      isin       |      시리즈에 포함된 값이 있는지 확인      |
|     replace     |      특정 값을 가진 시리즈 값을 교체       |
|     sample      |        시리즈에서 임의의 값을 반환         |
|   sort_values   |                 값을 정렬                  |



