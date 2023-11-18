library(tidyverse); library(vegan)

### Relevés

read.csv("data/extra2-header.csv", fileEncoding = "latin1") -> header

read.csv("data/extra2-species.csv", fileEncoding = "latin1") -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
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
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Constant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5)

### Dominant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header2, by = "SIVIMID") %>%
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
  metaMDS(trymax = 10, k = 2) ->
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

### C1 Potentiolion
### C2 Potentiolion
### C3 Anogrammo
### C4 Gleras
### C5 Terófitos dunares
### C6 Dunas











### C5

header2 %>%
  filter(Cluster %in% c("1")) %>%
  select(-Cluster) -> header5

species %>%
  filter(SIVIMID %in% header5$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header5  %>%
  merge(kclusters, by = "SIVIMID") -> header6

### Expert system

header6 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Sintaxa

header6 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Constant

species %>%
  merge(header6, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5)

### Dominant

species %>%
  merge(header6, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header6, by = "SIVIMID") %>%
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

header6 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 10, k = 2) ->
  nmds # Ordination output

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header6, by = "SIVIMID") -> header4NMDS

# write.csv(header4NMDS, "data/urban-header-nmds.csv", fileEncoding = "latin1", row.names = FALSE)

header4NMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Cluster)), show.legend = T)








header2 %>%
  filter(Cluster %in% c(2)) %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = fct_recode(as.factor(Cluster),
                                       "Linario polygalifoliae-Vulpion alopecuri" = "2")) %>%
  select(-Cluster) %>%
  write.csv("results/Extra Linario.csv", row.names = FALSE, fileEncoding = "Latin1")
