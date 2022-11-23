library(tidyverse); library(vegan)

read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") -> header

header %>%
  filter(EUNIS_REVISED %in% c("V39", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(1, 5) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV39




read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") %>%
  mutate(EUNIS_REVISED = ifelse(SIVIMID %in% newV39, "V39", EUNIS_REVISED)) -> header

header %>%
  filter(EUNIS_REVISED %in% c("V38", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(1, 2, 6) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV38




read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") %>%
  mutate(EUNIS_REVISED = ifelse(SIVIMID %in% newV39, "V39", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV38, "V38", EUNIS_REVISED)) -> header

header %>%
  filter(EUNIS_REVISED %in% c("V37", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(1, 2, 6) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV37







read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") %>%
  mutate(EUNIS_REVISED = ifelse(SIVIMID %in% newV39, "V39", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV38, "V38", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV37, "V37", EUNIS_REVISED)) -> header

header %>%
  filter(EUNIS_REVISED %in% c("V35", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(3) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV35







read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") %>%
  mutate(EUNIS_REVISED = ifelse(SIVIMID %in% newV39, "V39", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV38, "V38", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV37, "V37", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV35, "V35", EUNIS_REVISED)) -> header

header %>%
  filter(EUNIS_REVISED %in% c("V15", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(1) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV15






read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") %>%
  mutate(EUNIS_REVISED = ifelse(SIVIMID %in% newV39, "V39", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV38, "V38", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV37, "V37", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV35, "V35", EUNIS_REVISED),
         EUNIS_REVISED = ifelse(SIVIMID %in% newV15, "V15", EUNIS_REVISED)) -> header

header %>%
  filter(EUNIS_REVISED %in% c("")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0


### Format species for twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

# write.csv(header2, "data/urban-header-revised8.csv", row.names = FALSE, fileEncoding = "latin1")

### Merge clusters and ordination

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> header2

header2 %>%
  group_by(Twinspan4, EUNIS_REVISED) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

header2 %>%
  filter(Twinspan4 %in% c(1) & EUNIS_REVISED == "") %>%
  pull(SIVIMID) -> newV15


header %>%
 select(-c(Twinspan3, PriorCluster, Twinspan2, Twinspan, NMDS1, NMDS2)) %>%
  write.csv("data/urban-header-revised9.csv", row.names = FALSE, fileEncoding = "latin1")
