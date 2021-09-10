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

welfare %>% 
  mutate(welfare$age)

welfare %>% 
  group_by(code_region, ageCut) %>% 
  count(ageCut)


























