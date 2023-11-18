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
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

### NMDS

library(vegan)

header2 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 1000, k = 2) ->
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

### C1 Galio valantiae-Parietarion judaicae
### C2 Cymbalario-Asplenion
### C3 
### C4 Cymbalario-Asplenion (dominance of Pteridophytes, position in NMDS)


header2 %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = fct_recode(as.factor(Cluster), 
                                       "Galio valantiae-Parietarion judaicae" = "1",
                                       "Cymbalario-Asplenion" = "2",
                                       "Geranio pusilli-Anthriscion caucalidis" = "3",
                                       "Cymbalario-Asplenion" = "4")) %>%

header2 %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = "Cymbalario-Asplenion") %>%
  select(-Cluster) %>%
  write.csv("results/Revised W.csv", row.names = FALSE, fileEncoding = "Latin1") 
