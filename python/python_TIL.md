





## Day 1



### 연산

나누기 

```python
print(4/2) # 나누기 연산자.
print(4//2) # 몫 구하기
print(5%3) # 나머지 구하기
print(divmod(5,3)) # 몫과 나머지 구하기 튜플로 출력됨
```

## 기본 함수

### split

구조 : 문자열.split("문자")

```python
x = "abhiabhelloab"
x.split("ab")
```

> 출력 : ['', 'hi', 'hello', '']

"ab"를 기준으로 나눠서 리스트에 저장해준다.



### len

길이를 구해준다.

구조 : len(s) 

s에는 문자열, 리스트, 튜플 같은 순서를 갖는 것들은 가능

```python
s = "Life is too short"
print(len(s))
```

> 17



### replace

문자열에서 특정 문자를 바꿔줌

구조  : string.replace("기존 문자","바꿀 문자")

```python
s = "saience" # a -> c 로 바꾸고 싶음

# s[1] = "c" # 문자열 하나만 바꾸는게 불가능

a = s.replace("a","c") # 바꾸려면 replace 사용
print(a)
```

> science



## Day 2

### map

지정된 함수에서 각각의 요소에 적용함수를 적용해 줌

구조 : map(적용함수, 지정함수)

```python
x, y = map(int, input("숫자 입력 : ").split()) # 리스트 안의 요소들이 정수형으로 바뀜
print(x+y)
```

> 숫자 입력 : 5 3
>
> 8



## 비교연산자, 논리연산자

연산 결과가 boolean 형

#### 비교 연산자 `==` , `!=`

```python
'test' == 'test' # True
'test' != 'test' # False

'Trump' 'trump'
'sky' 'Sky'
# 의미는 같지만 대소문자의 차이로 서로 다른 문자로 인식
# 자연어 전처리 과정에서는 대소문자를 통일하는 작업을 수행
```



#### 논리연산자 `and` `or` `not`

```python
# and : 모두 다 참인경우만 참이되는 연산자
True and False # Falsebo
True and True # True

# or : 적어도 하나 이상이 참인 경우 참이되는 연산자
True or False
True or True

# not : 참 -> 거짓, 거짓 -> 참
not True

# 논리 연산자 우선순위 : not > and > or
not True and False # == False and False
```

```python
1==1 and 1!=2
# 비교연산자 2개, 논리연산자 1개
# 우선순위: 비교연산자 > 논리연산자
```

> True



### bool

정수, 실수, 문자 -> 불린형태로 리턴해줌

```python
# bool(): 정수, 실수, 문자 -> 불린형태로
bool(100) # True
bool(-100) # True
bool(1) # True
bool(0) # False

bool(3.14) # True
bool(-1.1) # True
bool(0.1) # True
bool(0.0) # False

bool("a") # True
bool("Test") # True
bool("") # False 공백문자도 없이 아무것도 없는 경우에만 False
```



### 포매팅

```python
a = int(input("숫자를 입력 : "))
b = "three"
c = 2.1

print("I eat %d apples" % a) # d -> digit(수)의 약자 : 정수만
print("I eat %s bananas" % b) # s -> string(문자열)의 약자
print("I eat %f apples" % c) # f -> float의 약자 실수형태(소수점 6자리까지 나옴)
print("I eat %.1f apples" % c)

# "Acuuracy is 90%"를 표기할 때 (%표기 방법)
print("Accuracy is %d%%" %90) # %%를 사용하여 표기
```

> 숫자를 입력 : 5
> I eat 5 apples
> I eat three bananas
> I eat 2.100000 apples
> I eat 2.1 apples



```python
print("I ate %d apples. so I was sick for %s days" %(3, "three"))
print("I ate %d apples. so I was sick for %s days" %(num, day))
print("I ate {0} apples. so I was sick for {1} days".format(num,day))
# {0}: format 함수의 첫 번째 인수
# {1}: format 함수의 두 번째 인수
```

> I ate 3 apples. so I was sick for three days
> I ate 3 apples. so I was sick for five days
> I ate 3 apples. so I was sick for five days



**정렬**

```python
print("%s" %"hello")
print("%10s" %"hello") # 10칸 확보 후 우측으로 정렬
print("%-10s" %"hello") # 10칸 확보 후 좌측으로 정렬
```

> hello
>      hello
> hello     

```python
print("{0:<10}".format("hello"))
# :<10 의 의미? 전체 자리수가 10자리, 왼쪽 정렬
# 0의 의미는 포맷함수 인수의 위치
print("{0:^10}".format("hello")) # 가운데 정렬
print("{0:$^10}".format("hello")) # $는 공백 채우는 용도
```

> hello     
>   hello   
> $$hello$$$



### count

문자열, 리스트, 튜플 내 요소의 개수를 찾아줌

```python
"data".count("a")

x = "data"
x.count("a")
```

> 2



### find

문자열 내 데이터의 인덱스를 리턴해줌

찾는 데이터가 1개 이상일 경우 첫 번째 데이터의 인덱스를 리턴

```python
x = "data"

print(x.find("a")) # "a"의 위치, 0번부터 시작
print(x.find("b")) # 문자가 없는 경우에는 -1이 리턴
```

> 1
>
> -1



### index

문자열, 리스트, 튜플 내 데이터의 인덱스를 리턴해 줌

```python
x = "data"

print(x.index("a"))
print(x.index("b")) # 문자가 없는 경우에는 오류가 발생
```

> 1
>
> ---------------------------------------------------------------------------
> ValueError                                Traceback (most recent call last)
> <ipython-input-26-e2912b22947e> in <module>
>       2 
>       3 print(x.index("a"))
> ----> 4 print(x.index("b")) # 문자가 없는 경우에는 오류가 발생
>
> ValueError: substring not found



### replace

문자열에서 요소를 바꿔줌

```python
# "a,b,c,d" => "abcd"
x = "a,b,c,d"
print(x.replace(",",""))
```

> "abcd"



### split

문자열에서 지정 요소를 기준으로 분리하여 리스트형태로 리턴해 줌

```python
x = "a,b,c,d"
res = x.split(",")
print(res)
```

> ['a', 'b', 'c', 'd']



### join

지정 요소를 기준으로 리스트 내 요소들을 문자열로 리턴해줌

```python
print(",".join(res))
# res에 저장되어 있는 각각의 문자가 컴마로 연결

# split <-> join
```

> a,b,c,d



### capitalize, upper, lower

- `capitalize`는 첫 글자만 대문자로 변환
- `upper`는 모든 글자를 대문자로 변환
- `lower`는 모든 글자를 소문자로 변환

```python
print("test".capitalize())
print("test".upper())
print("test".lower())
```

> Test
> TEST
> test

### sep

print 할 때 사용함. 간격 제거 할 때 많이 사용

```python
a = " hello "
b = "hi"
print(a, b, sep="")
```

> hello hi



### strip

공백을 제거할 때 사용

- strip은 양쪽 공백제거
- lstrip은 왼쪽 공백제거
- rstrip은 오른쪽 공백제거

