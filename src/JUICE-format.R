library(tydiverse)

read.csv("data/urban-header.csv", fileEncoding = "latin1") -> header4
read.csv("data/urban-species.csv", fileEncoding = "latin1") -> species4


### Format for JUICE

header4 %>%
  rownames_to_column(var = "Relevé number") %>%
  select(`Relevé number`, SIVIMID, EUNIS_REVISED, EUNIS2020, 
         EUNISL1, EUNISL2, PCluster, 
         Class, Order, Alliance, Sintaxon,
         Aspect, Slope, Area, 
         Year, DEG_LON, DEG_LAT,
         Accuracy, Elevation) -> headerJUICE

species4 %>%
  merge(headerJUICE, by = "SIVIMID") %>%
  select(`Relevé number`, SIVIMID, Original.Taxon, 
         Analysis.Names, Cover, Cover.percent) -> speciesJUICE

write.csv(headerJUICE, "results/headerJUICE.csv", row.names = FALSE, fileEncoding = "latin1")
write.csv(speciesJUICE, "results/speciesJUICE.csv", row.names = FALSE, fileEncoding = "latin1")