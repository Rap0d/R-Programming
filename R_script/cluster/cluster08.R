library(cluster )

data <- read.csv('patient_info.csv', stringsAsFactors = F)
str(data)

hc <- hclust(dist(data), method = 'single')
plot(hc)

# k를 1부터 10까지 반복