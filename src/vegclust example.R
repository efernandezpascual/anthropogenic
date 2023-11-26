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