library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") -> header

read.csv("data/species.csv", fileEncoding = "latin1") -> species

### Format species for twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 7) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

### Merge clusters and ordination

header %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan = Cluster) -> header2

header2 %>%
  group_by(Twinspan, Alliance) %>%
  tally %>%
  arrange(Twinspan, -n) %>%
  data.frame

header2 %>%
  group_by(Twinspan, Class) %>%
  tally %>%
  arrange(Twinspan, -n) %>%
  data.frame

header2 %>%
  group_by(Twinspan, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan, -n) %>%
  data.frame %>%
  spread(Twinspan, n, fill = "-")

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
  write.csv("results/urban-header-twinspan-NMDS.csv", row.names = FALSE, fileEncoding = "latin1")


read.csv("results/urban-header-twinspan-NMDS.csv", fileEncoding = "latin1") -> header

read.csv("data/species.csv", fileEncoding = "latin1") -> species


header %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Class)), show.legend = T)

header %>% filter(NMDS1 > 0.25)

###################################

### Cluster 4 - Weeds rich soils

header2 %>%
  filter(Twinspan3 == 1) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, Class) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, Sintaxon) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

# s1$sites %>%

headerT12 %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  # filter(DEG_LON < 40) %>%
  ggplot(aes(x = DEG_LON, y = DEG_LAT)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = F)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1.y, y = NMDS2.y)) +
  geom_point(aes(color = as.factor(Alliance)))

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = T)

s1%>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  mutate(Twinspan = "V15 Weeds rich soils") %>%
  mutate(Twinspan4 = fct_recode(as.factor(Twinspan4), "V15 Winter weeds" = "1", "V15 Summer weeds" = "2")) %>%
  # filter(NMDS1 > -2) %>%
  # filter(NMDS2 < 1.5) %>%
  # filter(NMDS2 > -.9) %>%
  # filter(NMDS1 < 2) %>%
  select(-c(NMDS1, NMDS2)) %>%
  mutate(Twinspan = "V15Z Weeds of rich soils") -> V15Z

###################################

### Cluster 2 - Weeds poor soils

header2 %>%
  filter(Twinspan == 5) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Sintaxon) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Class)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  select(-c(NMDS1, NMDS2)) %>%
  mutate(Twinspan = "V15Y Weeds of poor soils",
         Twinspan4 = "V15 Summer weeds") -> V15Y

###################################

### Cluster 3 - Trampled

header2 %>%
  filter(Twinspan == 6) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 4) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  filter(Twinspan4 != 4) %>%
  select(-c(NMDS1, NMDS2)) %>%
  mutate(Twinspan = "V35 Trampled",
         Twinspan4 = fct_recode(as.factor(Twinspan4),
                                "Polygono-Coronopodion" = "1",
                                "Cynosurion cristati" = "2",
                                "Polycarpion tetraphylli" = "3")) -> V35

headerT12 %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  # filter(DEG_LON < 40) %>%
  ggplot(aes(x = DEG_LON, y = DEG_LAT)) +
  geom_point(aes(color = as.factor(Twinspan4)))

###################################

### Cluster 4 - Ruderal mesic

header2 %>%
  filter(Twinspan == 1) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # filter(NMDS1 > -2) %>%
  # filter(NMDS2 > -1.1) %>%
  select(-c(NMDS1, NMDS2)) %>%
  mutate(Twinspan = "V39 Ruderal mesic",
         Twinspan4 = fct_recode(as.factor(Twinspan4), "Western" = "2", "Eastern" = "1"))-> V39

###################################

### Cluster 5 - Ruderal annual

header2 %>%
  filter(Twinspan == 2) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  mutate(Twinspan = "V37 Ruderal annual") %>%
  filter(NMDS1 > -2) %>%
  mutate(Twinspan4 = fct_recode(as.factor(Twinspan4), 
                                "Sisymbrion officinalis" = "1",
                                "Dauco-Melilotion" = "2")) %>%
  select(-c(NMDS1, NMDS2))  -> V37

###################################

### Cluster 6 - Thistle

header2 %>%
  filter(Twinspan == 3) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Class)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  mutate(Twinspan = "V38 Ruderal dry") %>%
  mutate(Twinspan4 = "Cirsion") %>%
  select(-c(NMDS1, NMDS2))  -> V38

###################################

### Cluster 7 - Walls

