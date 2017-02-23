library(tidyverse)
library(stringr)
enc<-guess_encoding('c:\\users\\nsteinm\\downloads\\cfr_roster_l.txt')[1,1]
cfr_roster_raw<-read_lines('c:\\users\\nsteinm\\downloads\\cfr_roster_l.txt')
temp<-iconv(cfr_roster_raw,enc, "UTF-8")
temp<-str_replace_all(temp,'\\*'," ")
temp<-str_replace_all(temp,'\\f',"")
temp<-str_replace_all(temp,'[0-9]'," ")

temp<-temp%>%str_split(pattern=" {2,}")%>%unlist()
temp<-data.frame(member=temp,stringsAsFactors = F)
temp<-filter(temp,str_detect(member,""))
temp<-filter(temp,member!='.')
temp<-filter(temp,!str_detect(member,"[mM]embership"))
temp<-filter(temp,!str_detect(member,"ship in"))
temp<-filter(temp,!str_length(member)==1)
temp<-filter(temp,!str_detect(member,"member-"))
cfr_roster<-temp

contacts_raw<-read_csv('C:\\Users\\nsteinm\\Downloads\\contacts.csv')
contacts<-contacts_raw[,1:3]
temp<-cfr_roster%>%transmute(lastname=word(member,1),
                             firstname=word(member,2),
                             middle=word(member,3))
temp$lastname<-temp$lastname%>%str_replace_all(',','')
temp$middle<-temp$middle%>%str_replace_all('\\.','')
temp$firstname<-temp$firstname%>%str_replace_all('\\.','')
cfr_roster<-temp
