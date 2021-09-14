myvector <- c(1:6,"a")
myvector

mylist <- list(1:6,"a")
mylist

형태소 -> 단어 -> 문장 -> 문단 -> 문서..

obj1 <- 1:4
obj2 <- 6:10

class(obj1)
obj3 <- list(obj1, obj2)
obj3

mylist <- list(obj1, obj2, obj3)
mylist

# [[]] 사용하여 리스트에 저장된 요소를 접근할 수 있다

# mylist[[1]]은 obj1을 접근
mylist[[1]]

mylist[[1]][3]

mylist[[3]][[2]]
mylist[[3]][2]


# mylist에서 [[3]][[1]]의 3을 출력

mylist[[3]][[1]][3]

# 벡터자료 접근 : [], 리스트 자료 접근 : [[]]

# unlist: 리스트 -> 벡터

myvector <- c(1:6,"a")
mylist <- list(1:6,"a")

myvector==mylist # 모두 FALSE

myvector==unlist(mylist) # 모두 TRUE

name1 <- "Donald"
myspace <- " "
name2 <- "Trump"
list(name1, myspace, name2)
unlist(list(name1,myspace,name2)) # 길이가 3인 벡터

# 고유명사 같은 경우 다른 일반 단어들과 구분해야함
# ex) "Donald_Trump" 이런식으로 바꿔줘야함

# 메타데이터(데이터의 데이터) : 데이터에 대한 설명명
# ex) 유튜브영상(데이터)에 달린 설명,제목.. => 메타데이터



name <- c("갑","을","병","정")
gender <- c(2,1,1,2)

mydata <- data.frame(name, gender)

attr(mydata$name, "var") <- "이름" # "var":메타데이터의 이름, "이름":메타데이터 내용
mydata$name # attr 확인


attr(mydata$gender, "var") <- "성별"
mydata$gender

myvalues <- gender
myvalues[1]

for (i in 1:length(mydata$gender)){
  myvalues[i] <- ifelse(gender[i]==1,"남성","여성")
}
myvalues

# 속성 값 저장
attr(mydata$gender, "value") <- myvalues
mydata$gender

# 속성 값 추출
attr(mydata$gender, "value")


#  =======================================================================================  #


축구 골 넣는 영상 검색
기존 검색 : 유튜브 검색어로 "골인" -> 검색 결과(영상 제목, 메타데이터)
미래 검색 : 유튜브 검색어로 "골인" -> 검색 결과(영상 이해 -> 메타데이터 생성)

mylist <- list(1:4, 6:10, list(1:4,6:10))
mylist

# lapply: 출력이 리스트로 리턴
lapply(mylist[[3]],mean)
lapply(mylist, mean)

# 두 개 이상 동시에 추출하고 싶을 때
mylist[c(1,2)]

# sapply: lapply 결과에 대해 unlist를 적용
lapply(mylist[c(1,2)], sum)
unlist(lapply(mylist[c(1,2)], sum))

sapply(mylist[c(1,2)], sum) # unlist(lapply)와 동일한 결과가 나옴



#  =======================================================================================  #


letters # a~z를 벡터로 리턴해줌
LETTERS # A~Z

tolower("ABcD") # 소문자로 변경
toupper("Hi") # 대문자로 변경

nchar("korea") # 단어를 구성하는 문자의 개수를 리턴
nchar("한국")

nchar("korea", type = "bytes")
nchar("한국", type = "bytes")

mysentence <- "Learning R is so interesting"

# 문장 -> 단어

# strsplit()
strsplit(mysentence, split = " ") # 분리된 값이 리스트로 리턴됨
unlist(strsplit(mysentence, split = " ")) # vector


mywords <- strsplit(mysentence, split = " ")
mywords[[1]]

strsplit(mywords[[1]][5], split="") # 문자단위로 분리


# mywords에 저장된 모든 단어들에 대해 문자로 분해하시오.

mywords

unlist(strsplit(mywords[[1]], split=""))


myletters <- list(rep(NA,5))
myletters
for (i in 1:length(mywords[[1]])){
  myletters[i] <- (strsplit(mywords[[1]][i], split=""))
}
myletters
myletters[[1]]

# paste: join같은 역할
paste(myletters[[1]],collapse = "") # collapse에서 준 문자를 사이사이에 넣어 연결해 줌

