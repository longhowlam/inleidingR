###############################################################################
###
###   Oefeningen Inleiding R cursus


### libraries die je nodig hebt
library(readr)
library(tidyve)

#### Avond sessie 1 ###########################################################




#### Avond sessie 2 ###########################################################
library(readr)

Restaurants = read_csv("data/Restaurants.csv")
postcode = readRDS("data/postocdes_NL.RDs")



# split and stack data
tmp = as(Groceries,"data.frame")
tmp2 = tidyr::separate(tmp, items, into=paste0("V",1:60), sep=",")
tmp2$id = 1:9835
tmp3 = tidyr::gather(tmp2,temp,item, -id)
tmp3 =  tmp3 %>% dplyr::filter(!is.na(item), item !="") %>% dplyr::arrange(id) %>% dplyr::mutate(
  item = stringr::str_replace_all(item,"\\{",""),
  item = stringr::str_replace_all(item,"\\}","")
) %>%
  dplyr::select(-temp)




#### Avond sessie 3 ###########################################################

library(readr)


X = c("abd 07-456", "blab la (06)-123.45678", "hoi 06 12 1234 78", "mijn nr 0689452312")

Restaurants = read_csv("data/Restaurants.csv")



AUTO_TRADER_ALL_BEWERKT = read_delim( "data/AUTO_TRADER_ALL_BEWERKT.csv", ";")





#### Avond sessie 4 ###########################################################