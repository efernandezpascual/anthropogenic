# https://emf-creaf.github.io/vegclust/articles/VegetationClassification.html

rm(list = ls())

library(tidyverse); library(vegclust); library(vegan); library(labdsv)

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  # filter(! is.na(L1))
  filter(Fixed == 1) -> 
  headerClassified

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  # filter(is.na(L1)) ->
  filter(Fixed == 0) -> 
  headerUnclassified

### Prepare community composition matrices

read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerClassified$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassified

read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerUnclassified$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfUnclassified

### Get vector with classification of classified vegetation

dfClassified %>%
  rownames_to_column(var = "SIVIMID") %>%
  merge(headerClassified) %>%
  select(SIVIMID, L1) %>%
  column_to_rownames(var = "SIVIMID") %>%
  pull(L1) -> 
  groups

### Create vegetation object of classified veg with composition and classification

as.vegclust(dfClassified, groups, method = "HNC", dnoise = 1) ->
  vegClassified # With noise, higher values less noisy plots

### Conform the two composition matrices into single species set

conformveg(dfClassified, dfUnclassified) -> cf
cf$x -> cfClassified
cf$y -> cfUnclassified

### Re-calculate centroids of classified vegetation

clustcentroid(cfClassified, groups) -> fixed

### Refine classification with noise

vegclust(rbind(cfClassified, cfUnclassified),
         mobileCenters = 1,
         fixedCenters = fixed,
         method = vegClassified$method,
         dnoise = vegClassified$dnoise,
         nstart = 20) ->
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

# ### Refine classification withou noise
# 
# vegclust(rbind(cfClassified, cfUnclassified),
#          mobileCenters = 1,
#          fixedCenters = fixed,
#          method = "KM",
#          nstart = 20) ->
#   vegExtended
# 
# defuzzify(vegExtended)$cluster -> newclasses

### Update header with new groups

newclasses %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2

### Sintaxa in new groups

header2 %>%
  group_by(Alliance, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

header2 %>%
  group_by(L1, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

header2 %>%
  group_by(Original, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

header2 %>%
  group_by(Cluster) %>%
  tally %>% 
  print(n = 100)

### DCA of new groups

read.csv("data/species.csv", fileEncoding = "latin1") -> species

species %>%
  merge(header2) %>%
  filter(Cluster != "N") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T) +
  geom_text(data = cent, aes(label = Cluster))

### Map

rgdal::readOGR(dsn = "data/map", layer = "IberoAtlantic") -> Ecoregions # Map files are in my home drive

header2 %>%
  ggplot(aes(Longitude, Latitude, color = as.factor(Cluster))) +
  facet_wrap(~ Cluster) +
  geom_polygon(data = Ecoregions, aes(x = long, y = lat, group = group), 
               color = "black", fill = "gainsboro", size = 0.25, show.legend = FALSE) +
  geom_point()

### Dominant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

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

### M

header2 %>% filter(Cluster == "M1") -> headerM1

headerM1 %>%
  group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% headerM1$SIVIMID) -> speciesM1

speciesM1 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan 

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 3,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

headerM1 %>% select(-Cluster) %>% merge(kclusters, by = "SIVIMID") -> header4

### DCA

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header4) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

### Sintaxa

header4 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Dominant

speciesM1 %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

speciesM1 %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

speciesM1 %>%
  merge(header4, by = "SIVIMID") %>%
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

header4 %>% filter(Cluster == 1) %>% pull(SIVIMID) -> potentillion

### Supervised classification of M into existing groups

header2 %>%
  filter(! Cluster %in% c("M1", "N")) -> 
  headerClassifiedM

header2 %>%
  filter(Cluster %in% c("M1")) %>%
  filter(! SIVIMID %in% potentillion) -> # Cluster 1 of M1 belong to Potentillion anserinae
  headerUnclassifiedM

read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerClassifiedM$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassifiedM

read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerUnclassifiedM$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfUnclassifiedM

dfClassifiedM %>%
  rownames_to_column(var = "SIVIMID") %>%
  merge(headerClassifiedM) %>%
  select(SIVIMID, Cluster) %>%
  column_to_rownames(var = "SIVIMID") %>%
  pull(Cluster) -> 
  groups

as.vegclust(dfClassifiedM, groups) ->
  vegClassifiedM

vegclass(vegClassifiedM, dfUnclassifiedM) -> classifM

defuzzify(classifM)$cluster -> newclassesM

newclassesM %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2b

### Merge headers

header2 %>%
  filter(!(Cluster == "M1" & ! SIVIMID %in% potentillion)) %>%
  rbind(header2b) -> header3

header3 %>% group_by(SIVIMID)
header3 %>% group_by(Cluster)

### Sintaxa in new groups