```python
a = "hello"

print(a.strip())
print(a.lstrip())
print(a.rstrip())
```

> hello
> hello   
>    hello



### 리스트

리스트는 데이터들을 모아주는 역할을 함. 배열같은 존재

리스트변수명  = [요소값1, 요소값2, 요소값3]으로 정의해줌

```python
a = [] # 빈 리스트
a2 = [10, 20, 30] # 요소(element)
a3 = ["hi", "hello"]
a4 = [10, 20, "hi",True] # 여러 자료형 올 수 있음

a6 = list() # 함수를 사용해서 리스트 표현도 가능
```

```python
#    0    1   2   3 
a = [10, 20, 30, 40]
a = [10, 20, 30,40, [50,"a","b"]] # 리스트는 리스트를 요소값으로 할 수 있다

print(a[4][1])
```

> "a"  # a리스트의 5번째 요소값중 2번째 요소이므로 문자열 "a" 가 출력됨



리스트는 문자열처럼 슬라이싱도 가능함

```python
a = [10, 20, 30, 40, 50]
a [0:3]
```

> [10,20,30]



리스트는 연산도 가능함

```python
a= [10, 20]
b= [30, 40]

print(a+b) # 리스트 요소의 합을 리턴
print(a*3) # 리스트의 요소들을 반복
```

> [10,20,30,40]
>
> [10,20,10,20,10,20]



### range

범위를 나타내는 데이터 타입

```python
range(0,10) # 0 ~ 9 까지의 범위를 갖는 range 객체
list(range(5)) # 리스트 구조로 요소가 0 ~ 4 까지 들어감
print(list(range(10,50,3))) # 10 ~ 49까지 등차가 3만큼 들어감
```

> ```
> [10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49]
> ```



### append

리스트의 맨 마지막에 데이터를 추가해 > 줌

```python
a = [10, 20]
a.append(30)
a.append([100,200]) # 리스트를 추가하는 것도 가능
b = 20
a.append(b)
print(a)
```

> ```
> [10, 20, 30, [100, 200], 20]
> ```



### sort

정렬해주는 기능을 가진 함수

```python
a = [30, 10, 20]
a.sort()
print(a)

# 문자는 ascii코드 값을 기준으로 정렬 (A:65 ~ Z:90 , a:97 ~ z:122)
# 인코딩 : 코드화(문자, 숫자 등 -> 코드(0,1))하는 작업
# 디코딩 : 코드(0,1) -> 문자, 숫자 등

# 인코딩 / 디코딩 방식 : ascii, ebcdic, bcd, utf8, utf16, euc-kr 등등
# 아스키 : 모든 문자/숫자를 7비트로 표현(7비트 = 2의 7승 = 128가지 문자를 표현 가능)
# 0~127까지 코드

b = ["b","c","Z","t","v"]
b.sort()
print(b)
```

> ```
> [10,20,30]
> ['Z', 'b', 'c', 't', 'v']
> ```



### reverse

순서를 반대로 나열해주는 함수

```python
a = ["b","c","Z","t","v"]
# a.reverse() # 역순으로 나열
print(a)

# a 를 내림차순으로 표현하고 싶으면..1
a.sort()
a.reverse()
a
```

> ```
> ['v', 't', 'Z', 'c', 'b']
> ```
>
> ```
> ['v', 't', 'c', 'b', 'Z']
> ```



sort 함수에 옵션을 추가하여 내림차순으로 정렬가능

```python
a = ["b","c","Z","t","v"]
a.sort(reverse=True)
print(a)

a = ["b","c","Z","t","v","0",chr(95)]
a.sort(reverse=True)
print(a)
```

> ```
> ['v', 't', 'c', 'b', 'Z']
> ['v', 't', 'c', 'b', '_', 'Z', '0']
> ```



## Day 3



### insert

리스트내 특정 위치에 데이터를 삽입

```python
# append는 마지막 위치에만 삽입이 가능했음
a = [10, 20, 30]
a.append(100)

print(a)
```

> ```
> [10, 20, 30, 100]
> ```



insert는 위치를 정해줄 수 있음

```python
a.insert(1, 15) # (들어갈 index 위치 , 요소 값)
print(a)
```

> ```
> [10, 15, 20, 30, 100]
> ```



### extend

리스트 마지막에 요소값들을 넣어줌

**그렇다면 append와의 차이는?** append는 리스트 통으로 넣지만 extend는 요소들을 분해하여 넣어줌

```python
# append

a = [10, 20, 30]
b = [1,2,3]

a.append(b)
print(a)
```

> ```
> [10, 20, 30, [1, 2, 3]]
> ```

```python
a = [10, 20, 30]
b = [1,2,3]

a.extend(b)
print(a)
```

> ```
> [10, 20, 30, 1, 2, 3]
> ```



### remove

맨 앞에 요소를 삭제해줌. **전체를 삭제하는 것이 아님!!**

구조 : remove(요소값)

```python
a = [10, 20, 10, 20]
a.remove(10)

print(a)
```

> ```
> [20, 10, 20]
> ```



### pop

가장 마지막 요소를 꺼낸다음 제거

다른 변수 생성 후 pop을 통해 꺼낸 요소를 저장해줄 수 있음

```python
# pop에 위치를 지정하지 않았을 시

a = [10,20,30,40]
a.pop()
print(a)
```

> ```
> [10, 20, 30]
> ```

```python
# pop에 index 위치를 지정했을 때

a = [10,20,30,40]
a.pop(1)
print(a)
```

> ```
> [10, 30, 40]
> ```



### 튜플

리스트와 비슷한 데이터 저장을 해주는 객체

리스트는 대괄호[ ]를 사용했지만 튜플은 소괄호( )를 사용

리스트는 데이터를 생성, 수정, 삭제 등 변경이 가능했지만 **튜플은 데이터를 변경할 수 없음**

```python
tup1 = () # 튜플도 빈 튜플을 만들 수 있음
print(tup1)
print(type(tup1))

tup2 = (1)
print(tup2)
print(type(tup2)) # 튜플안에 기호(콤마)를 넣어줘야 int로 안 나옴

tup2 = (1,)
print(tup2)
print(type(tup2)) # 튜플은 ',' (콤마)를 사용해야 튜플로 인식함!

tup3 = (10, 20, 30)
print(tup3)

tup4 = 1,2 # 소괄호를 안 써도 튜플로 인식되긴 함. 근데 쓰지 말도록 하자
print(tup4)
```

> ```
> ()
> <class 'tuple'>
> 1 # 콤마를 사용하지않아서 int로 인식됨
> <class 'int'>
> (1,)
> <class 'tuple'>
> (10, 20, 30)
> (1, 2)
> ```



튜플은 데이터의 변경이 불가능했지만 리스트로 변환해준다음 데이터 수정 후 다시 튜플로 변환하면 튜플의 데이터 변경이 가능함

```python
# tup의 1번 인덱스 요소 20을 2로 바꾸기

tup = (10,20,30,40)
tup = list(tup)

tup[1] = 2 # 자료 변경
tup = tuple(tup)

print(tup)
```

