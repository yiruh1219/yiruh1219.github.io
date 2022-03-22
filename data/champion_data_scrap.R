library(tidyverse)
library(RS.Driver)
RS.OpenChrome(4444)
RS.open_Url("https://lpl.qq.com/esnew/data/rank.shtml?iGameId=148&sGameType=7,8")


#英雄名
champion_name <- RS.get_Text('//*[@id="heroRank"]//td[2]')

#英雄出场次数
appearance_c <- RS.get_Text('//*[@id="heroRank"]//td[3]/b') %>% 
  as.numeric()

#pick
pick <- RS.get_Text('//*[@id="heroRank"]//td[4]/b') %>% 
  str_remove('%') %>% 
  as.numeric()

#ban
ban <- RS.get_Text('//*[@id="heroRank"]//td[5]/b') %>% 
  str_remove('%') %>% 
  as.numeric()

#英雄胜率
rate_c <- RS.get_Text('//*[@id="heroRank"]//td[6]/b') %>% 
  str_remove('%') %>% 
  as.numeric()

kill_c <- RS.get_Text('//*[@id="heroRank"]//td[7]/b') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#英雄总击杀
total_kill_c <- 0
for (k in 1:length(kill_c)) {
  total_kill_c[k] <- kill_c[[k]][1]
}
total_kill_c <- as.numeric(total_kill_c)

#英雄场均击杀
average_kill_c <- 0
for (k in 1:length(kill_c)) {
  average_kill_c[k] <- kill_c[[k]][2]
}
average_kill_c <- as.numeric(average_kill_c)

assistance_c <- RS.get_Text('//*[@id="heroRank"]//td[8]/b') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#英雄总助攻
total_assistance_c <- 0
for (k in 1:length(assistance_c)) {
  total_assistance_c[k] <- assistance_c[[k]][1]
}
total_assistance_c <- as.numeric(total_assistance_c)

#英雄场均助攻
average_assistance_c <- 0
for (k in 1:length(assistance_c)) {
  average_assistance_c[k] <- assistance_c[[k]][2]
}
average_assistance_c <- as.numeric(average_assistance_c)

death_c <- RS.get_Text('//*[@id="heroRank"]//td[9]/b') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#英雄总死亡
total_death_c <- 0
for (k in 1:length(death_c)) {
  total_death_c[k] <- death_c[[k]][1]
}
total_death_c <- as.numeric(total_death_c)

#英雄场均死亡
average_death_c <- 0
for (k in 1:length(death_c)) {
  average_death_c[k] <- death_c[[k]][2]
}
average_death_c <- as.numeric(average_death_c)

#kda
kda_c <- RS.get_Text('//*[@id="heroRank"]//td[10]/b') %>% 
  as.numeric()

#常用队员
player_use <- RS.get_Text('//*[@id="heroRank"]//td[11]/b')

character_data <- data.frame(character_name,
                             appearance_c,
                             pick,
                             ban,
                             rate_c,
                             total_kill_c,
                             average_kill_c,
                             total_assistance_c,
                             average_assistance_c,
                             total_death_c,
                             average_death_c,
                             kda_c,
                             player_use)

write.csv(character_data, file = "character_data.csv")