header3 %>%
  group_by(Alliance, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

header3 %>%
  group_by(L1, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

header3 %>%
  group_by(Sintaxon, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

### DCA of new groups

read.csv("data/species.csv", fileEncoding = "latin1") -> species

species %>%
  merge(header3) %>%
  filter(Cluster != "N") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header3) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T) +
  geom_text(data = cent, aes(label = Cluster))

### Map

rgdal::readOGR(dsn = "data/map", layer = "IberoAtlantic") -> Ecoregions # Map files are in my home drive

header3 %>%
  ggplot(aes(Longitude, Latitude, color = as.factor(Cluster))) +
  facet_wrap(~ Cluster) +
  geom_polygon(data = Ecoregions, aes(x = long, y = lat, group = group), 
               color = "black", fill = "gainsboro", size = 0.25, show.legend = FALSE) +
  geom_point()

### Dominant

species %>%
  merge(header3, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header3, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

species %>%
  merge(header3, by = "SIVIMID") %>%
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

### Update groups names

read.csv("results/sintaxonomy/original-sintaxonomy.csv", fileEncoding = "latin1") %>%
  select(Alliance, Order, Class, CANTEUNIS) %>%
  unique %>% 
  rename(Semisupervised = Alliance) -> alliances

header3 %>% filter(Cluster == "N") %>% group_by(Original) %>% tally %>% arrange(-n) %>%
  merge(header3 %>% filter(Cluster != "N") %>% group_by(Original) %>% tally %>% arrange(-n), 
        by = "Original", all.x = TRUE) %>%
  mutate(n.y = ifelse(is.na(n.y), 0, n.y)) %>%
  mutate(ratio = n.x/(n.x +n.y)) %>%
  filter(n.x >9) %>%
  arrange(-ratio, -n.x)

header3 %>% 
  mutate(Longitude = ifelse(Accuracy == "5 - UTMs missing from DEM", NA, Longitude)) %>%
  mutate(Latitude = ifelse(Accuracy == "5 - UTMs missing from DEM", NA, Latitude)) %>%
  mutate(Semisupervised = fct_recode(Cluster,
                         "Cymbalario-Asplenion" = "F10",
                         "Cynancho-Convolvulion sepium" = "F11",
                         "Dauco-Melilotion" = "F12",
                         "Echio-Galactition tomentosae" = "F13",
                         "Epilobion angustifolii" = "F14",
                         "Galio valantiae-Parietarion judaicae" = "F15",
                         "Geo urbani-Alliarion officinalis" = "F16",
                         "Geranio pusilli-Anthriscion caucalidis" = "F17",
                         "Linario polygalifoliae-Vulpion alopecuri" = "F18",
                         "Oxalidion europeae" = "F19",
                         "Allion triquetri" = "F2",
                         "Paspalo-Agrostion semiverticillati" = "F20",
                         "Polycarpion tetraphylli" = "F21",
                         "Polygono-Coronopodion" = "F22",
                         "Saginion procumbentis" = "F23",
                         "Scleranthion annui" = "F24",
                         "Senecionion fluviatilis" = "F25",
                         "Silybo mariani-Urticion piluliferae" = "F26",
                         "Sisymbrion officinalis" = "F27",
                         "Spergulo arvensis-Erodion cicutariae" = "F28",
                         "Arction lappae" = "F3",
                         "Balloto-Conion maculati" = "F4",
                         "Bidention tripartitae" = "F5",
                         "Carduo carpetani-Cirsion odontolepidis" = "F6",
                         "Chenopodion muralis" = "F7",
                         "Cirsion richterano-chodati" = "F8",
                         "Convolvulo arvensis-Agropyrion repentis" = "F9",
                         "Noise" = "M1",
                         "Noise" = "N")) %>%  
  rename(Twinspan = L1) %>%
  select(-c(Cluster, Alliance, Class, Order, Fixed)) %>% 
  merge(alliances, by = "Semisupervised", all.x = TRUE) %>%
  select(SIVIMID, CANTEUNIS, Original, Twinspan, Semisupervised, Order, Class,
         Area, Year, Longitude, Latitude, Accuracy, Elevation) %>%
  write.csv("data/urban-header-5.2.csv", fileEncoding = "latin1", row.names = FALSE)

### Prepare files for manuscript stage

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  rename(Alliance = Semisupervised) %>%
  select(-c(Twinspan)) -> header
  
read.csv("data/species.csv", fileEncoding = "latin1") %>%
  mutate(Analysis.Names = ifelse(Analysis.Names == "Polygonum calcatum", "Polygonum arenastrum", Analysis.Names)) %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

header %>% group_by(SIVIMID) %>% filter(!SIVIMID %in% species$SIVIMID)
species %>% group_by(SIVIMID) %>% filter(!SIVIMID %in% header$SIVIMID)
  
header %>% group_by(Alliance)
header %>% filter(Alliance == "Noise") %>% group_by(SIVIMID)
header %>% filter(Alliance != "Noise") %>% group_by(SIVIMID)

# openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 1) %>%
#   rename(Original = Sintaxon) %>%
#   select(Original, Alliance) %>%
#   arrange(Original) -> original

# openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 2) %>% 
#   merge(original, all = TRUE) %>%
#   rename(Anthropogenic = Manmade) %>%
#   select(Vegetation, Class, Order, Alliance, Original, Anthropogenic, Assigned, EUNIS, CANTEUNIS) %>%
#   arrange(Vegetation, Class, Order, Alliance) %>%
#   write.csv("results/sintaxonomy/original-sintaxonomy.csv", fileEncoding = "latin1", row.names = FALSE)

# openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 3) %>%
#   write.csv("results/sintaxonomy/associations.csv", fileEncoding = "latin1", row.names = FALSE)


write.csv(header, "data/header.csv", fileEncoding = "latin1", row.names = FALSE)
write.csv(species, "data/species.csv", fileEncoding = "latin1", row.names = FALSE)
