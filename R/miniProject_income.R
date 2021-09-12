# spss - sav 파일

install.packages("foreign")
library(foreign)
library(readxl)
library(dplyr)
library(ggplot2)
library(rlang)

welfare <- read.spss("Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
class(welfare)

str(welfare) # 16664개의 데이터
welfare$h10_g10

welfare <- rename(welfare,
                  sex = h10_g3, # 성별
                  birth = h10_g4, # 태어난 연도
                  marriage = h10_g10, # 혼인 상태
                  religion = h10_g11, # 종교
                  income = p1002_8aq1, # 월급
                  code_job = h10_eco9, # 직종 코드
                  code_region = h10_reg7) # 지역 코드
                  # age = birth열 값을 연산

welfare$age <- 2016-welfare$birth
welfare$age


table(welfare$sex) # 1.남성 2.여성
table(welfare$birth)
welfare$marriage


welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean(income))

table(welfare$religion)

welfare$code_job

read_excel("Koweps_Codebook.xlsx")
jobName <- as.data.frame(read_excel("Koweps_Codebook.xlsx", sheet = 2))
jobName

sum(is.na(welfare$income)) # 12030건
sum(is.na(welfare$code_job)) # 9135건

# ============================================================================= #

# 성별에 따른 급여 차이 등 분석 & 시각화

welfare$sex <- ifelse(welfare$sex==2, "female", "male")
table(welfare$sex)
qplot(welfare$sex)


sum(is.na(welfare$income))

summary(welfare$income)
# 중위값보다 평균값이 더 높음.

qplot(welfare$income)+
  xlim(0,1500)
# 꼬리가 오른쪽으로 김 -> 왜도가 양수 값임을 알 수 있음

boxplot(welfare$income)
# 이상치의 범위가 매우 넓음을 알 수 있음.

income_by_sex <- welfare %>% 
                    filter(!is.na(income)) %>% 
                    group_by(sex) %>% 
                    summarise(meanIncome = mean(income))

income_by_sex

ggplot(data=income_by_sex,
      aes(x = sex, y = meanIncome)) + geom_col()

# 남성의 평균 월급이 여성의 평균 월급 대비 2배정도임을 알 수 있다.

# ============================================================================= #

# 나이에 따른 급여 차이 등 분석 $ 시각화(나이대 별 형성-평균 급여, 생활에 필요한 급여)

table(welfare$age)
summary(welfare$age)

qplot(welfare$age)

income_by_age <- welfare %>% 
                  filter(!is.na(income)) %>% 
                  group_by(age) %>% 
                  summarise(meanIncome = mean(income))
income_by_age

ggplot(data= income_by_age,
       aes(x = age, y = meanIncome)) + geom_col()

# 20살부터 수입이 있고 수입이 가장 많은 시기는 30대 후반부터 50대 후반까지이다.

welfare <- transform(welfare,
                     ageCut = cut(age, breaks=c(20,30,40,50,60,70,Inf),
                                  lowest=T, right=F,
                                  labels=c("20대", "30대", "40대", "50대", "60대", "70대 이상")
                                  )
                     )
table(welfare$ageCut)

income_by_ageCut <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageCut) %>% 
  summarise(meanIncome = mean(income))

ggplot(data = income_by_ageCut,
       aes(x=ageCut, y = meanIncome))+geom_col()
# 수입이 많은 나이대는 40대, 50대, 30대순으로 형성되어있다.


# 2015년 기준 중위소득 100%는 156만원이다. 
# 나이대별 기본중위소득을 충족/ 미충족 하는지 비율을 살펴보자

welfare$income_fill <- ifelse(welfare$income>156, "충족", "미충족")

table(welfare$income_fill)

ggplot(data = income_by_ageCut,
       aes(x=ageCut, y = meanIncome))+geom_col()

incomeFill <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageCut) %>% 
  count(income_fill)

ggplot(data=incomeFill,
       aes(x=ageCut,y=n,fill=income_fill))+ geom_col(position="dodge")

#  => 한창 일을 할 때인 20대 ~ 50대 중 중위소득을 미충족하는 비율이 가장 큰 나이대는 20대이다.

# 월급과 나이대 plot 시각화

attach(welfare)
plot(income~ageCut)


# ============================================================================= #


# 혼인 상태 분석(혼인 비율, 이혼율, ...), 혼인 상태와 급여와의 관계

table(welfare$marriage)


# 결혼 상태를 숫자에서 이름을 바꿔보자
welfare$marriage <- ifelse(welfare$marriage==0, "18세 미만",
                           ifelse(welfare$marriage==1, "기혼",
                                  ifelse(welfare$marriage==2, "사별",
                                         ifelse(welfare$marriage==3, "이혼",
                                                ifelse(welfare$marriage==4, "별거",
                                                       ifelse(welfare$marriage==5, "미혼", "기타")
                                                       )))))
welfare$marriage

qplot(welfare$marriage)
# 기혼자의 수가 전체의 절반을 차지한다.

income_by_marriage <- welfare %>% 
                      filter(!is.na(income)) %>% 
                      group_by(marriage) %>% 
                      summarise(meanIncome = mean(income))

