### Test significance of classification

rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Permanova

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Semisupervised, nperm = 9999, p.method = "holm") -> pairperma
adonis2(df1 ~ Semisupervised, data = df1b, permutations = 9999) -> perma
anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Semisupervised)) -> betadis

### Export results

save(pairperma, file = "results/permanova/pairwise.RData")
save(perma, file = "results/permanova/permanova.RData")
save(betadis, file = "results/permanova/beta-dispersion.RData")

load(file = "results/permanova/pairwise.RData"); pairperma
load(file = "results/permanova/permanova.RData"); perma
load(file = "results/permanova/beta-dispersion.RData"); betadis

### https://cran.r-project.org/web/packages/indicspecies/vignettes/IndicatorSpeciesAnalysis.html

rm(list = ls())

library(tidyverse); library(indicspecies)

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Get groups

df1 %>% 
  rownames_to_column(var = "SIVIMID") %>% 
  merge(header, by = "SIVIMID") %>% 
  pull(Semisupervised) -> groups

### Transform relevés to presence/absence

ifelse(df1 > 0, 1, 0) -> df1pa

### Phidelity correlation values

multipatt(df1pa, 
          groups, 
          func = "r.g", 
          control = how(nperm=999)) -> phi

summary(phi)

### Export results

save(phi, file = "results/characteristic-spp/phidelity.RData")

load(file = "results/characteristic-spp/phidelity.RData"); summary(phi)

quit()
n