> ```
> (10, 2, 30, 40)
> ```



튜플의 자료변경은 불가능하지만 index번호를 통해 참조는 가능하다

```python
tup5 = (10, 20, "가", "나")

print(tup5[3])
```

> ```
> '나'
> ```



리스트처럼 튜플도 '+' 와 '*'를 통해서 반복과 합치기가 가능하다

```python
tup3 = (10, 20, 30)
tup5 = (10, 20, "가", "나")

print(tup3 + tup5)
print(tup3 *3)
```

> ```
> (10, 20, 30, 10, 20, '가', '나')
> (10, 20, 30, 10, 20, 30, 10, 20, 30)
> ```



### set

파이썬에서 "집합"을 의미한다

중괄호{ }를 사용하고 콤마를 통해 요소들을 구분해 준다

```python
s1 = {1,2,3,1,2,4}
print(s1)
s2 = {"hi", "hello", "bye", "hi"}
print(s2) # 자료 위치가 랜덤하게 출력. 저장 순서가 없음 => 대괄호 기호를 사용하여 데이터 참조를 할 수 없음
```

> ```
> {1, 2, 3, 4}
> {'hello', 'bye', 'hi'}
> ```



set의 특징은 **중복을 허용하지 않고 순서가 없음!!**

```python
a = set("hello")
print(a) # 튜플처럼 중복이 제외된 상태에서 분해되어 저장됨
```

> ```
> {'l', 'e', 'h', 'o'}
> ```

한글도 중복은 허용되지 않는다.

```python
set_han = set("반갑습니다반갑고요") # 한글을 넣어도 중복 제거
print(set_han)
```

> ```
> {'고', '습', '갑', '요', '다', '니', '반'}
> ```



리스트, 튜플과 다르게 빈 set이란 없음. 중괄호안에 빈 요소를 넣으면 dict 타입이 됨

```python
a = {10, 20, 30}
b = {30, 40, 50}
c = {}
print(type(a),type(b),type(c))
```

> ```
> <class 'set'> <class 'set'> <class 'dict'>
> ```



집합에서 pop 함수도 사용가능

```python
a = {10, 20, 30}

a.pop() # set에서 사용가능
print(a)

a.pop()
print(a)

a.pop()
print(a)
```

> ```
> {20, 30}
> {30}
> set()
> ```



### 집합의 연산자

- or 연산자(합집합) : bar ( | )를 사용하거나 set.union함수를 사용해줌

  ```python
  a = {10, 20, 30}
  b = {30, 40, 50}
  
  print(a | b)
  print(set.union(a,b))
  ```

  > ```
  > {50, 20, 40, 10, 30}
  > ```
  >
  > ```
  > {10, 20, 30, 40, 50}
  > ```



- and 연산자(교집합) : and( & )를 사용하거나 set.intersection함수를 사용해줌

  ```python
  a = {10, 20, 30}
  b = {30, 40, 50}
  
  print(a & b)
  print(set.intersection(a,b))
  ```

  > ```
  > {30}
  > {30}
  > ```



- 차집합 : 마이너스( - )를 사용하거나 set.difference함수를 사용해줌

  ```python
  a = {10, 20, 30}
  b = {30, 40, 50}
  
  print(a - b)
  print(set.difference(a,b))
  ```

  > ```
  > {10, 20}
  > {10, 20}
  > ```



- xor 연산자(대칭차집합) : ^ 를 사용함. 교집합을 제외한 합집합

  ```python
  a = {10, 20, 30}
  b = {30, 40, 50}
  print(a ^ b)
  ```

  > ```
  > {40, 10, 50, 20}
  > ```



### 집합 내 자료 변경

- add : 집합 내 자료 추가

  ```python
  a = {10, 20, 30}
  a.add(40) # 추가할 자료를 괄호안에 넣음
  print(a)
  ```

  > ```
  > {40, 10, 20, 30}
  > ```



- remove : 집합 내 자료 제거

  ```python
  a = {10,20,30,40}
  a.remove(20) # 제거할 자료를 괄호안에 넣음
  print(a)
  ```

  > ```
  > {40, 10, 30}
  > ```



- discard : remove와 마찬가지로 자료를 제거해줌. 차이점은 집합 내 없는 자료를 입력하면

  remove는 error가 발생하지만 discard는 error가 발생하지 않음

  ```python
  a = {10,30,40}
  
  print(a.discard(20))
  print(a.remove(20))
  ```

  > ```
  > None
  > ---------------------------------------------------------------------------
  > KeyError                                  Traceback (most recent call last)
  > <ipython-input-40-95d9d5cf748d> in <module>
  >       5 
  >       6 print(a.discard(20))
  > ----> 7 print(a.remove(20))
  >       8 print(a)
  >       9 
  > 
  > KeyError: 20
  > ```



### clear

리스트,  집합, dictionary 내 자료들을 모두 삭제해줌. 튜플은 사용불가!!(튜플은 데이터 변경이 불가능하다!)

```python
n = [1,2,3,4]
n.clear()
print(n)

b = {1,2,3}
print(b.clear())

c = {"name" : "nes"}
print(c.clear())
```

> ```
> []
> None
> None
> ```



### 집합의 복사

s1이란 집합을 s2라는 변수를 생성하여 대입하면 s1과 s2는 다른 변수일까?

```python
s1 = {10, 20, 30}

s2 = s1

print(s2)
```

> ```
> {10, 20, 30}
> ```



겉보기엔 s2라는 같은 데이터를 지닌 집합이 만들어진 것 처럼 보인다.

그러나 대입연산자를 사용해보면 둘은 같은 집합이란걸 알게된다.



```python
s2.add(40)
print(s2)
print(s1)
```

> ```
> {40, 10, 20, 30}
> {40, 10, 20, 30}
> ```



분명히 s2에만 add를 사용했지만 s1에도 같은 결과가 반영됐다는것을 확인할 수 있다.

is 연산자를 확인하여 boolean값을 확인해 보자.



```python
# is : s1, s2 집합이 동일한 집합인지 확인하는 연산자

print(s1 is s2)
```

> ```
> True
> ```



결과로 True값이 리턴된 것을 볼 수 있다.

그렇다면 s1과 같은 데이터를 갖는 s2라는 다른 집합을 만들려면 어떻게 해야할까?

copy함수를 사용하면 다른 집합을 갖게 된다.

```python
# copy() : 두 개의 완전히 분리된 집합을 생성하기 위한 함수

a = {10, 20, 30}
# b = a 동일한 집합

b = a.copy()
print(a)

# is : 두 집합이 동일한지(메모리 상의 주소, 위치) 확인
print(b is a) # a, b 두 집합은 서로 다른 집합이 됐음
# False의 의미? -> a 집합과 b 집합의 자료들이 메모리 상의 다른 위치에 저장되어 있음을 의미!

# ==: 두 집합에 속해있는 요소{1, 2, 3}가 동일한지 확인
print(a == b) # 요소가 같아서 True가 나옴
```

