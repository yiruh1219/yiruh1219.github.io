library(tidyverse)
library(RS.Driver)
RS.OpenChrome(4444)
RS.open_Url("https://lpl.qq.com/esnew/data/rank.shtml?iGameId=148&sGameType=7,8")

#选手名
player_name <- RS.get_Text('//*[@id="playerRank"]//td[2]')

#位置
position <- RS.get_Text('//*[@id="playerRank"]//td[3]')

#选手出场次数
appearance_p <- RS.get_Text('//*[@id="playerRank"]//td[4]') %>% 
  as.numeric()

kill_p <- RS.get_Text('//*[@id="playerRank"]//td[5]') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#选手总击杀
total_kill_p <- 0
for (j in 1:length(kill_p)) {
  total_kill_p[j] <- kill_p[[j]][1]
}
total_kill_p <- as.numeric(total_kill_p)

#选手场均击杀
average_kill_p <- 0
for (j in 1:length(kill_p)) {
  average_kill_p[j] <- kill_p[[j]][2]
}
average_kill_p <- as.numeric(average_kill_p)

assistance <- RS.get_Text('//*[@id="playerRank"]//td[6]') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#选手总助攻
total_assistance <- 0
for (j in 1:length(assistance)) {
  total_assistance[j] <- assistance[[j]][1]
}
total_assistance <- as.numeric(total_assistance)

#选手场均助攻
average_assistance <- 0
for (j in 1:length(assistance)) {
  average_assistance[j] <- assistance[[j]][2]
}
average_assistance <- as.numeric(average_assistance)

death_p <- RS.get_Text('//*[@id="playerRank"]//td[7]') %>% 
  str_remove('\\)') %>% 
  strsplit(split = '\\(')

#选手总死亡
total_death_p <- 0
for (j in 1:length(death_p)) {
  total_death_p[j] <- death_p[[j]][1]
}
total_death_p <- as.numeric(total_death_p)

#选手场均死亡
average_death_p <- 0
for (j in 1:length(death_p)) {
  average_death_p[j] <- death_p[[j]][2]
}
average_death_p <- as.numeric(average_death_p)

#KDA
kda <- RS.get_Text('//*[@id="playerRank"]//td[8]') %>% 
  as.numeric()

#选手场均金钱
average_money_p <- RS.get_Text('//*[@id="playerRank"]//td[9]') %>% 
  as.numeric()

#选手场均补刀
average_farm <- RS.get_Text('//*[@id="playerRank"]//td[10]') %>% 
  as.numeric() 

#选手场均插眼
average_ward_p <- RS.get_Text('//*[@id="playerRank"]//td[11]') %>% 
  as.numeric() 

#选手场均排眼
average_wardkill_p <- RS.get_Text('//*[@id="playerRank"]//td[12]') %>% 
  as.numeric() 

#选手场均参团率
average_fight <- RS.get_Text('//*[@id="playerRank"]//td[13]') %>% 
  str_remove('%') %>% 
  as.numeric() 

#MVP次数
mvp <- RS.get_Text('//*[@id="playerRank"]//td[14]') %>% 
  as.numeric() 

#对位经济领先
money_excess <- RS.get_Text('//*[@id="playerRank"]//td[15]') %>% 
  as.numeric() 

#伤害占比
damage <- RS.get_Text('//*[@id="playerRank"]//td[16]') %>% 
  str_remove('%') %>% 
  as.numeric() 

#经济占比
economic <- RS.get_Text('//*[@id="playerRank"]//td[17]') %>% 
  str_remove('%') %>% 
  as.numeric() 

player_data <- data.frame(player_name,
                          position,
                          appearance_p,
                          total_kill_p,
                          average_kill_p,
                          total_assistance,
                          average_assistance,
                          total_death_p,
                          average_death_p,
                          kda,
                          average_money_p,
                          average_farm,
                          average_ward_p,
                          average_wardkill_p,
                          average_fight,
                          mvp,
                          money_excess,
                          damage,
                          economic)
player_data <- player_data %>% 
  mutate(position = case_when(position == "上单" ~ "top",
                              position == "中单" ~ "mid",
                              position == "打野" ~ "jungle",
                              position == "ADC"  ~ "ad",
                              position == "辅助" ~ "sup"))

write.csv(player_data, file = "player_data.csv")









