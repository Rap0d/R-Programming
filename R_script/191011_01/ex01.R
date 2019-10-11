setwd('../06.data processing/')

member <- read.csv('member.csv', header = T)
member

board <- read.csv('board.csv', header = T)
board

# col name 확인 
colnames(member)
colnames(board)