> ```
> {10, 20, 30}
> False
> True
> ```



copy를 사용하면 둘은 같은 값을 가지지만 두 집합의 저장은 서로 다른 메모리에 저장되었기 때문에

**is 연산자를 사용하면 다르다고 나온다. 그렇지만 equal기호 == 을 사용하면 갖고 있는 데이터값은 같기 때문에 True가 리턴된다.**

마지막으로 add함수를 사용하여 b의 값과 a의 값이 다르게 출력되는지 확인해보자.

```python
b.add(40)
print(b, a, sep="\n") # 서로 다른 요소를 갖게 됨 <- copy를 해서 사본을 만들었기 때문
```

> ```
> {40, 10, 20, 30}
> {10, 20, 30}
> ```



copy를 사용 할 경우  다른 값이 출력되는 것을 확인할 수 있다!



### dictionary

중괄호 { }를 사용하는 자료구조로 {키(key) : 값(value)}의 구조로 구성된다.

cf. json 파일이 딕셔너리 구조로 이루어져 있다.

```python
people = {"name":"kim",
          "cp":114,
          "birth":"0707",
         10:"ten"}

print(people)

# 값이 확정이 안되어있으면 value 값을 None 으로 초기화시켜놓으면 됨

# 키 이름이 중복될 경우
people = {"name":"kim",
          "cp":114,
          "birth":"0707",
         10:"ten", "cp":119, # 마지막 키에 해당하는 값이 저장됨
         "nickname":["ai", "robot"]} # 밸류에 리스트형태로 쓸 수 있음(키는 안됨)
print(people)
```

> ```
> {'name': 'kim', 'cp': 114, 'birth': '0707', 10: 'ten'}
> {'name': 'kim', 'cp': 119, 'birth': '0707', 10: 'ten', 'nickname': ['ai', 'robot']}
> ```



dict 함수를 통하여 딕셔너리를 생성할 수 있음.

```python
mydic = dict(name = "kim", cp = 114) # dict 함수에서는 키에 ""을 쓰면 안됨
# mydic = dict("name" = "kim", "cp" = 114) 에러 발생!
# dic 함수에서는 숫자(int)를 key로 사용하지 못함!
print(mydic)
```

> ```
> {'name': 'kim', 'cp': 114}
> ```

딕셔너리에서는 키 값에 int형을 사용할 수 있지만 dict 함수에서는 키 값에 int형을 사용하지 못함.

why? dict 함수에서는 키를 정의할 때 ""없이 정의하기 때문에 int를 넣어도 문자열로 키가 정의됨.



zip함수와 dict 함수를 활용하여 딕셔너리를 생성할 수 있다.

그렇지만 잘 쓰지 않는 방법이다.

```python
print(zip(["one", "two"],[1,2]))
# 이 상태는 포장되어 있는 상태라 볼 수 없음

print(dict(zip(["one", "two"],[1,2])))
# zip([key 값], ["value 값"])으로 표현
```

> ```
> <zip object at 0x000001D92C02B640> # zip객체로 저장이 되어있음
> {'one': 1, 'two': 2}
> ```



딕셔너리에서 키에 해당하는 값 추출하기

```python
mydic = dict(name = "kim", cp = 114)
print(mydic["name"])
```

> kim



밸류 값 변경을 해보자

```python
mydic["cp"] = 119 # value 값 변경

print(mydic)
```

> ```
> {'name': 'kim', 'cp': 119}
> ```



데이터 추가도 가능하다.

```python
mydic["bloodtype"] = "B" # 데이터 추가하는 방법

print(mydic)
```

> ```
> {'name': 'kim', 'cp': 119, 'bloodtype': 'B'}
> ```



in 연산자를 통해 딕셔너리에 어떤 키가 존재하는지 확인도 가능하다.

```python
print("gender" in mydic) # False
print("name" in mydic) # True
```

> False
>
> True



key 값들과 value값들을 모두 리턴하고 싶으면 어떡할까?

```python
res_key =mydic.keys() # mydic 안에 있는 key 값들을 보여줌
res_val = mydic.values() # mydic 안에 있는 value  값들을 보여줌
res_item = mydic.items() # mydic 안에 있는 key, value 값을 튜플로 묶어서 보여줌

print(res_key)
print(res_val)
print(res_item)

print(list(mydic.items()))
print(list(mydic.items())[0]) # 리스트이기 때문에 인덱스 사용가능
print(list(mydic.items())[0][1]) # 첫 번째가 튜플이기때문에 추가로 인덱스 또 사용가능
```

> ```
> dict_keys(['name', 'cp', 'bloodtype'])
> dict_values(['kim', 114, 'B'])
> dict_items([('name', 'kim'), ('cp', 114), ('bloodtype', 'B')])
> [('name', 'kim'), ('cp', 114), ('bloodtype', 'B')]
> ('name', 'kim')
> kim
> ```

여기서 .keys(), values, items 함수를 사용하면 dict 객체로 리턴해주기 때문에 list함수를 사용하여 결과값을 활용해줄 수 있다.



리스트 내 튜플을 요소로 활용하여 딕셔너리를 만들어 줄 수 있다.

```python
li=[('name', 'kim'), ('cp', '119'), ('bloodtype', 'B')]
mydic = dict(li)
print(mydic)
```

> ```
> {'name': 'kim', 'cp': '119', 'bloodtype': 'B'}
> ```



get함수를 활용하여 키 값을 찾아보거나 없는 키 값에 value 값을 넣어보자

```python
mydic["cp"] # == mydic.get("cp")

# mydic["addr"] # 해당 키가 없는 경우에는 에러 발생
print(mydic.get("addr")) # 에러없이 None 값 발생
print(mydic.get("addr", "서울")) # 없는 키값에 value값을 넣어줄 수도 있음

print(mydic.get("bloodtype", "A"))
# 키가 존재하면 값을 리턴, 키가 존재하지 않으면 A를 디폴트값으로 리턴

print(mydic)
```

> ```
> None
> 서울
> B
> {'name': 'kim', 'cp': '119', 'bloodtype': 'B'}
> ```

"addr"라는 키가 없어서 mydic["addr"]을 하면 error가 발생하지만 get 함수는 None을 리턴해준다.

또한 get 함수를 통해 없는 키 값에 value를 넣어줄 수 있지만 그렇다고 dictionary에 자료를 추가해주는 것은 아니라는 점을 확인할 수 있다.



del을 활용하여 dictionary, 리스트 내 요소들을 삭제해 줄 수 있다. 이때 리스트는 index를 사용해야 한다. 딕셔너리는 대괄호에 index를 사용하지 않고 key 값을 사용해주기 때문에 다르다.

```python
del mydic["cp"]
print(mydic)

n = [10,20,30,"가",40]

del n[1]
print(n)
```

> ```
> {'name': 'kim', 'bloodtype': 'B'}
> [10, 30, '가', 40]
> ```



## Day 4



### if 문

if 조건 :

​	실행문

elif 다른 조건:

​	실행문

else:

​	실행문