ggplot(data=income_by_marriage,
       aes(x=marriage,y=meanIncome))+geom_col()

# 기혼자의 평균 월급이 가장 많다.


# ============================================================================= #


# 종교와 급여 관계,,, 종교와 이혼율 관계 분석

welfare$religion <- ifelse(welfare$religion=="1", "있음", "없음")


table(welfare$religion)
# 종교의 유무는 반반임을 확인
# 없는 사람이 좀 더 많음


# 연령별 종교 유무

age_religion <- welfare %>% 
                  group_by(ageCut) %>% 
                  count(religion)

ggplot(data = age_religion,
       aes(x=ageCut, y=n, fill=religion))+geom_col(position="dodge")

# => 연령대가 높아질수록 종교를 믿는 비율이 크다



income_by_religion <- welfare %>% 
                        filter(!is.na(income)) %>% 
                        group_by(religion) %>% 
                        summarise(meanIncome = mean(income))

ggplot(data = income_by_religion,
       aes(x=religion,y=meanIncome))+geom_col()

# 나이대별로 종교의 유무에 따른 평균 월급을 살펴보자. 

income_age_religion <- welfare %>% 
                        filter(!is.na(income)) %>% 
                        group_by(ageCut,religion) %>% 
                        summarise(meanIncome = mean(income))

ggplot(data=income_age_religion,
       aes(x=ageCut,y=meanIncome,fill=religion))+geom_col(position="dodge")

# 종교가 없는 사람들의 월급이 조금 더 높다.


# 종교와 이혼율 관계 분석

table(welfare$marriage)

qplot(welfare[welfare$marriage=="이혼",]$religion)

# => 이혼한 사람들의 종교 유무는 없는 사람이 좀 더 많다.




# ============================================================================= #


# 지역별 연령대 비율표

wc <- welfare$code_region
welfare$code_region <- ifelse(wc==1, "서울",
                              ifelse(wc==2,"수도권",
                                     ifelse(wc==3,"경남",
                                            ifelse(wc==4,"경북",
                                                   ifelse(wc==5,"충남",
                                                          ifelse(wc==6,"강원/충북","전라도/제주도"))))))

qplot(welfare$code_region)

# 10살 기준을 나눈 연령대는 지역별 연령대를 볼 때 너무 많이 나뉘어서
# 연령대를 3개의 그룹으로 나눠서 보자

class(welfare$age)

welfare$ageCut2 <- ifelse(welfare$age<20,"미성년자",
                          ifelse(welfare$age<40, "청년",
                                 ifelse(welfare$age<60, "장년", "노년")))

table(welfare$ageCut2)


# 지역별 연령대 인구 수 시각화

ageCut_by_region <- welfare %>% 
  group_by(code_region, ageCut2) %>% 
  summarise(n=n()) %>%  
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,2))

ggplot(data = ageCut_by_region,
       aes(x=code_region, y=n, fill=ageCut2))+geom_col()


# 지역별 연령대 비율 시각화

ageCut_by_region <- welfare %>% 
                      group_by(code_region, ageCut2) %>% 
                      summarise(n=n()) %>%  
                      mutate(tot_group = sum(n)) %>% 
                      mutate(pct = round(n/tot_group*100,2))


ageCut_by_region


ggplot(data = ageCut_by_region,
       aes(x=code_region, y=pct, fill=ageCut2))+
  geom_col()+
  coord_flip()


# => 비수도권일수록 노년의 비율이 커지는걸 볼 수 있다.


# 지역별 월급

income_by_region <- welfare %>% 
                      filter(!is.na(income)) %>% 
                      group_by(code_region) %>% 
                      summarise(mean(income))

income_by_region

ggplot(data=income_by_region,
       aes(x=code_region, y=`mean(income)`))+geom_col()

# => 서울의 월급이 가장 높을줄 알았는데 의외로 충남의 월급이 가장 높았다..



# ============================================================================= #

# 직종코드 기반 급여를 많이 받거나 적게 받는 직종 30개씩 검색


sum(is.na(welfare$code_job)) # 결측치 9135개

table(welfare$code_job)

income_by_job <- welfare %>% 
                    filter(!is.na(income)) %>% 
                    group_by(code_job) %>% 
                    summarise(meanIncome = mean(income)) %>% 
                    arrange(desc(meanIncome)) %>% 
                    head(30)
job_top30 <- as.data.frame(income_by_job)
job_top30

income_by_job2 <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(code_job) %>% 
  summarise(meanIncome = mean(income)) %>% 
  arrange((meanIncome)) %>% 
  head(30)

job_bot30 <- as.data.frame(income_by_job2)
job_bot30


jobName
jobTop30 <- as.list(job_top30[1])
jobTop30
class(jobTop30)

jobBot30 <- as.list(job_bot30[1])
jobBot30


# 월급이 많은 상위 30개의 직업 이름

for (i in jobTop30$code_job){
  print(jobName[jobName["code_job"]==i,]$job)
  # print(i)
  
}


