library(tidyverse); library(vegan)

### Relevés

read.csv("data/header-revised.csv", fileEncoding = "latin1") %>%
  filter(CODE %in% c("V39a", "V39b", "V39c", "V39d", "V39e", "V39f")) -> header

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 6) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>%
  merge(kclusters, by = "SIVIMID") -> header2

### Expert system

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Sintaxa

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Constant

species %>% 
  merge(header2) %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 4) %>% data.frame

### Dominant

species %>% 
  merge(header2) %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 4) %>% data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header2) %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-SIVIMID, Cluster) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

### C1 Geo urbani-Alliarion officinalis
### C2 Geranio pusilli-Anthriscion caucalidis
### C3 Balloto-Conion maculati
### C4 Arction lappae
### C5 Polygono maritimi-Elytrigietum athericae (halonitrófila)
### C6 Geo urbani-Alliarion officinalis

header2 %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = fct_recode(as.factor(Cluster), 
                                      "Geo urbani-Alliarion officinalis" = "1",
                                      "Geranio pusilli-Anthriscion caucalidis" = "2",
                                      "Balloto-Conion maculati" = "3",
                                      "Arction lappae" = "4",
                                      "Polygono maritimi-Elytrigietum athericae" = "5",
                                      "Geo urbani-Alliarion officinalis"  = "6")) %>%
  select(-Cluster) %>%
  write.csv("results/Revised V39.csv", row.names = FALSE, fileEncoding = "Latin1") 

         