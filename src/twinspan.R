library(tidyverse); library(vegan)

read.csv("data/species.csv") -> species
read.csv("data/header.csv") -> header

### Format species for twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 20) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

### Merge clusters and ordination

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header, by = "SIVIMID") %>%
  merge(kclusters, by = "SIVIMID") %>%
  mutate(Cluster = as.factor(Cluster)) %>%
  write.csv("results/twinspan-header.csv", row.names = FALSE)


