# 1. for문으로 다음과 같이 월 이름을 출력

month.name

for (i in month.name){
  a <- c("The month of",i)
  a <- paste(a, collapse = " ")
  print(a)
}


# 2. 짝수이면 TRUE, 홀수이면 FALSE를 출력하는 함수 작성.

test <- c(-5:5)

for (i in test){
  if (i%%2==0){
    print(TRUE)
  }
  else{
    print(FALSE)
  }
}


# 3. 짝수 개수를 세는 함수 작성.

# 3-1.
length(test[sapply(test, function(x) {x%%2==0})])

# 3-2.
countEven <- function(x){
  cnt <- 0
  for (i in x){
    if (i%%2==0){
      cnt <- cnt+1
    }
  }
  return (cnt)
}
  
countEven(test)


# 4. 주어진 숫자가 원주율보다 크면 TRUE, 아니면 FALSE를 출력하는 함수 작성.

myfunc <- function(x){
  print(x>pi)
}
myfunc(3)
myfunc(1:5)


# 5. 2~99까지 수에 대해
# - 3의 배수에 해당하는 수의 합계를 구하시오.
# - 3의 배수에 해당하는 수의 개수를 구하시오.

test <- c(2:99)

# 5-1.
sum(test[sapply(test, function(x) x%%3==0)])
# 5-2.
length(test[sapply(test, function(x) x%%3==0)])


# 6. 임의의 수 n을 전달받아, n!을 출력하는 함수를 완성하시오. (n>=2, 5!=5*4*3*2*1)

factorial <- function(n){
  f <- c(1:n)
  s <- 1
  for (i in f){
    s <- s*i
  }
  return (s)
}


# 7. 반복문을 이용하여 구구단을 출력하시오

gu <- c(1:9)
gu[-1]

for (i in gu[-1]){
  cat(i,"단",sapply(gu, function(x) x*i),"\n")
}


# 8. 반복문을 활용하여 출력하시오

for (i in 1:4){
  print(paste(c(rep(" ",4-i),rep("*",2*i-1),rep(" ",4-i)),collapse = ""))  
}

