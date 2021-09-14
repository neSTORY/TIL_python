library(stringr)

mytext <- c("software environment","software  environment","software\tenvironment")
mytext

a <- str_split(mytext, " ")

# 각 벡터의 길이(단어 개수)
sapply(str_split(mytext, " "), length)

# 각 벡터의 문자의 개수
sapply(str_split(mytext, " "), str_length)

mytext.nowhitespace <- str_replace_all(mytext, "[[:space:]]{1,}", " ")


sapply(str_split(mytext.nowhitespace, " "), length)
sapply(str_split(mytext.nowhitespace, " "), str_length)


# 대소문자 통일
mytext <- "The 45th President of the United States, Donald Trump, states that he knows how to play trump with the former president"
myword <- unlist(str_extract_all(mytext, boundary("word")))
table(myword)

table(tolower(myword))

myword <- str_replace(myword, "Trump", "Trump_unique")
myword <- str_replace(myword, "States", "States_unique")

mytext <- c("He is one of statisticians agreeing that R is the No. 1 statistical software.","He is one of statisticians agreeing that R is the No. one statistical software.")
mytext

str_split(mytext, " ")

# 삭제 조건
# 숫자가 최소 1회 이상 연달아 등장 & 그 다음에는 공란이 1회 이상 등장
mytext2 <- str_split(str_replace_all(mytext, "[[:digit:]]{1,}[[:space:]]{1,}", ""), " ")
mytext2

str_c(mytext2[[1]], collapse = " ")

mytext <- "Baek et al. (2014) argued that the state of default-setting is critical for people to protect their own personal privacy on the Internet."
mytext

str_split(mytext, " ")

mytext <- c("She is an actor","She is the actor")
mytext

# 불용어(stopword): a, an, the, ...
# 코퍼스(말뭉치, corpus)에서 불용어 제거

mystopwords <- "a|an|the"
str_remove_all(mytext, mystopwords)

# tm 패키지
# -> text mining(텍스트 마이닝)을 위한 패키지

install.packages("tm")
library(tm)

stopwords("en") # 174개의 단어
stopwords("SMART") # 긴 불용어

# 영어와 한국어 차이
# 영어- 3인칭 주어 -> 동사 형태? 시제, 명사(단수/복수)
# 한국어- "가다" -> "가니", "간", "가고", ...

# 어근 동일(stemming)화 작업 : 파생된 단어를 동일하게 해주는 작업

# is, was, are, am, were => be

mytext

mystemmer.func <- function(mytextobj){
  mytext <- str_replace_all(mytextobj, "(i|I)s |was |are |am |were", "be ")
  mytext
}

mystemmer.func(mytext)

mytext <- c("I am a boy. You are a boy. The person might be a boy. Is Jane a boy?")
mystemmer.func(mytext)

mytext <- "The United States comprises fifty states. In the United States, each state has its own laws. However, federal law overrides state law in the United States."
mytext

myword <- str_extract_all(mytext, boundary("word"))
table(myword)

mytext.2gram <- str_replace_all(mytext, "United States", "United_States")
myword2 <- str_extract_all(mytext.2gram, boundary("word"))
table(myword2)
length(table(myword2))
sum(table(myword2))

mytext.3gram <- str_replace_all(mytext, "(t|T)he United States", "The_United_States")
myword3 <- str_extract_all(mytext.3gram, boundary("word"))
table(myword3)
length(table(myword3))
sum(table(myword3))

my.text.location <- "c:/rwork/papers/papers"
mypaper <- VCorpus(DirSource(my.text.location))
mypaper # ??분야 논문 코퍼스

# VCorpus: 코퍼스 생성 함수
# DirSource: 텍스트 데이터 저장 폴더 지정

# 도메인(domain)? (여기서는 데이터 분석) 분야 
# 코퍼스? (도메인에 관련된)단어 집합 사전

# ex) (법률) 챗봇은 법률 도메인에 관련된 내용만 대답이 가능
# 법률코퍼스에 수록된 단어의 예: 벌금, 구속, 수배, 범죄, ...

# ex) (의료) 챗봇

summary(mypaper)

# mypaper 말뭉치는 리스트 형식
mypaper[[2]]

mypaper[[3]]$content
mypaper[[3]]$meta

# meta 데이터 변경
meta(mypaper[[2]], tag="author") <- "kim"
mypaper[[2]]$meta

myfunc <- function(x){
  str_extract_all(x$content,"[[:alnum:]]{1,}[[:punct:]]{1}[[:alnum:]]{1,}")
}

mypuncts <- lapply(mypaper, myfunc)
table(unlist(mypuncts))

# 수치가 포함된 자료 추출

myfunc <- function(x){
  str_extract_all(x$content,"[[:alpha:]]?[[:digit:]]{1,}[[:alpha:]]?")
}
mypuncts <- lapply(mypaper, myfunc)
table(unlist(mypuncts))


