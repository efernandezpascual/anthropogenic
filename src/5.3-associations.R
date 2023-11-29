library(tidyverse); library(vegan); library(labdsv)

rm(list = ls())

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") -> species

### DCA of classes 

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Class)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_text(data = cent, aes(label = Cluster))

### Check the two big mixed groups

rm(list = ls())

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(Class %in% c("Epilobietea angustifolii", "Artemisietea vulgaris", "Sisymbrietea", "Chenopodietea") |
           Semisupervised == "Unclassified") %>%
  filter(! Semisupervised %in% c("Epilobion angustifolii", "Senecionion fluviatilis",
                                 "Linario polygalifoliae-Vulpion alopecuri")) -> header

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(Class %in% c("Epilobietea angustifolii") |
           Semisupervised == "Unclassified") %>%
  filter(! Semisupervised %in% c("Epilobion angustifolii", "Senecionion fluviatilis",
                                 "Linario polygalifoliae-Vulpion alopecuri")) -> header

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(Class %in% c("Epilobietea angustifolii") |
           Semisupervised == "Unclassified") %>%
  filter(! Semisupervised %in% c("Epilobion angustifolii", "Senecionion fluviatilis",
                                 "Linario polygalifoliae-Vulpion alopecuri", "Arction lappae",
                                 "Cynancho-Convolvulion sepium")) -> header

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(Class %in% c("Digitario sanguinalis-Eragrostietea minoris", 
                      "Polygono-Poetea annuae", "Sisymbrietea", "Papaveretea rhoeadis")) -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

### DCA of new groups

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Semisupervised, nperm = 9999, p.method = "holm")

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Semisupervised)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_text(data = cent, aes(label = Cluster))

### K-means clasif of Epilobietea

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(Class %in% c("Epilobietea angustifolii")) %>%
  filter(! Semisupervised %in% c("Epilobion angustifolii", "Senecionion fluviatilis")) -> header

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Semisupervised)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% header$SIVIMID) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("normalize") -> # Chord transformation of community data
  dfClassified

vegclust(x = dfClassified, 
         mobileCenters = 5, 
         method = "KM", 
         nstart = 20) -> newclass

defuzzify(newclass)$cluster -> newclasses

### Update header with new groups

newclasses %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2

### Map

rgdal::readOGR(dsn = "data/map", layer = "IberoAtlantic") -> Ecoregions # Map files are in my home drive

header2 %>%
  ggplot(aes(Longitude, Latitude, color = as.factor(Cluster))) +
  facet_wrap(~ Cluster) +
  geom_polygon(data = Ecoregions, aes(x = long, y = lat, group = group), 
               color = "black", fill = "gainsboro", size = 0.25, show.legend = FALSE) +
  geom_point()

### Sintaxa

header2 %>%
  group_by(Cluster, Class) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

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