if 문 밑에 elif 를 사용하지 않고 다시 if 를 사용하는 것은 비효율적인 코드임

```python
# 바람직하지 않은 코드

gender = "여성"

if gender == "여성":
    print("여성")
if gender == "남성": # -> 여기까지 수행을 함
    print("남성")
```

> 여성

why? 위에 조건을 만족하더라도 다시 밑에 if 문을 실행하기 때문임. 이를 막으려면 elif를 사용하면됨. elif는 위에 if문을 만족하면 밑에 elif는 실행하지 않기 때문임.

```python
# 바람직한 코드

gender = "여성"

if gender == "여성":
    print("여성")        # -> 여기까지 수행을 함
elif gender == "남성":
    print("남성")
```

> 여성



한 줄로도 if문을 작성할 수 있다.

```python
x =1

# if x==0:
#     y =x
# else:
#    y = 0
# 이것을 한 줄 if문으로 작성한다면?

y = x if x== 0 else 0
# x와 0이 같다면 x값을 y에게, 같지 않다면 0을 y에게 대입해라
```

> ```
> 0
> ```



조건문에 False 값을 넣으면 진행이 안된다. -> 조건문 자체가 거짓이기 때문에!

```python
if False:
    print("참")
    
# 조건문에 False, None, 0(이거 3개 전부 Fasle임)같이 False(거짓)을 넣으면 진행안됨.
# 조건자체가 거짓이기 때문에!

# 비어있는 리스트(튜플, 딕셔너리) 또한 거짓
```

> 실행이 안된다!!



한 줄 if문에 elif는 사용하지 못 하지만, else를 활용하여 표현할 수 있다.

```python
# if elif else 구조
# A if 조건 else B if 조건 else C

ani = "cow"
cat = "cat"
dog = "dog"

res = dog if ani == dog else cat if ani == cat else "cow"

# 만약에 ani == dog 이면 dog 이 저장, 그렇지 않고
# 만약에 ani == cat 이면 cat 이 저장, 그렇지 않으면 cow가 저장


print(res)
```

> ```
> cow
> ```

한 줄 if문은 조건이 많아지면 복잡해지기 때문에 조건이 많다면 한 줄로 쓰지말도록 하자!



### for문

구조.

for 변수 in ragne(횟수):

​	반복문장

```python
# for i in range(10): # range(10) 범위 : 0 ~ 9 까지의 값이 차례대로 i 에 저장됨
#     print(i)

i = 1

# for _ in range(10): # '_' 언더바 입력시 : range(10)의 값을 무시하고 횟수만 10번 반복함
#     print(i)

x, _, y = 1,2,3 # '_' 는 무시됨
print(x)
print(y)
```

> ```
> 1
> 3
> ```



for 문에 sequence 객체를 작성하여 반복처리 할 수 있다.

`sequence 객체`? 리스트, 튜플, 문자열 등 순서가 있는 객체를 의미한다 -> set, dict는 순서가 없어서 포함되지 않는다.

```python
for i in [10,20,30]:
    print(i)
```

> ```
> 10
> 20
> 30
> ```



cf. set, dict는 시퀀스객체로 볼 수 없지만, 최근 버전에서는 for문에 처리가 가능하다.

```python
for s in {10,20,30}:
    print(s)
    
for i in {"name":"ns", "age":10, "gender":"male"}:
    print(i)
```

> ```
> 10
> 20
> 30
> name
> age
> gender
> ```





### while 문

구조.

while 조건 :

​	수행문장

```python
i = 0

while i <101: # i 변수 값이 101보다 작다는 조건을 만족하는 동안 반복해라!
    i += 1
    print(i)
```

> 1 ~ 100 까지가 출력. 너무 길어서 글로 대체..



### import

파이썬 내는 모듈, 패키지(라이브러리)가 있다. 남들이 정리해 놓은 함수들을 정리해 놓은 모듈이나 라이브러리를 사용할 수 있는게 import 다.

모듈 : 관련 함수의 집합, 일반적으로 파이썬 파일

패키지(라이브러리) : 관련 모듈의 모임, 폴더, 패키지도 포함

라이브러리 : 파이썬 표준 라이브러리(모듈, 패키지 모두 포함)



ex)

```python
# import 파이썬 모듈 불러오기
import math
```

```python
# math.함수()
# math.변수
# math.클래스()

print(math.pi)
print(math.sqrt(4)) # 제곱근을 구하는 함수
```

> ```
> 3.141592653589793
> 2.0
> ```



축약형으로 사용할 수 도 있다. 축약하면 좀 더 편리하긴한데 남들이 봤을 때 이해하기 어렵다는 단점이 있다.

```python
import math as mt # 축약형
mt.sqrt(4)
```

> 2.0



from 모듈명 import 함수(변수, 클래스)명

이 구조를 사용하여 전체 모듈을 불러오지 않아서 메모리를 적게 쓸 수 있다.

```python
from math import sqrt # math 모듈안에 있는 sqrt 함수만 불러와줘

sqrt(25) # math.도 필요없음
```



import 후 del 모듈명 을 사용하면 메모리에서 모듈을 제거해줄 수 있다.

```python
import math

# math 모듈 사용 다 함

del math # 메모리에서 math 모듈 제거
```



### random 모듈

랜덤관련 모듈이다.

- randrange : 범위 내 난수 1개 뽑아줌

  **range이므로 끝에수는 포함하지 않는다**(이게 randint와의 차이점!!)

  구조 : random.randrange(범위)



- randint : 범위 내 난수를 1개 뽑아줌. 얘는 범위 끝 수를 포함시킴

  구조 : random.randint(범위)

  ```python
  import random
  
  for i in range(6):
      print(random.randint(1,3)) # 1 ~ 3 범위에서 난수 1개 발생
  ```

  > ```
  > 1
  > 2
  > 2
  > 3
  > 3
  > 2
  > ```



- choice : 범위 내에서 1개를 임의로 선택

  구조 : random.choice(시퀀스 객체)

  ```python
  print(random.choice([1,2,3]))
  print(random.choice("hello")) # 복원 추출 (반복 시 복원해서 추출을 함)
  ```

  > ```
  > 1
  > e
  > ```



- sample : 지정 범위, 추출 개수를 통해 표본을 리스트 객체로 만들어 준다.

  구조 : random.sample(시퀀스 객체, 추출 개수)

  ```python
  import random
  
  for i in range(5):
      print(random.sample(range(46),6))
  ```

  > ```
  > [34, 2, 5, 21, 23, 1]
  > [13, 41, 37, 33, 39, 12]
  > [33, 22, 28, 45, 25, 38]
  > [42, 2, 28, 39, 32, 18]
  > [43, 26, 35, 16, 30, 33]
  > ```



## Day 5



### enumerate

리스트, 튜플, 문자열, 딕셔너리 같이 시퀀스 개체의 인덱스와 요소를 리턴해줌.

변수 두 개를 넣어줘서 리턴해 줄 수 있음.

```python
a = [3,1,2,4,5]

for idx, v in enumerate(a):
    print(idx, v) # idx는 index v는 저장값
```



