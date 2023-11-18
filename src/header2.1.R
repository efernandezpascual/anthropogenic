library(tidyverse); library(vegan)

### Relevés

rbind(read.csv("results/Revised R55 Senecionion.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V1.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V34.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V35.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V37 Sisymbrion.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V38 Dauco.csv", fileEncoding = "latin1"),
      read.csv("results/Revised V39.csv", fileEncoding = "latin1"),
      read.csv("results/Revised W.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/header-revised.csv", fileEncoding = "latin1"), all.y = TRUE) %>%
  mutate(Alliance = ifelse(Alliance == "Spergulo arvensis-Erodion cicutariae", "Oxalidion europeae", Alliance)) %>%
  mutate(Order = ifelse(Order == "Eragrostietalia", "Aperetalia spicae-venti", Order)) %>%
  mutate(Class = ifelse(Class == "Digitario sanguinalis-Eragrostietea minoris", "Papaveretea rhoeadis", Class)) %>%
  filter(SIVIMID != "R-P20727") %>% # Polygono maritimi-Elytrigietum athericae (halonitrófila)
  filter(! Sintaxon %in% "Polypodion serrati") %>%
  mutate(SS = ifelse((Alliance != Revised.sintaxon | is.na(Alliance)), 0, 1)) ->
  header

write.csv(header, "data/header-revised-v2.1.csv", row.names = FALSE, fileEncoding = "latin1")

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Check agreement

header %>%
  group_by(Revised.sintaxon, EUNIS2020) %>%
  tally %>%
  spread(EUNIS2020, n, fill = 0) %>%
  write.csv("classification-vs-expert.csv", row.names = FALSE)

header %>%
  group_by(Revised.sintaxon, Alliance) %>%
  tally %>%
  spread(Alliance, n, fill = 0) %>%
  write.csv("classification-vs-alliance.csv", row.names = FALSE)

header %>%
  group_by(Revised.sintaxon) %>%
  tally()

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 15) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
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
  group_by(Cluster, Revised.sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Constant

species %>% 
  merge(header2) %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5)

### Dominant

species %>% 
  merge(header2) %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5)

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
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 5)

### C1 Dauco-Melilotion
### C2 Dauco-Melilotion (solapa en NMDS)
### C3 Dauco-Melilotion (solapa en NMDS)
### C4 Dauco-Melilotion (solapa en NMDS)

### NMDS

library(vegan)

header2 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 200, k = 2) ->
  nmds # Ordination output

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2, by = "SIVIMID") -> header2NMDS

# write.csv(header4NMDS, "data/urban-header-nmds.csv", fileEncoding = "latin1", row.names = FALSE)

header2NMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Cluster)), show.legend = T)