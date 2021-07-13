# Day 1

### 연산

나누기 

```python
print(4/2) # 나누기 연산자.
print(4//2) # 몫 구하기
print(5%3) # 나머지 구하기
print(div(5,3)) # 몫과 나머지 구하기 튜플로 출력됨
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