### min, max

자료구조 내에서 가장 작은 값, 큰 값을 리턴해 줌

```python
a = [3,7,1,5,2]

# min, max 함수 사용

print(min(a))
print(max(a))

# 리스트 내 총합
print(sum(a))
```

> ```
> 1
> 7
> 18
> ```



### list comprehension (리스트 내포)

리스트 내부에 for, if 문 등을 사용하여 리스트 생성 + 리스트 내에 요소 대입을 해줌

구조 : [식 for 변수 in 리스트(반복 가능한 객체 : range 등)]

```python
x = [x for x in range(10)]
print(x)
```

> ```
> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> ```



대괄호 대신에 소괄호로 만들면 튜플로 생성

```python
x = (x for x in range(10)) # <generator object <genexpr> at 0x000001B487EE66D0>
x = list((x for x in range(10))) # 제너레이터로 생성도 가능
x
```

> ```
> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> ```



if 사용 시

```python
[i for i in range(10) ]
```

> ```
> [0, 2, 4, 6, 8]
> ```



이중 for문 사용하여 리스트 내포로 구구단 만들기

```python
x = [i*j for i in range(2,10) for j in range(1,10)]
print(x, sep = " ")
```

> ```
> [2, 4, 6, 8, 10, 12, 14, 16, 18, 3, 6, 9, 12, 15, 18, 21, 24, 27, 4, 8, 12, 16, 20, 24, 28, 32, 36, 5, 10, 15, 20, 25, 30, 35, 40, 45, 6, 12, 18, 24, 30, 36, 42, 48, 54, 7, 14, 21, 28, 35, 42, 49, 56, 63, 8, 16, 24, 32, 40, 48, 56, 64, 72, 9, 18, 27, 36, 45, 54, 63, 72, 81]
> ```



리스트 내포 없이 구구단 구현

```python
gugudan = []

for i in range(2,10):
    for j in range(1,10):
        gugudan.append(i*j)
    print("[%s단]"%i)
    print(gugudan)
    gugudan.clear()
```

> ```
> [2단]
> [2, 4, 6, 8, 10, 12, 14, 16, 18]
> [3단]
> [3, 6, 9, 12, 15, 18, 21, 24, 27]
> [4단]
> [4, 8, 12, 16, 20, 24, 28, 32, 36]
> [5단]
> [5, 10, 15, 20, 25, 30, 35, 40, 45]
> [6단]
> [6, 12, 18, 24, 30, 36, 42, 48, 54]
> [7단]
> [7, 14, 21, 28, 35, 42, 49, 56, 63]
> [8단]
> [8, 16, 24, 32, 40, 48, 56, 64, 72]
> [9단]
> [9, 18, 27, 36, 45, 54, 63, 72, 81]
> ```



리스트 내포에서 else도 사용 가능하지만 **elif는 사용 불가하다.**

```python
# 0 ~ 9까지 수를 리스트에 저장하고자 하는데,
# 짝수는 even, 홀수는 odd 저장

x = ["even" if i % 2 == 0 else "odd" for i in range(10)]
print(x)

# 0->zero를 elif 없이 저장하기
y = ["zero" if i == 0 else "even" if i%2 == 0 else "odd" for i in range(10)]
print(y)
```

> ```
> ['even', 'odd', 'even', 'odd', 'even', 'odd', 'even', 'odd', 'even', 'odd']
> ['zero', 'odd', 'even', 'odd', 'even', 'odd', 'even', 'odd', 'even', 'odd']
> ```





## Day 6



### 파일 읽기 / 쓰기

기본 루틴 : 파일 열기(open) -> 읽기(read) / 쓰기(write) -> 파일 닫기(close)

```python
f = open("test.txt", "w") # 파일을 쓰기 위해 열겠다.
f.write("hello") # 파일에 문자열 저장
f.close() # 파일 닫기
```

```python
f = open("test.txt", "r") # 파일을 읽기 위해 열겠다.
s = f.read() # 파일에 문자열 열기
print(s)
f.close() # 파일 닫기
```

> hello



위에 예제를 다른 방식으로 쓸 수 있다.

```python
with open("test.txt", "r") as f:
    s = f.read()
    print(s) # close를 하지 않아도 파일을 닫아줘서 편하다.
```



### read( )

open함수 이후 as f 입력 후 f.read()를 하면 입력한 모든 내용이 출력된다. 이때 데이터 타입은 문자열로 출력된다.

```python
with open("practice.txt", "w",encoding="utf8") as f:
    for i in range(3):
        s = f.write("파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n")

with open("practice.txt","r", encoding = "utf8") as f:
    s2 = f.read()
print(type(s2))
print(s2)
```

> ```
> <class 'str'>
> 파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.
> 파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.
> 파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.
> ```



### readline( )

입력된 내용을 한 줄씩 출력한다. 타입은 str

```python
with open("practice.txt", "w",encoding="utf8") as f:
    for i in range(3):
        s = f.write("파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n")

with open("practice.txt","r", encoding = "utf8") as f:
    s2 = f.readline()
print(type(s2))
print(s2)
```

> ```
> <class 'str'>
> 파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.
> ```



### readlines( )

입력된 내용을 모두 출력한다. 이때 리스트로 문장들이 출력된다.

```python
with open("practice.txt", "w",encoding="utf8") as f:
    for i in range(3):
        s = f.write("파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n")

with open("practice.txt","r", encoding = "utf8") as f:
    s2 = f.readlines()
print(type(s2))
print(s2)
```

> ```
> <class 'list'>
> ['파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n', '파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n', '파파고(Papago)는 네이버가 개발한 인공지능 기반 번역기이다.\n']
> ```



### day7 연습문제 3번

문제 : text 저장 후 내용 변경하고 다시 불러오기

```python
with open("practice2.txt", "w") as f:
    f.write("Life is too short\nYou need Java")

# 파일 읽기
with open("practice2.txt", "r") as f:
    s = f.read()
    print("변경 전 내용입니다")
    print(s)
    print("="*20)

# 파일내용 변경

with open("practice2.txt", "w") as f:
    s = s.replace("Java", "Python")
    f.write(s)
    
# 파일내용 확인
with open("practice2.txt", "r") as f:
    s = f.read()
print("변경 후 내용입니다")
print(s)
```

solution :

1. text 파일에 내용 저장
2. 파일에 저장되어있는 내용 읽어서 변수에 문자열을 저장
3. 쓰기모드로 위에 저장되어있는 변수를 replace 함수를 통해 내용 변경
4. 다시 읽기모드로 변경이 잘 되었는지 확인!



### pickle

피클 모듈 : 객체를 파일로 저장

`객체란?` 클래스(like 붕어빵 틀)로부터 파생된 실체(인스턴스, like 붕어빵)

구조 : with open("파일명.p","wb"or"rb") as f: => w(쓰기), r(읽기)에 b를 붙여준다.

``` python
# 일련의 정보가 게임이 끝났을 때 저장되는 시나리오 가정

my_id = "kim"
lv = 50
ch = "human"
items = {"sword":1, "re" : 10}
```

