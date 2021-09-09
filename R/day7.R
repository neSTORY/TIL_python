train <- read.csv("train.csv")
test <- read.csv("test.csv")

str(train)

train <- subset(train, select=-c(Name,Ticket))
test <- subset(test, select=-c(Name,Ticket))


train$Sex <- ifelse(train$Sex=="male",1,0)
test$Sex <- ifelse(test$Sex=="male",1,0)

table(train$Sex)
table(test$Sex)


head(train,3)

table(train$Embarked)

train[train$Embarked=="",]

# 승선항구별 Fare의 평균

tapply(train$Fare, train$Embarked, mean)
aggregate(data=train, Fare~Embarked, mean)

library(dplyr)

train %>% 
  group_by(Embarked) %>% 
  summarise(fare_mean = mean(Fare))

# train %>%
#   group_by(Embarked) %>% 
#   select(Fare) %>% 
#   summarise(fare_mean=mean(Fare))

# C의 평균 값이 제일 높으므로 ""값을 C로 변경

train[train$Embarked == "",]$Embarked<-"C"
table(train$Embarked)
str(train)

# C:0, Q:1, S:2 로 변경하여 저장

train$Embarked <- ifelse(train$Embarked=="C",0,
                         ifelse(train$Embarked=="Q",1,2))

table(train$Embarked)


# Age열 처리

sum(is.na(train$Age))

train_age <- na.omit(train$Age)
train_age_avg <- mean(train_age)

train[is.na(train$Age),]$Age <- train_age_avg

sum(is.na(train$Age))
sum(is.na(test$Age))

test_age <- na.omit(test$Age)
test_age_avg <- mean(test_age)

test[is.na(test$Age),]$Age <- test_age_avg
sum(is.na(test$Age))

# fare열 처리

sum(is.na(train$Fare))
sum(is.na(test$Fare))

test[is.na(test$Fare),]$Fare <- mean(test$Fare,na.rm = T)
sum(is.na(test$Fare))

head(train,3)
head(test,3)

# Age열 구분

# 18세 미만 -> 1
# 18세 이상 -> 0

train$Age <- ifelse(train$Age>=18,0,1)

# 정규화 함수 생성

normalize <- function(x){
  num <- x-min(x)
  denom <- max(x)-min(x)
  return (num/denom)
}

train$Pclass <- normalize(train$Pclass)
test$Pclass <- normalize(test$Pclass)

train$Fare <- normalize(train$Fare)
test$Fare <- normalize(test$Fare)

head(train,3)

survived <- train$Survived
passengers <- test$PassengerId

head(train)

train <- train[,-c(1,2,6,7,9)]
head(train)

head(test)
test <- test[,-c(1,5,6,8)]
head(test)

library(class)

res <- knn(train, test, survived, k=25)
res

submission <- data.frame(passengerId=passengers, Survived=res)
submission

write.csv(submission,"submission.csv",row.names = FALSE)
