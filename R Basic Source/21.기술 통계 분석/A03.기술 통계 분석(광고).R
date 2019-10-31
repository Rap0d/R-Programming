mycf <- read.csv("mycf.csv", header=T)

##################################################
# 기본 통계량 조회
##################################################
head(mycf)
tail(mycf)
View(mycf)
str(mycf)
summary(mycf)

##################################################
# 광고 집단 유형에 대한 기술 통계 분석
##################################################
mycf$group
mycf$group2 <- factor(mycf$group,
			levels=c(1, 2),
			labels=c("연예인 CF", "일반인 CF"))

cf02 <- table(mycf$group2)
cf02 
prop.table( cf02 )

plot(mycf$group2, xlab="집단 유형", ylab="샘플수", 
	col=rainbow(2),
	main="집단 유형별 샘플수", ylim=c(0, 1700))
# 파일 이름 : 집단 유형별 샘플수.png

##################################################
# 광고의 관심 유무에 따른 기술 통계 분석
##################################################
mycf$interest 
mycf$interest2 <- factor(mycf$interest, 
			levels=c(1, 0),
			labels=c("관심있음", "관심없음"))

mycf$interest2
myint02 <- table(mycf$interest2)
prop.table( myint02 )

plot(mycf$interest2, xlab="광고 관심", 
	col=rainbow(2),
	main="광고 관심 유무 사용자수", ylim=c(0, 2500)) 
# 파일 이름 : 광고 관심 유무 사용자수.png
##################################################
table(mycf$gender)

mycf$gender2[mycf$gender == 'M'] <- '남자'
mycf$gender2[mycf$gender == 'F'] <- '여자'

mycf$age2[mycf$age <= 40] <- '청년층'
mycf$age2[mycf$age > 40] <- '중년층'

age02 <- table(mycf$age2)
age02
prop.table( age02 )
##################################################