# tm_map(코퍼스, 처리작업) 함수

res <- tm_map(mypaper, content_transformer(lower))

res[[2]]$content
mypaper[[2]]$content

# 숫자 제거
mycorpus <- tm_map(mypaper, removeNumbers)
mycorpus[[2]]$content

# 공백 2개 이상 -> 공백 1개
mycorpus <- tm_map(mycorpus, stripWhitespace)
mycorpus[[2]]$content

#특수문자 등 제거
mycorpus <- tm_map(mycorpus, removePunctuation)
mycorpus[[2]]$content

# 소문자로 변환
mycorpus <- tm_map(mycorpus, content_transformer(tolower))
mycorpus[[2]]$content

# 불용어 제거(mycorpus에서 stopwords("SMART")) 모두 제거
mycorpus <- tm_map(mycorpus, removeWords, words=stopwords("SMART"))
mycorpus



sms_raw <- read.csv("sms_spam_ansi.txt", sep=",")
str(sms_raw)

sms_raw$type <- factor(sms_raw$type)
table(sms_raw$type)

# 코퍼스 생성 -> 전처리 -> 스팸메일 분류기 제작(베이지안 필터기)

smscorpus <- VCorpus(VectorSource(sms_raw$text))
smscorpus

smscorpus[[1]]$content

print(smscorpus)
inspect(smscorpus)
# 내용을 확인하려면 -> smscorpus[[1]]$content
inspect(smscorpus[1:10])

as.character(smscorpus[[1]]) # 내용확인2
lapply(smscorpus[1:10], as.character) # 내용확인3

# 전처리
smscorpus_clean <- tm_map(smscorpus, content_transformer(tolower))
smscorpus_clean
lapply(smscorpus_clean[1:10], as.character)

# 숫자제거
smscorpus_clean <- tm_map(smscorpus_clean, removeNumbers)

# 불용어제거
smscorpus_clean <- tm_map(smscorpus_clean, removeWords, stopwords())

# 특수문자제거
smscorpus_clean <- tm_map(smscorpus_clean, removePunctuation)


install.packages("SnowballC")
library(SnowballC)

wordStem(c("learn","learned","learning","learns"))
t <- c("learn","learned","learning","learns")
stemDocument(t)

smscorpus_clean <- tm_map(smscorpus_clean, stemDocument)
smscorpus_clean <- tm_map(smscorpus_clean, stripWhitespace)

lapply(smscorpus_clean[1:3], as.character)
lapply(smscorpus[1:3], as.character)

# 문서-단어 행렬
# 문서(5559)*단어(6557) 행렬
# 5559개의 문서가 있는 코퍼스에서 중복을 제외한 유일핞 단어의 개수는 6557개이다

#             단어1, 단어2, ... 단어n, 단어n+1, ... Hope ...
# 문서1         0     0           1       1           1
# ...
# 문서5559

smsdtm <- DocumentTermMatrix(smscorpus_clean)
smsdtm
# Non-/sparse entries : 42136/35408227
# => 값이 0이 아닌 행렬/0인 행렬


smsdtm_train <- smsdtm[1:4169,]
smsdtm_test <- smsdtm[4170:5559,]

smsdtm_train
smsdtm_test

sms_train_labels <- sms_raw[1:4169,]$type
sms_test_labels <- sms_raw[4170:5559,]$type

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

install.packages("wordcloud")
library(wordcloud)
wordcloud(smscorpus_clean, min.freq = 30)
# 어떤 단어가 많이 등장?

# sms_raw에서 spam 메일만 출력
sms_raw[sms_raw$type=="spam",]

spam <- subset(sms_raw, type="spam")
ham <- subset(sms_raw, type="ham")


wordcloud(spam$text, max.words = 40)
wordcloud(ham$text, max.words = 40)


smsdtm_freq_train <- removeSparseTerms(smsdtm_train,0.999)
# Sparsity 값이 0.999보다 크면 해당 열(단어)은 삭제
smsdtm_freq_train

smsfreqwords <- findFreqTerms(smsdtm_train,5) # 최소 5개 이상의 문서에서 등장한 단어들

smsdtm_freq_train <- smsdtm_train[,smsfreqwords]
smsdtm_freq_test <- smsdtm_test[,smsfreqwords]

# inspect(smsdtm_freq_train)

converts_counts <- function(x){
  ifelse(x>0, "Yes","No")
}

sms_train <- apply(smsdtm_freq_train, 2, converts_counts)
sms_test <- apply(smsdtm_freq_test, 2, converts_counts)

str(sms_train)
str(sms_test)

install.packages("e1071")
library(e1071)

sms_classifier <-  naiveBayes(sms_train,sms_train_labels, laplace = 1)
sms_test_pred <- predict(sms_classifier, sms_test)
sms_test_pred

library(gmodels)
CrossTable(sms_test_pred, sms_test_labels)

# 라플라스사용o 오답 34개
# 라플라스사용x 오답 36개


