header2 %>%
  filter(Twinspan == 7) -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan4 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan4, Alliance) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Class)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  filter(NMDS1 > -2) %>%
  filter(NMDS2 > -1.2) %>%
  mutate(Twinspan = "U37 Walls", Twinspan4 = "Cymbalarion") %>%
  select(-c(NMDS1, NMDS2))  -> U37

### Merge and save

rbind(U37, V15Y, V15Z, V35, V38, V37, V39) -> headerNew

species %>%
  filter(SIVIMID %in% headerNew$SIVIMID) -> speciesNew

headerNew %>%
  merge(speciesNew, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

write.csv(speciesNew, "results/urban-species4.csv", row.names = FALSE, fileEncoding = "latin1")
write.csv(headerNew, "results/urban-header4.csv", row.names = FALSE, fileEncoding = "latin1")

read.csv("results/urban-species4.csv", fileEncoding = "latin1") -> species
read.csv("results/urban-header4.csv", fileEncoding = "latin1") -> header

header %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

# s1$sites %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header, by = "SIVIMID") %>%
#   write.csv("results/urban-header4NMDS.csv", row.names = FALSE, fileEncoding = "latin1")

read.csv("results/urban-species4.csv", fileEncoding = "latin1") -> species
read.csv("results/urban-header4NMDS.csv", fileEncoding = "latin1") -> header

header %>%
  # group_by(Twinspan4) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Twinspan4)), show.legend = F) +
  # geom_label(aes(label = Twinspan4, fill = Twinspan4)) +
  coord_cartesian(ylim = c(-0.5, 0.5), xlim = c(-0.5, 0.5))


###################################

### Cluster 4 - Ruderal mesic

header %>% pull(Twinspan4) %>% unique
header %>% pull(Twinspan) %>% unique

header %>%
  filter(Twinspan %in% c("V15 Weeds of rich soils",
                         "V15 Weeds of poor soils")) -> headerT1
header %>%
  filter(Twinspan4 == "V39 Eastern mesic ruderals") -> headerT1

species %>%
  filter(SIVIMID %in% headerT1$SIVIMID)-> speciesT1

speciesT1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 3) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerT1 %>%
  merge(kclusters, by = "SIVIMID") %>%
  rename(Twinspan3 = Cluster) -> headerT12

headerT12 %>%
  group_by(Twinspan3, Alliance) %>%
  tally %>%
  arrange(Twinspan3, -n) %>%
  data.frame

headerT12 %>%
  group_by(Twinspan4, EUNIS2020) %>%
  tally %>%
  arrange(Twinspan4, -n) %>%
  data.frame %>%
  spread(Twinspan4, n, fill = "-")

headerT12 %>%
  merge(speciesT1, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1.y, y = NMDS2.y)) +
  geom_point(aes(color = as.factor(Alliance)), show.legend = T)

s1 %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerT12, by = "SIVIMID") %>%
  # filter(NMDS1 > -2) %>%
  # filter(NMDS2 > -1.1) %>%
  select(-c(NMDS1, NMDS2)) %>%
  mutate(Twinspan = "V39 Ruderal mesic",
         Twinspan4 = fct_recode(as.factor(Twinspan4), "Western" = "2", "Eastern" = "1"))-> V39

header %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  # filter(DEG_LON < 40) %>%
  ggplot(aes(x = DEG_LON, y = DEG_LAT)) +
  geom_point(aes(color = as.factor(Twinspan4)))

header %>%
  group_by(Alliance) %>%
  summarise(n = length(Alliance), 
            DEG_LON = mean(DEG_LON), 
            DEG_LAT = mean(DEG_LAT)) %>%
  arrange(n)
  # filter(DEG_LON < 40) %>%
  ggplot(aes(x = DEG_LON, y = DEG_LAT)) +
  geom_text(aes(label = as.factor(Alliance)), show.legend = F)

header  %>%
  merge(species) %>%
  group_by(Analysis.Names, Twinspan4) %>%
  tally %>%
  arrange(-n) %>%
  group_by(Twinspan4) %>%
  slice_max(order_by = n, n = 4) %>%
  data.frame

headerT12  %>%
  merge(species) %>%
  group_by(Analysis.Names, Twinspan3) %>%
  filter(Twinspan3 == 2) %>%
  tally %>%
  arrange(-n)

header %>%
  filter(EUNIS_REVISED != "") %>%
  # group_by(Sintaxon) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(EUNIS_REVISED)), show.legend = T)

header %>%
  mutate(EUNIS_Revised = ifelse(Twinspan %in% c("V15 Weeds of poor soils", "V15 Weeds of rich soils")))