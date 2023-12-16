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

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerClassified$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassified

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>% 
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
  group_by(Sintaxon, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

### DCA of new groups

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") -> species

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

### Supervised classification of M into existing groups

header2 %>%
  filter(! Cluster %in% c("M1", "N")) -> 
  headerClassifiedM

header2 %>%
  filter(Cluster %in% c("M1")) -> 
  headerUnclassifiedM

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerClassifiedM$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassifiedM

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>% 
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
  filter(Cluster != "M1") %>%
  rbind(header2b) -> header3

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

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") -> species

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

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 2) %>%
  filter(Manmade == "Yes") %>%
  filter(Assigned != "Not Cantabrian") %>%
  select(Alliance, Order, Class, CANTEUNIS) %>%
  unique %>% 
  rename(Semisupervised = Alliance) -> alliances

header3 %>% filter(Cluster == "N") %>% group_by(Sintaxon) %>% tally %>% arrange(-n) %>%
  merge(header3 %>% filter(Cluster != "N") %>% group_by(Sintaxon) %>% tally %>% arrange(-n), 
        by = "Sintaxon", all.x = TRUE) %>%
  mutate(n.y = ifelse(is.na(n.y), 0, n.y)) %>%
  mutate(ratio = n.x/(n.x +n.y)) %>%
  filter(n.x >9) %>%
  arrange(-ratio, -n.x)

header3 %>% 
  mutate(Longitude = ifelse(Accuracy == "5 - UTMs missing from DEM", NA, Longitude)) %>%
  mutate(Latitude = ifelse(Accuracy == "5 - UTMs missing from DEM", NA, Latitude)) %>%
  mutate(Semisupervised = fct_recode(Cluster,
                         "Cynancho-Convolvulion sepium" = "F10",
                         "Dauco-Melilotion" = "F11",
                         "Echio-Galactition tomentosae" = "F12",
                         "Epilobion angustifolii" = "F13",
                         "Galio valantiae-Parietarion judaicae" = "F14",
                         "Geo urbani-Alliarion officinalis" = "F15",
                         "Geranio pusilli-Anthriscion caucalidis" = "F16",
                         "Linario polygalifoliae-Vulpion alopecuri" = "F17",
                         "Oxalidion europeae" = "F18",
                         "Paspalo-Agrostion semiverticillati" = "F19",
                         "Aegopodion podagrariae" = "F2",
                         "Polycarpion tetraphylli" = "F20",
                         "Polygono-Coronopodion" = "F21",
                         "Saginion procumbentis" = "F22",
                         "Scleranthion annui" = "F23",
                         "Senecionion fluviatilis" = "F24",
                         "Sisymbrion officinalis" = "F25",
                         "Spergulo arvensis-Erodion cicutariae" = "F26",
                         "Allion triquetri" = "F3",
                         "Arction lappae" = "F4",
                         "Balloto-Conion maculati" = "F5",
                         "Bidention tripartitae" = "F6",
                         "Carduo carpetani-Cirsion odontolepidis" = "F7",
                         "Cirsion richterano-chodati" = "F8",
                         "Cymbalario-Asplenion" = "F9",
                         #"Unclassified" = "M1",
                         "Noise" = "N")) %>% 
  rename(Twinspan = L1,
         ESEUNIS = EUNIS) %>%
  select(-c(Cluster, L0, Alliance, Class)) %>%
  merge(alliances, by = "Semisupervised", all.x = TRUE) %>%
  select(SIVIMID, CANTEUNIS, ESEUNIS, Sintaxon, Twinspan, Semisupervised, Order, Class,
         Area, Year, Longitude, Latitude, Accuracy, Elevation, Aspect, Slope) %>%
  write.csv("data/urban-header-5.2.csv", fileEncoding = "latin1", row.names = FALSE)

### Prepare files for manuscript stage

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  rename(Original = Sintaxon,
         Alliance = Semisupervised) %>%
  select(-c(ESEUNIS, Twinspan, Aspect, Slope)) -> header
  
read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

header %>% group_by(SIVIMID) %>% filter(!SIVIMID %in% species$SIVIMID)
species %>% group_by(SIVIMID) %>% filter(!SIVIMID %in% header$SIVIMID)
  
openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 1) %>%
  rename(Original = Sintaxon) %>%
  select(Original, Alliance) %>%
  arrange(Original) -> original

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 2) %>% 
  merge(original, all = TRUE) %>%
  rename(Anthropogenic = Manmade) %>%
  select(Vegetation, Class, Order, Alliance, Original, Anthropogenic, Assigned, EUNIS, CANTEUNIS) %>%
  arrange(Vegetation, Class, Order, Alliance) %>%
  write.csv("results/sintaxonomy/original-sintaxonomy.csv", fileEncoding = "latin1", row.names = FALSE)

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 3) %>%
  write.csv("results/sintaxonomy/associations.csv", fileEncoding = "latin1", row.names = FALSE)


write.csv(header, "data/header.csv", fileEncoding = "latin1", row.names = FALSE)
write.csv(species, "data/species.csv", fileEncoding = "latin1", row.names = FALSE)
