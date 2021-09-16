library(class)
library(gmodels)

str(iris)
table(iris[5])

# iris species 열은 범주형(factor)이므로 안 바꾸고 진행

# 정규화 함수 생성
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# 함수 실행되는지 테스트
normalize(c(1,2,3,4,5))
normalize(c(100,200,300,400,500))

# -> 함수 정상적으로 실행됨을 확인

# iris 데이터셋의 1~4번 컬럼을 정규화 진행
iris_n <- normalize(iris[1:4])
summary(iris_n)
# -> max:1, min:0 정규화 잘 됨을 확인

# train/test 데이터 나누기
# iris의 데이터는 150개이므로7:3으로 나누면 105,45개로 나눌 수 있음

set.seed(1234)

num <- sample(1:nrow(iris_n), size = nrow(iris_n)*0.7)
num
iris_train <- iris_n[num,]
iris_test <- iris_n[-num,]

iris_train_label <- iris[num,5]
iris_test_label <- iris[-num,5]


nrow(iris_train)
nrow(iris_test_label)

# k=3으로 설정
pred <- knn(train=iris_train, test=iris_test,
            cl=iris_train_label, k=3)

pred
iris_test_label

CrossTable(x=iris_test_label, y=pred)

# 45개중 41개 정답, 정답률 91.1%

# k=4으로 설정
pred <- knn(train=iris_train, test=iris_test,
            cl=iris_train_label, k=4)

pred
iris_test_label

CrossTable(x=iris_test_label, y=pred)

# 45개중 44개 정답, 정답률 97.8%