mywords2 <- list(rep(NA,5))
for (i in 1:length(myletters)){
  mywords2[i] <- paste(myletters[[i]], collapse = "")
}
mywords2

R_wiki <- "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."

R_wiki

# 문단 단위로 분리
rWikiPara <- strsplit(R_wiki, split = "\n") # list로 리턴

# 문장 단위로 분리
strsplit(rWikiPara, split = ".") # .은 \\를 붙여야 문자로 인식

strsplit(R_wiki, split = "\\.") # 전체 문장(R_wiki)을 문장 단위로 분리

rWikiSent <- strsplit(rWikiPara[[1]], split = "\\.") # 벡터의 요소들을 대상으로 문장 단위로 분리됨

# length(rWikiSent) 문단 2개 
# length(rWikiSent[[1]]) 첫 번째 문단에는 문장이 3개
length(rWikiSent[[2]]) # 두 번째 문단에는 문장이 4개


rWikiWord <- list(NA,NA)

for (i in 1:2){
  rWikiWord[[i]] <- print(strsplit(rWikiSent[[i]], split = " "))
}

rWikiWord[[1]][[2]][[4]] # 문단번호-문장번호-단어번호

mysentence <- "Learning R is so interesting"
# ing위치가 발견된 위치를 리턴

regexpr("ing",mysentence) # 정규표현식
# 6 => 시작위치


# 패턴과 매치된 문자열의 시작위치를 리턴
loc.begin <- as.vector(regexpr("ing",mysentence)) # 시작위치 리턴

loc.length <- attr(regexpr("ing",mysentence), "match.length")

# 매치된 문자열의 종료위치치
loc.end <- loc.begin+loc.length-1
loc.end

# 매치된 모든 결과를 리턴
gregexpr("ing",mysentence)

# length(gregexpr("ing",mysentence)[[1]])
class(gregexpr("ing",mysentence)[[1]])

loc.begin <- gregexpr("ing",mysentence)[[1]][1]

# class(as.vector(gregexpr("ing",mysentence)[[1]]))
# class(loc.begin)

mysentences <- unlist(rWikiSent)

regexpr("software",mysentences) # -1 은 해당 벡터에서 발견되지 않았다는 의미

mytemp <- regexpr("software",mysentences)
mytemp
my.begin <- as.vector(mytemp)
my.begin[my.begin==-1] <- NA
my.begin

# 문자열이 매치된 마지막 위치
my.end <- attr(mytemp, "match.length")+my.begin-1




mylocs <- matrix(NA, nrow = length(my.begin), ncol = 2)
mylocs

colnames(mylocs) <- c("begin","end") # 컬럼의 이름설정
# mylocs
# colnames(mylocs) # 이름확인

rownames(mylocs) <- paste("sentence", 1:length(my.begin), sep=".") # 행의 이름설정
# rownames(mylocs)
# mylocs

for (i in 1:length(my.begin)){
  mylocs[i,] <- cbind(my.begin[i],my.end[i])
}
mylocs

grep("software", mysentences) # 각각의 벡터 요소 중 매치된 벡터의 위치를 리턴

grepl("software", mysentences) # 매치된 요소를 boolean으로 리턴


# 문자열 치환
sub("ing", "ING", mysentence) # 처음 매치된것만 바꿔줌

# gsub에서 g는 글로벌로 all의 의미를 갖음
gsub("ing", "ING", mysentence) # 모든 매치된것을 바꿔줌

sent1 <- rWikiSent[[1]][1]
sent1

# 고유명사 전처리 방법
new.sent1 <- gsub("R Foundation for Statistical Computing",
                   "R_Foundation_for_Statistical_Computing", # "_"를 붙여서 한 단어로 만들어줌
                   sent1)
new.sent1

sum(table(strsplit(sent1, split = " ")))
sum(table(strsplit(new.sent1, split = " ")))


# 전치사 제거
drop.sent1 <- gsub("and |the |for ","",new.sent1) # |를 통해 패턴을 여러개로 할 수 있음
sum(table(strsplit(drop.sent1, split = " ")))


mypattern <- regexpr("ing", mysentence)
regmatches(mysentence, mypattern)

mypattern <- gregexpr("ing", mysentence)
regmatches(mysentence, mypattern)


mypattern <- regexpr("ing", mysentence)
regmatches(mysentence, mypattern, invert=TRUE) # invert : 매치가 안된것만 출력

gsub("ing","",mysentence)

mysentences
substr(mysentence, 1, 10) # 시작위치와 끝 위치 리턴


