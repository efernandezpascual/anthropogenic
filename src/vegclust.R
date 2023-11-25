# https://emf-creaf.github.io/vegclust/articles/VegetationClassification.html

rm(list = ls())

library(tidyverse); library(vegclust); library(vegan)

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  filter(L0 == "Artemisietea vulgaris") -> 
  headerClassified

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>% 
  filter(is.na(L0)) %>%
  sample_n(20) -> 
  headerUnclassified

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

as.vegclust(dfClassified, groups) ->
  vegClassified

as.vegclust(dfClassified, groups, method = "HNC", dnoise = 0.8) ->
  vegClassified # With noise, double check

### Clasify unclassified (no new groups)

vegclass(vegClassified, dfUnclassified) ->
  vegUnclassified

defuzzify(vegUnclassified)$cluster

### Conform the two composition matrices into single species set

conformveg(dfClassified, dfUnclassified) -> cf
cf$x -> cfClassified
cf$y -> cfUnclassified

### Re-calculate centroids of classified vegetation

clustcentroid(cfClassified, groups) -> fixed

### Extend classification with noise clustering method

vegclust(cfUnclassified, 
         mobileCenters = 1,
         fixedCenters = fixed,
         method = vegClassified$method,
         dnoise = vegClassified$dnoise,
         nstart = 10) -> 
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

newclasses %>% as.data.frame() %>% rename(Cluster = ".") %>% group_by(Cluster) %>% tally

### Extend classification without noise

vegclust(cfUnclassified, 
         mobileCenters = 1,
         fixedCenters = fixed,
         method = "KM",
         nstart = 10) -> 
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

newclasses %>% as.data.frame() %>% rename(Cluster = ".") %>% group_by(Cluster) %>% tally

### Refine classification with noise

vegclust(rbind(cfClassified, cfUnclassified), 
         mobileCenters = 1,
         fixedCenters = fixed,
         method = vegClassified$method,
         dnoise = vegClassified$dnoise,
         nstart = 10) -> 
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

newclasses %>% as.data.frame() %>% rename(Cluster = ".") %>% group_by(Cluster) %>% tally

newclasses %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2

header2 %>%
  group_by(L1, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

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

### Refine classification no noise

vegclust(rbind(cfClassified, cfUnclassified), 
         mobileCenters = 1,
         fixedCenters = fixed,
         method = "KM",
         nstart = 10) -> 
  vegExtended

defuzzify(vegExtended)$cluster -> newclasses

newclasses %>% 
  as.data.frame() %>% 
  rename(Cluster = ".") %>% 
  rownames_to_column(var = "SIVIMID") %>%
  merge(read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1"), by = "SIVIMID") -> header2

header2 %>%
  group_by(L1, Cluster) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  print(n = 500)

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

