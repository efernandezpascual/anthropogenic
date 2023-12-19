library(tidyverse)

read.csv("results/sintaxonomy/original-sintaxonomy.csv") %>%
  select(Anthropogenic, Alliance, Class, Original) %>%
  unique %>%
  arrange(Original) -> sintaxa 

read.csv("../canteunis/results/SIVIM/header2.3.csv", fileEncoding = "latin1") %>%
  mutate(EUNISL1 = substring(EUNIS2.3, 1, 1)) %>%
  filter(EUNISL1 == "V" | # manmade EUNIS habitats
           EUNIS2.3 %in% c("R55", "R57") | # Epilobietea fringes not in EUNIS V
           Sintaxon %in% pull(filter(sintaxa, Anthropogenic == "Yes"), Original)) %>% # SIVIM sintaxa belonging to anthropogenic classes
  filter(!SIVIMID %in% pull(read.csv("data/new_releves/not-manmade-cantabrian.csv", fileEncoding = "latin1"), SIVIMID)) %>%
  data.frame %>%
  select(SIVIMID, Sintaxon, EUNIS2.3, Area, Year, DEG_LON, DEG_LAT, Accuracy, ALTITUDE..M., Aspect, Slope) %>%
  rename(Elevation = ALTITUDE..M.,
         EUNIS = EUNIS2.3,
         Longitude = DEG_LON,
         Latitude = DEG_LAT) %>%
  rbind(read.csv("data/new_releves/header-additions.csv", fileEncoding = "latin1")) %>%
  rename(Original = Sintaxon) %>%
  merge(sintaxa, all.x = TRUE) %>%
  filter(! Class %in% c("Trifolio-Geranietea sanguinei",
                        "Mulgedio-Aconitetea",
                        "Saginetea maritimae",
                        "Thlaspietea rotundifolii",
                        "Quercetea ilicis",
                        "Sedo-Scleranthetea",
                        "Festuco-Brometea",
                        "Isoëto-Nanojuncetea",
                        "Juncetea maritimi",
                        "Potamogetonetea")) %>%
  select(SIVIMID, Original, Alliance, Class, EUNIS:Slope) %>%
  mutate(Alliance = ifelse(is.na(Alliance), "Unknown", Alliance)) %>%
  unique -> header

read.csv("../canteunis/results/SIVIM/species2.3.csv", fileEncoding = "latin1") %>%
  select(SIVIMID, Original.Taxon, Analysis.Names, Cover.percent) %>%
  rbind(read.csv("data/new_releves/species-additions.csv", fileEncoding = "latin1") ) %>%
  group_by(SIVIMID, Analysis.Names) %>%
  summarise(Cover.percent = sum(Cover.percent)) %>%
  na.omit %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

filter(header, ! SIVIMID %in% species$SIVIMID)
filter(species, ! SIVIMID %in% header$SIVIMID)
species %>% group_by(SIVIMID)
header %>% group_by(SIVIMID)

write.csv(header, "data/urban-header-5.0.csv", fileEncoding = "latin1", row.names = FALSE)
write.csv(species, "data/urban-species-5.0.csv", fileEncoding = "latin1", row.names = FALSE)
