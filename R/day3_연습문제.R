# iris
# 150건 데이터
# 1~100번까지 데이터 추출 ->   Petal.Length Petal.Width 열 저장
# -> 회귀모델 : 독립변수(Petal.Length), 종속변수(Petal.Width)
# -> 회귀모델의 기울기, 절편 구해지면
# 
# 101번~150번까지 데이터 추출 ->   Petal.Length Petal.Width 열 저장
# -> 이미 구한 회귀모델의 기울기, 절편을 이용하여 Petal.Length를
# 입력했을때 Petal.Width 예측하여 출력
# 
# cost도 함께 출력(예측값 - 실제값) 제곱의 평균

iris
iris_100 <- iris[1:100, 3:4]

x <- iris_100$Petal.Length
y <- iris_100$Petal.Width

slope <- cor(x,y)*(sd(y)/sd(x))
bias <- mean(y)-mean(x)

iris_150 <- iris[101:150, 3:4]

xHat <- iris_150$Petal.Length
yHat <- slope * xHat + bias
yHat