```python
# 객체가 저장됨

with open("user1.p", "wb")as f: # write binary (2 진수로 저장)
    pickle.dump(my_id, f)
    pickle.dump(lv, f)
    pickle.dump(ch, f)
    pickle.dump(items, f)
```

```python
# 다시 접속 시 정보를 불러옴

with open("user1.p", "rb") as f:
    my_id = pickle.load(f)
    lv = pickle.load(f)
    ch = pickle.load(f)
    items = pickle.load(f)
    
    
print(my_id, lv, ch, items)
```

> ```
> kim 50 human {'sword': 1, 're': 10}
> ```





### 회문 작성법

- ```python
  w = input("입력")
  print(w==w[::-1]) # 결과값이 Boolean형으로 출력
  ```

  > True

- ```python
  w = "abcba"
  
  list(w) == list(reversed(w))
  ```

  > True

- ```python
  w == "".join(reversed(w))
  ```

  > True



### n-gram 

문자열에서 n개의 연속된 문자를 추출하는 것.

n=2 이면 2-gram, n=3 이면 3-gram 이렇게 부른다.



ex) 삼성동에 코로나가 퍼지고 있습니다.

```python
공백 단위로 구분했다면 => [삼성동에, 코로나가, 퍼지고, 있습니다]
단어 단위(2-gram)으로 추출 후 => [삼성동에, 코로나가], [코로나가, 퍼지고], [퍼지고, 있습니다]

문장을 단어 단위2-gram 으로 추출하면["삼성동에", "코로나가"], ["코로나가", "퍼지고"]

문장을 글자 단위2-gram 으로 추출하면 ["삼성", "성동", "동에", .... , "니다"]
```



```python
# 2-gram 단위로 문자 추출

Zzz = "hello"
# 2-gram => he, el, ll, lo

for i in range(len(Zzz)-1):
    print(Zzz[i]+Zzz[i+1], end = " ")
```

> ```
> he el ll lo 
> ```



```python
# 2-gram 단위로 단어 추출

Zzz2 = "this is python program"

lst = Zzz2.split(" ")
for i in range(len(lst)-1):
    print(lst[i:i+2])
```

> ```
> ['this', 'is']
> ['is', 'python']
> ['python', 'program']
> ```



이렇게 n-gram 을 구하면 이걸로 어떤 역활을 할 수 있을까?

.

.

.

언어 모델 : 단어(문자)의 순서에 확률을 적용한 모델

ex) 나는 아침에 줌에 접속하여 (   ) 인증을 하였다.

괄호안에 들어갈 말로 적절한것은 QR이라는 것을 나는 알 수 있었다.



이렇게 언어 모델을 만드는 유형은 통계적 방법과 신경망 방법이 있다.

우리가 위에서 했던 N-gram은 통계적 방법 중의 하나이다. (살짝 구식 + 그렇게 좋은 방법은 아니다..)



간단한 예를 들어보자

```python
전체 문장에서

    count(나는 오늘 학교에 갔다) = 100번
---------------------------------     = 3% = P(갔다 | 나는, 오늘, 학교에)
    count(나는 오늘 학교에) = 10000번
    
    count(나는 오늘 학교에 왔다) = 100번
---------------------------------     = 1% = P(왔다 | 나는, 오늘, 학교에)
    count(나는 오늘 학교에) = 10000번
    
    ....
    
# 이런식으로 가지고 있는 텍스트 데이터들을 계산해서 확률이 제일 높은 것을 구하는 것이 통계적 방법이다.
```



### n-gram 활용(문장 유사도 조사)

카피킬러(copy killer) : 논문 표절 등 조사

예를들어 의미는 다르지만 문자가 비슷한 두 문장이 있다.

```python
x = "머신러닝은 인공지능의 한 분류입니다"
y = "런닝머신은 운동 기구중의 하나입니다"
```



두 문장을 2-gram으로 글자를 분리한다.

```python
# 2-gram(bi-gram) 단위로 글자 분리

x => ["머신", "신러", ... "니다"] # 내가 작성한 숙제
y => ["런닝", "닝머", ... "니다"] # 다른 사람이 작성한 숙제

# 내가 작성한 숙제의 표절율?
```



여기서 유사도는 **중복되는 단어 개수 / x를 2글자 씩 분리한 리스트의 전체 길이**이다.

```python
x = "머신러닝은 인공지능의 한 분류입니다"
y = "런닝머신은 운동 기구중의 하나입니다"

x_s = x.replace(" ","") # 공백 제거
for i in range(len(x_s)-1):
    print(x_s[i],x_s[i+1], sep="")
    
y_s = y.repalce(" ", "")
for i in range(len(x_s)-1):
    print(y_s[i],y_s[i+1], se="")
```

> ```
> 머신
> 신러
> 러닝
> 닝은
> 은인
> 인공
> 공지
> 지능
> 능의
> 의한
> 한분
> 분류
> 류입
> 입니
> 니다
> 
> 
> 런닝
> 닝머
> 머신
> 신은
> 은운
> 운동
> 동기
> 기구
> 구중
> 중의
> 의하
> 하나
> 나입
> 입니
> 니다
> ```

이제 유사도를 구해보면

```python
cnt = 0 # 중복되는 개수 카운트

for i in x_s_list:
    for j in y_s_list:
        if i == j:
            cnt +=1
print(cnt)
print("유사도는 %s%%입니다."%(cnt/len(x_s_list)*100))
```

> ```
> 3
> 유사도는 20.0%입니다.
> ```



### *변수이름

```python
a = [1,2,10]
print(*a)
# a 안에 요소들이 전부 출력
# print(a) 와의 차이가 있음!!
print(a)
```

> 1 2 10
>
> [1,2,10]

## Day 7

### 함수란?

반복적인 코드를 함수로 정의함으로서 다양한 장점이 있음(실수 줄임, 코드 간결성, 반복 사용)

구조 :

함수 실행(호출) : 함수명( )

```python
def 함수명():
    수행할 코드 1
    수행할 코드 2
    ...
    수행할 코드 n
```



### global

전역변수 : 함수 밖에 있는 변수를 함수내에서도 사용하게 해줌

```python
x = 1

def test():
    global x # 함수 내부에서 함수 밖에 있는 변수 x를 사용하겠다!
    x += 10

test()
print(x)
```

> ```
> 11
> ```



## Day 8



### 람다함수

lambda  : 함수를 정의할 때 사용하는 예약어(def와 동일), 간단한 기능의 함수를 정의할 때 또는 def 를 사용할 수 없는 곳에 쓰임

def : 복잡한 기능을 갖는 함수를 정의할 때

```python
def sumAll(a,b):
    return a+b

# 위에 sumAll 함수를 lambda로 표현

sum_lambda = lambda a,b: a+b # 함수명 = lambda 매개변수 : 리턴 값
sum_lambda(3,5)
```

> 8



람다함수를 map함수의 인수로 전달하여 수행

