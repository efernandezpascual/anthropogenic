library(tidyverse); library(vegan)

read.csv("data/header-revised-v2.1.csv", fileEncoding = "latin1") -> headerOrig
read.csv("data/extra2-header.csv", fileEncoding = "latin1") -> headerExtra1
read.csv("data/header-extra2.1.csv", fileEncoding = "latin1") -> headerExtra2
rbind(headerExtra1, headerExtra2) %>%
  group_by(SIVIMID) %>%
  sample_n(1) -> headerExtra

rbind(read.csv("results/Extra Bidention Paspalo.csv", fileEncoding = "latin1"),
      read.csv("results/Extra Linario.csv", fileEncoding = "latin1"),
      read.csv("results/Extra Revised Cynancho-Convolvulion sepium Potentillion anserinae.csv", fileEncoding = "latin1"),
      read.csv("results/Extra Revised R57.csv", fileEncoding = "latin1"),
      read.csv("results/Extra Revised V34 Polycarpion tetraphylli bis.csv", fileEncoding = "latin1"),
      read.csv("results/Extra Revised V34 Polycarpion tetraphylli.csv", fileEncoding = "latin1")) %>%
  unique %>%
  group_by(SIVIMID) %>%
  sample_n(1) %>%
  filter(! SIVIMID %in% headerOrig$SIVIMID) %>%
  group_by(Revised.sintaxon) %>% 
  merge(headerExtra) %>%
  group_by(SIVIMID) -> UpdatedExtra

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 4) %>%
  select(Sintaxon, Alliance) -> sintaxa

rbind(
headerOrig %>% select(SIVIMID, Revised.sintaxon, Sintaxon),
UpdatedExtra %>% select(SIVIMID, Revised.sintaxon, Sintaxon)) %>%
  group_by(SIVIMID) %>%
  merge(sintaxa, all.x = TRUE) %>%
  select(SIVIMID, Alliance, Revised.sintaxon) %>%
  rename(Revised.alliance = Revised.sintaxon) %>%
  mutate(Semisupervised = ifelse((Revised.alliance == Alliance | is.na(Alliance)), 1, 0)) %>%
  write.csv("data/releve-selection-3.0.csv", fileEncoding = "latin1")

read.csv("data/releve-selection-3.0.csv", fileEncoding = "latin1") %>% select(-X) -> selection

rbind(
headerOrig %>%
  select(SIVIMID, Relevé.number, Sintaxon, EUNIS2020, Aspect, Slope, Area, Year, DEG_LON, DEG_LAT, Accuracy, Elevation),
headerExtra %>%
  select(SIVIMID, Relevé.number, Sintaxon, EUNIS2020, Aspect, Slope, Area, Year, DEG_LON, DEG_LAT, Accuracy, Elevation)) %>%
  merge(selection) %>%
  mutate(Semisupervised = ifelse((Revised.alliance == Alliance | is.na(Alliance)), 1, 0)) %>%
  mutate(Semisupervised = ifelse(is.na(Revised.alliance), 0, Semisupervised)) %>%
  select(SIVIMID, Relevé.number, Semisupervised, Revised.alliance, Alliance, Sintaxon, EUNIS2020, Aspect, Slope, Area, Year, DEG_LON, DEG_LAT, Accuracy, Elevation) %>% 
  group_by(SIVIMID) %>%
  sample_n(1) -> headerIII

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>% rename(Relevé.number = Releve.number) -> spp
read.csv("data/extra2-species.csv", fileEncoding = "latin1")  %>% select(-X) -> Extraspp1
read.csv("data/species-extra2.1.csv", fileEncoding = "latin1")  %>% select(-X) -> Extraspp2

rbind(spp, Extraspp1, Extraspp2) %>%
  group_by(SIVIMID, Analysis.Names) %>%
  sample_n(1) %>%
  filter(SIVIMID %in% headerIII$SIVIMID) %>%
  write.csv("data/urban-species-3.0.csv", row.names = FALSE, fileEncoding = "latin1")

write.csv(headerIII, "data/urban-header-3.0.csv", row.names = FALSE, fileEncoding = "latin1")
