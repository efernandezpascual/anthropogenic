library(tidyverse); library(vegan)

### Relevés

read.csv("data/header-revised.csv", fileEncoding = "latin1") %>%
  filter(! Sintaxon %in% "Polypodion serrati") %>%
  filter(CODE %in% c("W1", "W2")) -> header

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 4) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
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
  group_by(Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  slice_max(F, n = 10)

species %>% 
  merge(header2) %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 4) %>% data.frame

### Dominant

species %>% 
  merge(header2) %>%
  group_by(Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  slice_max(D, n = 10)

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

### C1 Parietario + Cymbalarion
### Polypodietum
### Las dos alianzas son indistinguibles en base a composición florística

header2 %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = "Cymbalario-Asplenion") %>%
  select(-Cluster) %>%
  write.csv("results/Revised W.csv", row.names = FALSE, fileEncoding = "Latin1") 
