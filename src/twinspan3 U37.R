library(tidyverse); library(vegan)

read.csv("results/twinspan2-header.csv", fileEncoding = "latin1") %>%
  select(-c(NMDS1, NMDS2)) %>%
  filter(Twinspan2 == "Walls") -> header

read.csv("results/twinspan2-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID)-> species

### New twinspan

### Format species for twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

### Merge clusters and ordination

header %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan3 = Cluster) -> header2

header2 %>%
  group_by(Twinspan3, EUNIS) %>%
  tally %>%
  arrange(Twinspan3, -n) %>%
  data.frame

header2 %>%
  group_by(Twinspan3, Sintaxon) %>%
  tally %>%
  arrange(Twinspan3, -n) %>%
  data.frame

header2 %>%
  filter(EUNIS == "V") %>%
  group_by(Twinspan3) %>%
  tally %>%
  arrange(-n) %>%
  data.frame


header2 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan3)), show.legend = F)

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Sintaxon) %>%
  summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_text(aes(label = Sintaxon, color = as.factor(Sintaxon)), show.legend = F)