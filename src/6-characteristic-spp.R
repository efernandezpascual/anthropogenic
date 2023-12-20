### https://cran.r-project.org/web/packages/indicspecies/vignettes/IndicatorSpeciesAnalysis.html

rm(list = ls())

library(tidyverse); library(indicspecies); library(labdsv)

read.csv("data/header.csv", fileEncoding = "latin1") %>% filter(! Alliance %in% "Noise")-> 
  header

read.csv("data/species.csv", fileEncoding = "latin1") %>% 
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Phidelity (not working in R, extracted with JUICE)

# ### Get groups
# 
# df1 %>% 
#   rownames_to_column(var = "SIVIMID") %>% 
#   merge(header, by = "SIVIMID") %>% 
#   pull(Alliance) -> groups
# 
# ### Transform relevés to presence/absence
# 
# ifelse(df1 > 0, 1, 0) -> df1pa
# 
# ### Phidelity correlation values
# 
# multipatt(df1pa, 
#           groups, 
#           func = "r.g", 
#           control = how(nperm=50)) -> phi
# 
# summary(phi)
# 
# ### Export results
# 
# save(phi, file = "results/characteristic-spp/phidelity.RData")
# 
# load(file = "results/characteristic-spp/phidelity.RData"); summary(phi)

### Indicator spp

# species %>%
#   merge(header, by = "SIVIMID") %>%
#   select(Alliance, SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) -> plots
# 
# plots %>%
#   pull(Alliance) -> groups
# 
# levels(groups) -> group.labels
# 
# plots %>%
#   select(-c(SIVIMID, Alliance)) %>%
#   indval(groups, numitr = 1000000) -> indicators
# 
# save(indicators, file = "results/characteristic-spp/indval.RData")

load(file = "results/characteristic-spp/indval.RData")

header %>%
  filter(!Alliance %in% "Noise") %>%
  select(Alliance) %>%
  unique %>%
  mutate(Community = as.numeric(as.factor(Alliance))) -> communities

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  filter(p_adj < 0.05) %>%
  merge(communities) %>%
  select(-c(Community, p)) %>%
  arrange(Alliance, -Indicator) %>%
  mutate(Type = "Diagnostic",
         Value = Indicator*100) %>%
  select(Species, Alliance, Type, Value) -> diagspp

### Constant

header %>%
  group_by(Alliance) %>%
  tally() -> ns
  
species %>%
  merge(header, by = "SIVIMID") %>%
  group_by(Alliance, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  merge(ns) %>%
  mutate(Frequency = F/n) %>%
  filter(Frequency >= .50) %>%
  group_by(Alliance) %>% tally %>%
  data.frame

species %>%
  merge(header, by = "SIVIMID") %>%
  group_by(Alliance, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  merge(ns) %>%
  mutate(Frequency = F/n) %>%
  filter(Frequency >= .50) %>%
  mutate(Species = Analysis.Names,
         Type = "Constant",
         Value = Frequency*100) %>%
  select(Species, Alliance, Type, Value) -> constspp

### Dominant

header %>%
  group_by(Alliance) %>%
  tally() -> ns

species %>%
  merge(header, by = "SIVIMID") %>%
  filter(Cover.percent > 25) %>%
  group_by(Alliance, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  merge(ns) %>%
  mutate(Frequency = F/n) %>%
  filter(Frequency >= .05) %>%
  group_by(Alliance) %>% tally %>%
  data.frame

species %>%
  merge(header, by = "SIVIMID") %>%
  group_by(Alliance, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  merge(ns) %>%
  mutate(Frequency = F/n) %>%
  filter(Frequency >= .50) %>%
  mutate(Species = Analysis.Names,
         Type = "Dominant",
         Value = Frequency*100) %>%
  select(Species, Alliance, Type, Value) -> domispp

### Merge

read.csv("results/sintaxonomy/original-sintaxonomy.csv", fileEncoding = "latin1") %>%
  select(Alliance, CANTEUNIS) %>%
  na.omit %>% unique -> habitats

rbind(diagspp, domispp, constspp) %>%
  merge(habitats) %>%
  arrange(Alliance, Type, -Value) %>% 
  select(Alliance, CANTEUNIS, Species, Type, Value) %>%
  write.csv("results/characteristic-spp/characteristic-spp.csv", fileEncoding = "latin1", row.names = FALSE)

quit()
n
