library(tidyverse); library(vegan)

read.csv("data/urban-header.csv", fileEncoding = "latin1") -> header

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### 1st twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 3) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>%
  merge(kclusters, by = "SIVIMID") -> header2

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### 1st level classification into ruderal, weeds, trampled

header2 %>%
  mutate(EUNISL1 = fct_recode(as.factor(Cluster), "Ruderal" = "1", "Weed" = "2", "Trampled" = "3")) %>%
  select(-Cluster) -> header3

### 2nd twinspand - ruderals

header3 %>%
  filter(EUNISL1 == "Ruderal") %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 3) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header3 %>%
  merge(kclusters, by = "SIVIMID") -> header2

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  mutate(EUNISL2 = fct_recode(as.factor(Cluster), "V39" = "1", "V37" = "2", "V38" = "3")) %>%
  select(-Cluster) -> header3A

### 2nd twinspand - weeds

header3 %>%
  filter(EUNISL1 == "Weed") %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 3) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header3 %>%
  merge(kclusters, by = "SIVIMID") -> header2

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  mutate(EUNISL2 = fct_recode(as.factor(Cluster), "V15A" = "1", "V15B" = "2", "V15C" = "3")) %>%
  select(-Cluster) -> header3B

### 2nd twinspand - trampled

header3 %>%
  filter(EUNISL1 == "Trampled") %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header3 %>%
  merge(kclusters, by = "SIVIMID") -> header2

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  mutate(EUNISL2 = fct_recode(as.factor(Cluster), "V35" = "1", "V34" = "2")) %>%
  select(-Cluster) -> header3C

### Walls - separate from classification

read.csv("data/urban-header.csv", fileEncoding = "latin1") %>% 
  filter(Class == "Cymbalario-Parietarietea diffusae") %>%
  mutate(EUNISL1 = "Walls") %>%
  merge(read.csv("data/urban-species.csv", fileEncoding = "latin1"), by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 2) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

read.csv("data/urban-header.csv", fileEncoding = "latin1") %>% 
  filter(Class == "Cymbalario-Parietarietea diffusae") %>%
  mutate(EUNISL1 = "Walls")  %>%
  merge(kclusters, by = "SIVIMID") -> header2

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  mutate(EUNISL2 = "U37") %>%
  select(-Cluster) -> header3D

### Merge

rbind(header3A, header3B, header3C, header3D) -> header4
read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% header4$SIVIMID) -> species4

read.csv("data/urban-header.csv", fileEncoding = "latin1") -> header4
read.csv("data/urban-species.csv", fileEncoding = "latin1") -> species4

### Map

rgdal::readOGR(dsn = "../splot12db/data/maps/WWF", 
               layer = "wwf_terr_ecos") -> Ecoregions # Map files are in my home drive
rownames(Ecoregions@data) -> Ecoregions@data$id
fortify(Ecoregions, region = "id") -> Ecoregions.points 
plyr::join(Ecoregions.points, Ecoregions@data, by = "id") %>%
  filter(BIOME %in% c(4)) ->
  biomes

plyr::join(Ecoregions.points, Ecoregions@data, by = "id") -> land

biomes %>%
  ggplot(aes(x = long, y = lat)) + 
  # geom_hline(yintercept = 23.43644, linetype = "dotted", size = .1) +
  # geom_hline(yintercept = -23.43644, linetype = "dotted", size = .1) +
  geom_polygon(data = land, aes(x = long, y = lat, group = group), 
               color = NA, fill = "gainsboro") +
  geom_polygon(aes(x = long, y = lat, group = group), fill = NA, color = "limegreen", size = 2) +
  geom_point(data = header4, aes(DEG_LON, DEG_LAT, color = EUNISL2), size = 1) +
  ggthemes::theme_tufte() +
  coord_fixed(xlim= c(-10, 1), ylim = c(40, 45)) +
  theme(legend.position = "bottom",
        legend.title = element_blank(), 
        legend.direction = "horizontal",
        legend.text=element_text(size = 10),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) -> map; map

### NMDS

header4 %>%
  merge(species4, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 1000, k = 2) ->
  nmds # Ordination output

scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header4, by = "SIVIMID") -> header4NMDS

# write.csv(header4NMDS, "data/urban-header-nmds.csv", fileEncoding = "latin1", row.names = FALSE)
  
header4NMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(EUNISL2)), show.legend = T)
