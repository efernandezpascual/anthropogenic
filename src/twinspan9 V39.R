library(tidyverse); library(vegan)

read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised9.csv", fileEncoding = "latin1") -> header

header %>%
  filter(EUNIS_REVISED %in% c("V39", "")) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0

### Twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 4) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan = Cluster) -> header2

header2 %>%
  group_by(Twinspan, Alliance) %>%
  tally %>%
  arrange(Twinspan, -n) %>%
  data.frame

### NMDS

header2 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2, by = "SIVIMID") %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan)), show.legend = T)

### Remove weird plots

header2 %>%
  filter(Twinspan != 2) -> header0

species %>%
  filter(SIVIMID %in% header0$SIVIMID) -> species0

### Twinspan

species0 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 4) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header0 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan2 = Cluster) -> header2

header2 %>%
  group_by(Twinspan2, Alliance) %>%
  tally %>%
  arrange(Twinspan2, -n) %>%
  data.frame

### NMDS

header2 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2, by = "SIVIMID") %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan)), show.legend = T)

### Map

header2 %>%
  ggplot(aes(x = DEG_LON, y = DEG_LAT)) +
  geom_point(aes(color = as.factor(Twinspan2)))

### Format for JUICE


header2 %>%
  
  rownames_to_column(var = "Relevé number") %>%
  select(`Relevé number`, SIVIMID, EUNIS_REVISED, EUNIS2020, 
         Twinspan, Twinspan2, 
         Class, Order, Alliance, Sintaxon,
         Aspect, Slope, Area, 
         Year, DEG_LON, DEG_LAT,
         Accuracy, Elevation) -> headerJUICE

species %>%
  merge(headerJUICE, by = "SIVIMID") %>%
  select(`Relevé number`, SIVIMID, Original.Taxon, 
         Analysis.Names, Cover, Cover.percent) -> speciesJUICE

write.csv(headerJUICE, "results/headerJUICE9V39.csv", row.names = FALSE, fileEncoding = "latin1")
write.csv(speciesJUICE, "results/speciesJUICE9V39.csv", row.names = FALSE, fileEncoding = "latin1")
