# 1.

score <- c(80, 60, 70, 50, 90)
score

# 2.
mean(score)

# 3.

test_mean <- mean(score)
test_mean

# 4.

library(ggplot2)

# 4-1. midwest를 dataframe으로 불러오기
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
dim(midwest) # 437행 28컬럼
str(midwest)
names(midwest)
view(midwest) # ctrl + dataframe변수 클릭해도 view기능 사용 가능


# 4-2.
midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)


# 4-3.
#  total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들고,
# 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요.
midwest$totalPerAsian <- asian/total
midwest$totalPerAsian
hist(midwest$totalPerAsian)

# 4-4.
midwest$asianPerc <- ifelse(asian > mean(asian), "large","small")
midwest$asianPerc

# 4-5.
table(midwest$asianPerc)
qplot(midwest$asianPerc)