my2sentence <- c("Learning R is so interesting","He is a fascinating singer")
my2sentence

# ing로 끝나는 모든 단어를 검색

mypattern0 <- gregexpr("ing",my2sentence)
regmatches(my2sentence, mypattern0)


# help -> regex 검색
mypattern0 <- gregexpr("[[:alpha:]]+ing\\b",my2sentence) # \\b : 끝남을 나타냄
regmatches(my2sentence, mypattern0)


myexample <- "He (Obama) received the Nobel Prize"
mypattern1 <- gregexpr("\\([[:alpha:]]+\\)", myexample)
regmatches(myexample, mypattern1)


# 소문자로 통일

mysentences
mypattern <- gregexpr("[[:alpha:]]+ing\\b", mysentences)

table(unlist(regmatches(tolower(mysentences), mypattern)))


# 대소문자 추출

mypattern <- gregexpr("[[:upper:]]", mysentences)
table(unlist(regmatches(mysentences, mypattern)))

mypattern <- gregexpr("[[:lower:]]", mysentences)
table(unlist(regmatches(mysentences, mypattern)))

table(unlist(regmatches(mysentences, mypattern)))


# 가장 많이 쓰인 소문자는?
# 몇 가지 종류의 알파벳 소문자가 쓰였을까?
# 총 몇 개의 알파벳 소문자가 쓰였을까?

mypattern <- gregexpr("[[:lower:]]", mysentences)

# 가장 많이 쓰인 소문자는?
which.max(table(unlist(regmatches(mysentences, mypattern))))
# 몇 가지 종류의 알파벳 소문자가 쓰였을까?
length(table(unlist(regmatches(mysentences, mypattern))))
# 총 몇 개의 알파벳 소문자가 쓰였을까?
sum(table(unlist(regmatches(mysentences, mypattern))))


library(stringr)


R_wiki <- "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."


str_extract(R_wiki, "software environment") # 한개만 추출
str_extract_all(R_wiki, "software environment")
str_extract_all(R_wiki, "software environment", simplify = TRUE) # 행렬렬


# 첫글자가 대문자인 모든 단어들을 조사
myextract <- str_extract_all(R_wiki, "[[:upper:]]{1}+[[:alpha:]]{0,}")
table(myextract)

str_extract_all(R_wiki, "software environment")
str_match_all(R_wiki, "software environment")

str_extract_all(R_wiki, "[[:alpha:]]{1,}")
str_match_all(R_wiki, "[[:alpha:]]{1,} and [[:alpha:]]{1,}")

university_address <- c("연세대학교 주소는 서울시 서대문구 연세로 50번지다",
                        "서울대 주소: 서울시 관악구 관악로 1번지다",
                        "고려대는 서울시 성북구 안암로 145번지에 있다",
                        "카이스트 주소, 대전시 유성구 대학로 291번지",
                        "포항시 남구 청암로 77번지는 포항공과 대학교 주소임")

str_extract_all(university_address, "[[:alpha:]]{1,}시 [[:alpha:]]{1,}구 
                [[:alpha:]]{1,}로 [[:alnum:]]{1,}번지")


str_extract_all(university_address, "[[:alpha:]]{1,}시 [[:print:]]{1,}번지")

style_address <- "[[:alpha:]]{1,}시 [[:alpha:]]{1,}구 [[:alpha:]]{1,}로 [[:digit:]]{1,}번지"
str_match(university_address, style_address)

style_address <- "([[:alpha:]]{1,}시) ([[:alpha:]]{1,}구) ([[:alpha:]]{1,}로) ([[:digit:]]{1,}번지)"
str_match(university_address, style_address)
# -> 소괄호로 묶어서 매치를하면 행렬에서 각각의 소괄호마다 컬럼으로 생성


myaddress <- data.frame(str_match(university_address, style_address))
myaddress

# myaddress[,3]

names(myaddress) <- c("full_address","city","district","road","street")
myaddress

table(myaddress$city)

rWikiPara <- str_split(R_wiki, "\n")
rWikiPara

rWikiSent <- str_split(rWikiPara[[1]], "\\. ")
rWikiSent

my2Sentences <- unlist(rWikiSent)[c(4,7)]
my2Sentences

# 두 문장의 단어수를 각각 출력하시오

for (i in 1:2){
  print(length(str_split(my2Sentences, " ")[[i]]))
}