```python
def add(a):
    return a+1
x = [1,2,3]

# [2,3,4]가 출력

x_add = []
[x_add.append(add(i)) for i in x]
x_add # [2,3,4]

print(list(map(add,x))) # add 함수와 map을 사용할 때
print(list(map(lambda x:x+1, x))) # lambda 함수 사용할 때
```

> ```
> [2, 3, 4]
> [2, 3, 4]
> ```



람다식에 if문을 쓰는 경우에는 콜론 기호를 사용하지 않는다.

조건식 => 식(참) if 조건식 else  식 (거짓)

```python
list(map(lambda x: str(x) if x%2 ==0 else x, x))
```

> ```
> [1, '2', 3, '4', 5]
> ```



조건식이 여러개일 경우

조건식 => 식1 if 조건식1 else 식2 if 조건식2 else 식3

```python
list(map(lambda x: str(x) if x==1 else float(x) if x==2 else x,x))
```

> ```
> ['1', 2.0, 3, 4, 5]
> ```



### divmod 

몫, 나머지를 구하는 함수

구조 : divmod(수, 나누는 수)

=> 결과값은 튜플로 리턴

```python
divmod(5,2)
```

> (2,1)



### enumerate

열거형 함수, for 문과 많이 쓰임

리스트(튜플, 문자열 같이 순서가 있는 자료구조)의 자료를 입력받아서 (index, 자료) 형식으로 리턴해줌

```python
a = ["a","b","c"]

for i in enumerate(a):
    print(i)
    
for i, data in enumerate(a):
    print(i, data)
```

> ```
> (0, 'a')
> (1, 'b')
> (2, 'c')
> 0 a
> 1 b
> 2 c
> ```



### eval

연산이 가능한 문자열을 전달받아 연산을 수행하고 결과를 리턴해준다.

```python
a = "1+2"
print(eval(a))
```

> 3



### filter

조건에 만족하는 자료들만 추출

filter(함수, 리스트(튜플, 문자열)) -> 함수에 정의한 조건을 만족하는 데이터들만 리턴해 줌

```python
def myFunc(data):
    return data > 3 and data < 7

data = [8,1,5,2,6]
print(list(filter(myFunc, data)))

print(list(filter(lambda x:3<x<7,data)))
```

> ```
> [5, 6]
> [5, 6]
> ```

myFunc 에서 3 < data < 7 에 해당하는 값만 True로 통과하고 filter 함수에서 True된 값을 리턴시켜줌



lambda 함수에 조건문을 넣었을 때 map과 다르게 filter는 if 문에 해당하는 조건문만 통과시켜줌

(당연한 얘기겠지만 if는 True고 else는 False니까!)

예를들면 map은 전부 리턴되서 나옴

```python
list(map(lambda x: x if 3<x<7 else 0, data))
```

> ```
> [0, 0, 5, 0, 6, 0]
> ```



filter는 else를 고려하지 않아도 된다.

```python
print(list(filter(lambda x: x if 3<x<7 else 0, data)))
print(list(filter(lambda x: 3<x<7, data)))
```

> ```
> [5, 6]
> [5, 6]
> ```



### pow

제곱을 해주는 함수

```python
print(pow(3,2)) # 3의 2제곱
```

> 9



### round

반올림 해주는 함수

```python
print(round(3.1)) # default 값은 0
print(round(3.141592,1))
print(round(3.141592,3))
```

> ```
> 3
> 3.1
> 3.142
> ```



### zip

같은 위치의 자료들을 묶는 함수

```python
print(list(zip((1,2),{3,4})))
print(list(zip("hi","hello"))) # 자리수가 같은 곳 까지만 묶어줌
print(list(zip([1,2],[3,4],[5,6,7])))
```

> ```
> [(1, 3), (2, 4)]
> [('h', 'h'), ('i', 'e')]
> [(1, 3, 5), (2, 4, 6)]
> ```





## Day 9



### 정규표현식

정규표현식은 문자열의 패턴에 대한 표현식을 작성한다.

- re.match("패턴", "문자열") : 문자열에 패턴이 있는지 확인

  ```python
  re.match("hi", "hi hello world") # "hi hello world"에 "hi"가 있는지 판단
  ```

  match 함수는 문자열의 최 좌측부터 시작하여 패턴이 있는지 확인.

  처음부터 패턴이 문자열에 없다면 종료.

  ```python
  re.match("hello", "hi hello world")
  # e부터 매치가 안되기 때문에 종료
  ```

  

  패턴이 문자열에 있다면 매치된 문자열이  Match 객체로 출력

  ```python
  re.match("hello", "hello world")
  ```

  > ```
  > <re.Match object; span=(0, 5), match='hello'>
  > ```



### 메타문자

정규표현식에서 식을 정의하는데 사용되는 특별한 의미의 문자(기호)

종류 : ( ),  [ ], { },   \, | ...

1. [ ] : 모든 문자가 대괄호 안에 올 수 있음

   ex) [abcde] : a,b,c,d,e 중에서 한 개의 문자와 매치

   ```python
   print(re.match("[ ]"," a"))
   print(re.match("[abcde]+","abcd")) # +는 한 문자 이상과 매치되는지 검사
   print(re.match("[abcde]+","xabcd"))
   print(re.match("[abcde]+","abfcd"))
   ```

   > ```
   > <re.Match object; span=(0, 1), match=' '>
   > <re.Match object; span=(0, 4), match='abcd'>
   > None
   > <re.Match object; span=(0, 2), match='ab'>
   > ```

2.  "-" : - 하이픈 기호로 범위를 지정해 줄 수 있다.

    ex) [a-z] : a ~ z 까지 범위 지정

    ```python
    print(re.match("[a-z]+","all")) # '-' 하이픈 기호로 범위를 지정해줄 수 있음
    print(re.match("[10832]+","120348"))
    print(re.match("[0-9]+","120348"))
    print(re.match("[A-Z]+","HELLO WORLD")) # 공백문자도 넣어주면 모두 표기됨
    print(re.match("[A-Za-z ]+","Hello World"))
    
    print(re.match("[가-힣ㄱ-ㅎ]+","ㅎㅎㅎㅋㅋ가다나가다라다")) # 한글 전체 문자 나타내기 # ㄱ-힣 으로 표기해도 가능
    ```

> ```
> <re.Match object; span=(0, 3), match='all'>
> <re.Match object; span=(0, 4), match='1203'>
> <re.Match object; span=(0, 6), match='120348'>
> <re.Match object; span=(0, 5), match='HELLO'>
> <re.Match object; span=(0, 11), match='Hello World'>
> 
> <re.Match object; span=(0, 12), match='ㅎㅎㅎㅋㅋ가다나가다라다'>
> ```

범위값 지정하는 방법으로는 다음과 같다.

cf. ^는 제외한 모든 문자를 의미한다.

```
[0-9] ==\d
[^0-9] == \D 숫자를 제외한 모든 문자
[0-9A-Za-z] == \w
[^0-9A-Za-z] == \W
[ \t\n\r] == \s
[^ \t\n\r] ==\S
```



