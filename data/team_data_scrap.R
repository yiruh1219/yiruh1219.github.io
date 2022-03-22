#install packages
install.packages("RSelenium")
install.packages("devtools")
library(devtools)
install_github("yikeshu0611/rs.driver")
library(tidyverse)

#scrap data
library(RS.Driver)
RS.OpenChrome(4444)
RS.open_Url("https://lpl.qq.com/esnew/data/rank.shtml?iGameId=148&sGameType=7,8")

#队名
team_name <- RS.get_Text('//*[@id="teamRank"]//td[2]')

#出场次数
appearance <- RS.get_Text('//*[@id="teamRank"]//td[3]/b') %>% 
  as.numeric()

win_loss <- RS.get_Text('//*[@id="teamRank"]//td[4]/b') %>%
  strsplit(split = '/')

#胜场
win <- 0
for(i in 1:length(win_loss)) {
  win[i] <- win_loss[[i]][1]
} 
win <- as.numeric(win)

#败场
loss <- 0
for(i in 1:length(win_loss)) {
  loss[i] <- win_loss[[i]][2]
} 
loss <- as.numeric(loss)

#胜率
rate <- RS.get_Text('//*[@id="teamRank"]//td[5]/b') %>%
  str_remove('%') %>% 
  as.numeric()

kill <- RS.get_Text('//*[@id="teamRank"]//td[6]/b') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#总击杀
total_kill <- 0
for (i in 1:length(kill)) {
  total_kill[i] <- kill[[i]][1]
}
total_kill <- as.numeric(total_kill)

#场均击杀
average_kill <- 0
for (i in 1:length(kill)) {
  average_kill[i] <- kill[[i]][2]
}
average_kill <- as.numeric(average_kill)

death <- RS.get_Text('//*[@id="teamRank"]//td[7]/b') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#总死亡
total_death <- 0
for (i in 1:length(death)) {
  total_death[i] <- death[[i]][1]
}
total_death <- as.numeric(total_death)

#场均死亡
average_death <- 0
for (i in 1:length(death)) {
  average_death[i] <- death[[i]][2]
}
average_death <- as.numeric(average_death)

#场均插眼
average_ward <- RS.get_Text('//*[@id="teamRank"]//td[8]/b') %>% 
  as.numeric()

#场均排眼
average_wardkill <- RS.get_Text('//*[@id="teamRank"]//td[9]/b') %>% 
  as.numeric()

#场均金钱
average_money <- RS.get_Text('//*[@id="teamRank"]//td[10]') %>% 
  as.numeric()

#场均大龙
average_baron <- RS.get_Text('//*[@id="teamRank"]//td[11]/b') %>% 
  as.numeric()

#场均小龙
average_dragon <- RS.get_Text('//*[@id="teamRank"]//td[12]') %>% 
  as.numeric()

team_data <- data.frame(team_name,
                        appearance,
                        win,
                        loss,
                        rate,
                        total_kill,
                        average_kill,
                        total_death,
                        average_death,
                        average_ward,
                        average_wardkill,
                        average_money,
                        average_baron,
                        average_dragon)

write.csv(team_data, file = "team_data.csv")