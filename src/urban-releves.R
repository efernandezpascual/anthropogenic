library(tidyverse)

### Plot IDs after semi supervised + manual revision

read.table("data/Export Header Data/1.txt", skip = 1) -> d1
read.table("data/Export Header Data/3.txt", skip = 1) -> d3
read.table("data/Export Header Data/4.txt", skip = 1) -> d4
read.table("data/Export Header Data/5.txt", skip = 1) -> d5
read.table("data/Export Header Data/6.txt", skip = 1) -> d6
read.table("data/Export Header Data/7.txt", skip = 1) -> d7
read.table("data/Export Header Data/8.txt", skip = 1) -> d8
read.table("data/Export Header Data/9.txt", skip = 1) -> d9
read.table("data/Export Header Data/10.txt", skip = 1) -> d10
read.table("data/Export Header Data/11.txt", skip = 1) -> d11

### Header data

rbind(d1, d3, d4, d5, d6, d7, d8, d9, d10, d11) %>%
  rename(SIVIMID = V4,
         EUNIS = V5, 
         Class = V6) %>%
  select(SIVIMID, EUNIS, Class) %>%
  merge(read.csv("../canteunis/results/SIVIM/header.csv", 
                 fileEncoding = "latin1"), by = "SIVIMID") -> header
  
### Species data

read.csv("../canteunis/results/SIVIM/species.csv", fileEncoding = "latin1")%>%
  filter(SIVIMID %in% header$SIVIMID) %>%
  rename(`Releve number` = Relevé.number) -> species

### Save header and species

write.csv(header, "data/header.csv", row.names = FALSE)
write.csv(species, "data/species.csv", row.names = FALSE)

### Format for JUICE

# header %>%
#   select(`Releve number`, Class, EUNIS, Sintaxon, SIVIMID, Plant.Cover,
#          Aspect, Slope, Area, Year, DEG_LON, DEG_LAT,
#          Accuracy, Elevation) %>%
#   rename(`Releve number` = Relevé.number) -> headerJUICE
# 
# species %>%
#   rename(`Releve number` = Relevé.number) -> speciesJUICE