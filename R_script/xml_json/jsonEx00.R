# install.packages('jsonlite')
library(jsonlite)

mJson <- 'R Basic Source/09.반정형/member.json'
mJson

# fromJSON 함수를 통해 JSON 파일 가져오기
mFrame <- fromJSON(mJson)
mFrame

summary(mFrame)
mode(mFrame)
class(mFrame)

# json 파일에서도 호출 가능 
mFrame$name

mFrame$name[2]

# 중첩된 데이터 정보는 dot(.)로 연결하여 컬럼 이름을 만들어준다.
write.csv(mFrame, 'before.csv')

tot_df <- data.frame()

for (idx in 1:nrow(mFrame)) {
  name <- mFrame$name[idx]
  occupation <- mFrame$occupation[idx]
  address <- mFrame$information$address[idx]
  height <- mFrame$information$info$height[idx]
  weight <- mFrame$information$info$weight[idx]
  blood <- mFrame$information$info$blood[idx]
  
  dFrame <- data.frame(name = name, occupation = occupation, address = address, height = height, weight = weight, blood = blood)
  tot_df <- rbind(tot_df, dFrame)
}
tot_df

write.csv(tot_df, 'after.csv')

chart1 <- unlist(tot_df$height)
barplot(chart1, ylim = c(0, 200))
