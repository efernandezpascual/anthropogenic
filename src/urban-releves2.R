library(tidyverse)

### Reselect SIVIM plots after first classification rounds

openxlsx::read.xlsx("data/Sintaxa.xlsx") -> sintaxa 

sintaxa %>% filter(ANTHROPIC == "No") %>% pull(Sintaxon) -> natural
sintaxa %>% filter(ANTHROPIC != "No") %>% pull(Sintaxon) -> unnatural

read.csv("results/twinspan2-header.csv", fileEncoding = "latin1") %>%
  filter(! Sintaxon %in% natural) %>% pull(SIVIMID) -> selected1

read.csv("../canteunis/results/SIVIM/header.csv", 
         fileEncoding = "latin1") %>%
  filter(! SIVIMID %in% selected1) %>% # Plots already selected
  filter(Sintaxon %in% unnatural) %>%
  pull(SIVIMID) -> selected2

c(selected1, selected2) -> selected

read.csv("../canteunis/results/SIVIM/header.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% selected) %>%
  merge(sintaxa, all.x = TRUE) -> header

read.csv("../canteunis/results/SIVIM/species.csv", fileEncoding = "latin1")%>%
  filter(SIVIMID %in% header$SIVIMID) %>%
  rename(`Releve number` = Relevé.number) %>%
  mutate(Analysis.Names = ifelse(Analysis.Names == "Arctium atlanticum", "Arctium minus", Analysis.Names)) %>%
  mutate(Analysis.Names = ifelse(Analysis.Names == "Cirsium creticum", "Cirsium palustre", Analysis.Names))  -> species

### Llangréu plots

read.csv("../canteunis/data/sivim/sivim_checklist_2.1.csv") -> checklist

read.csv("data/header-omar.csv", fileEncoding = "latin1") %>%
  merge(sintaxa, all.x = TRUE) %>%
  filter(! Sintaxon %in% natural) %>%
  mutate(Relevé.number = NA,
         Temp = NA,
         Precip = NA, 
         UTM10X10 = NA, 
         UTM1X1 = NA,
         JuiceID = NA, OriginalElevation = NA,
         SintaxonID = NA,
         DUNES_BOHN = NA,
         ECOREG_WWF = NA,
         Authors = NA,
         Title = NA, 
         Publication = NA,
         EUNIS2020 = NA, 
         Type = NA) %>%
  rename(DEG_LON = Longitude, DEG_LAT = Latitude, Year = Date) %>%
  select(Sintaxon, Relevé.number, Temp, Precip, UTM10X10,         
          UTM1X1, SIVIMID, JuiceID, OriginalElevation, Locality,        
          Country, ECOREG_WWF, DUNES_BOHN, Plant.Cover, Aspect,          
          Slope, Area, SintaxonID, Authors, Year,
          Title, Publication, EUNIS2020, Type, DEG_LON,
          DEG_LAT, Accuracy, Elevation, ANTHROPIC, Vegetation,       
          Class, Order, Alliance) -> headerOmar

read.csv("data/species-omar.csv", fileEncoding = "latin1") %>%
  mutate(Check = ifelse(!Analysis.Names %in% checklist$Analysis.Names, "Yes", "OK")) %>%
  filter(SIVIMID %in% headerOmar$SIVIMID) %>%
  mutate("Releve number" = NA) %>%
  select(-Check) -> speciesOmar

### Save header and species

rbind(header, headerOmar) %>%
  filter(DUNES_BOHN != "Y_DUNES" | is.na(DUNES_BOHN)) -> headerExtra
rbind(species, speciesOmar) %>%
  filter(SIVIMID %in% headerExtra$SIVIMID) -> speciesExtra

write.csv(headerExtra, "data/header.csv", row.names = FALSE, fileEncoding = "latin1")
write.csv(speciesExtra, "data/species.csv", row.names = FALSE, fileEncoding = "latin1")
