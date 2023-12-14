### https://cran.r-project.org/web/packages/indicspecies/vignettes/IndicatorSpeciesAnalysis.html

rm(list = ls())

library(tidyverse); library(indicspecies); library(labdsv)

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>% 
  filter(Semisupervised %in% c("Balloto-Conion maculati", "Arction lappae")) %>% group_by(Semisupervised) %>% sample_n(10) -> 
  header

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Indicator spp

species %>%
  merge(header, by = "SIVIMID") %>%
  select(Semisupervised, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Semisupervised) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Semisupervised)) %>%
  indval(groups, numitr = 1000000) -> indicators

save(indicators, file = "results/characteristic-spp/indval.RData")

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

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
          control = how(nperm=50)) -> phi

summary(phi)

### Export results

save(phi, file = "results/characteristic-spp/phidelity.RData")

load(file = "results/characteristic-spp/phidelity.RData"); summary(phi)

quit()
n
