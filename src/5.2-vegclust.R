# https://emf-creaf.github.io/vegclust/articles/VegetationClassification.html

rm(list = ls())

library(tidyverse); library(vegclust); library(vegan); library(labdsv)

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  filter(! is.na(L1)) -> 
  headerClassified

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  filter(is.na(L1)) -> 
  headerUnclassified

### Prepare community composition matrices

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% headerClassified$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassified

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% 
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
         nstart = 10) -> 
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

### Update header with new groups

newclasses %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2

### Sintaxa in new groups

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

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") -> species

species %>%
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

### Update groups names

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 2) %>%
  filter(Manmade == "Yes") %>%
  filter(Assigned != "Not Cantabrian") %>%
  select(Alliance, Order, Class, CANTEUNIS) %>%
  unique %>% 
  rename(Semisupervised = Alliance) -> alliances

header2 %>%
  mutate(Semisupervised = fct_recode(Cluster,
                         "Dauco-Melilotion" = "F10",
                         "Epilobion angustifolii" = "F11",
                         "Galio valantiae-Parietarion judaicae" = "F12",
                         "Geranio pusilli-Anthriscion caucalidis" = "F13",
                         "Linario polygalifoliae-Vulpion alopecuri" = "F14",
                         "Oxalidion europeae" = "F15",
                         "Paspalo-Agrostion semiverticillati" = "F16",
                         "Polycarpion tetraphylli" = "F17",
                         "Polygono-Coronopodion" = "F18",
                         "Saginion procumbentis" = "F19",
                         "Aegopodion podagrariae" = "F2",
                         "Scleranthion annui" = "F20",
                         "Senecionion fluviatilis" = "F21",
                         "Sisymbrion officinalis" = "F22",
                         "Allion triquetri" = "F23",
                         "Spergulo arvensis-Erodion cicutariae" = "F24",
                         "Geo urbani-Alliarion officinalis" = "F3",
                         "Arction lappae" = "F4",
                         "Balloto-Conion maculati" = "F5",
                         "Bidention tripartitae" = "F6",
                         "Cirsion richterano-chodati" = "F7",
                         "Cymbalario-Asplenion" = "F8",
                         "Cynancho-Convolvulion sepium" = "F9",
                         "Balloto-Conion maculati" = "M1", # Not disinguishable from F5
                         "Noise" = "N")) %>% 
  rename(Twinspan = L1,
         ESEUNIS = EUNIS) %>%
  select(-c(Cluster, L0, Alliance, Class)) %>%
  merge(alliances, by = "Semisupervised", all.x = TRUE) %>%
  select(SIVIMID, CANTEUNIS, ESEUNIS, Sintaxon, Twinspan, Semisupervised, Order, Class,
         Area, Year, Longitude, Latitude, Accuracy, Elevation, Aspect, Slope) %>%
  write.csv("data/urban-header-5.2.csv", fileEncoding = "latin1")