for (i in jobBot30$code_job){
  print(jobName[jobName["code_job"]==i,]$job)
  # print(i)
  
}



# ============================================================================= #


# 직종코드는 있지만, 급여가 확인되지 않은 3000명 정도 NA가 존재
# 급여가 NA인 사람의 직종코드를 참조하여, 동일한 직종코드의 해당되는
# 다른 사람들의 데이터를 찾아서 급여를 유추하여 결측치 대체

welfare <- welfare %>% 
            mutate(index = rownames(welfare))

# 직종코드 o / 급여 NA인 직종코드

list_a <- welfare[is.na(welfare$income)&!is.na(welfare$code_job),][c("code_job")]
list_a

list_a[,"income"] <- c(NA)
list_a

# 직종코드 중복값 제외
unique_a <- unique(list_a$code_job)
unique_a
length(unique_a) # 107개

# 모든 직업들의 평균 월급을 저장

income_by_alljob <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(code_job) %>% 
  summarise(meanIncome = mean(income))

income_by_alljob

# 직업코드에 맞는 평균 월급을 저장

for (i in unique_a){
  if (i %in% income_by_alljob$code_job){
    list_a[list_a$code_job==i,]$income=income_by_alljob[income_by_alljob$code_job==i,]$meanIncome
    print(i)
  }
}

list_a[is.na(list_a$income),]
# -> 직업코드가 630, 812, 819인 직업들의 income이 없음

welfare %>% 
  filter(!is.na(income)&code_job==819) %>% 
  summarise(mean(income))

# 630, 812, 819번의 직업코드들은 income데이터가 아예없어서 대체 불가능!!!


# welfare 데이터프레임에 630, 812, 819 코드를 제외한 값을 넣어주자

for (i in c(1:nrow(list_a))){
  welfare[row.names(list_a[i,]),]$income <- list_a[i,2]
}


# ========================연습용==============================================#





for (i in unique_a){
  if (i %in% income_by_alljob$code_job){
    list_a[df_a$code_job==i,]$income=income_by_alljob[income_by_alljob$code_job==i,]$meanIncome
    print(i)
  }
}


list_a[is.na(list_a$income),]
# -> 직업코드가 630, 812, 819인 직업들의 income이 없음

df_a[is.na(df_a$income),]
# -> 직업코드가 630, 812, 819인 직업들의 income이 없음

welfare %>% 
  filter(!is.na(income)&code_job==819) %>% 
  summarise(mean(income))
  
# 630, 812, 819번의 직업코드들은 income데이터가 아예없어서 대체 불가능!!!


# welfare 데이터프레임에 630, 812, 819 코드를 제외한 값을 넣어주자

class(welfare)


ifelse(!is.na(welfare[welfare$code_job==441,]$income),
       welfare[welfare$code_job==441,]$income,
       mean(welfare[welfare$code_job==441,]$income, na.rm=T))



# for (i in unique_a){
#   if (i %in% income_by_alljob$code_job){
#     # welfare[welfare$code_job==i,]$income=income_by_alljob[income_by_alljob$code_job==i,]$meanIncome
#     # print(i)
#     
#     welfare[welfare$code_job==i,]$income <- ifelse(!is.na(welfare[welfare$code_job==i,]$income),
#                          welfare[welfare$code_job==i,]$income,
#                          income_by_alljob[income_by_alljob$code_job==i,]$meanIncome)
#   }
# }

welfare$income

welfare[welfare$code_job==261,]$income=income_by_alljob[income_by_alljob$code_job==261,]$meanIncome

filter(welfare, code_job==261)$income


income_by_alljob[income_by_alljob$code_job==261,]$meanIncome


welfare[welfare$code_job==261,]$income <- 341








for (i in unique_a){
  # print(i)
  a <- income_by_alljob[income_by_alljob$code_job==i,]$meanIncome # 조건에 맞는 데이터를 a로 저장
  a_income <- c(a_income,a)
  print(a)
}



a_income <- c() # list_a의 월급을 저장할 벡터 생성
for (i in unique_a){
  # print(i)
  a <- income_by_alljob[income_by_alljob$code_job==i,]$meanIncome # 조건에 맞는 데이터를 a로 저장
  a_income <- c(a_income,a)
  print(a)
}

a_income
length(a_income) # 104개



# 직업코드의 개수는 107개였는데 저장된 월급벡터에는 104개의 데이터가 들어가있음
# => 3개의 데이터에서 NA값이 있는걸 확인할 수 있음.

ans <- c()
ans <- welfare[!is.na(welfare$code_job)&is.na(welfare$income),][c("code_job","index")]
ans

ans <- ans %>% 
  mutate(income=NA)

ans
class(ans)

welfare[welfare$code_job==441,]$income


ans[ans$code_job==441,]$income

welfare %>% 
  filter(code_job==441) %>% 
  filter(is.na(income))


ifelse(!is.na(welfare[welfare$code_job==441,]$income),
                        welfare[welfare$code_job==441,]$income,
                        mean(welfare[welfare$code_job==441,]$income, na.rm=T))

!is.na(welfare[welfare$code_job==441]$income)
welfare[welfare$code_job==441]$income
