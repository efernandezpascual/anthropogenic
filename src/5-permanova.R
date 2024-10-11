### Test significance of classification

rm(list = ls())

library(tidyverse); library(vegan)

# read.csv("data/header.csv", fileEncoding = "latin1") %>% filter(! Alliance %in% "Noise") ->
#   header
# 
# read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species
# 
# species %>%
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") -> df1
# 
# ### Permanova
# 
# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Alliance, nperm = 100000, p.method = "holm") -> pairperma
# adonis2(df1 ~ Alliance, data = df1b, permutations = 9999) -> perma
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Alliance)) -> betadis
# 
# ### Export results
# 
# save(pairperma, file = "results/permanova/pairwise.RData")
# save(perma, file = "results/permanova/permanova.RData")
# save(betadis, file = "results/permanova/beta-dispersion.RData")

load(file = "results/permanova/pairwise.RData"); pairperma
load(file = "results/permanova/permanova.RData"); perma
load(file = "results/permanova/beta-dispersion.RData"); betadis

quit()
n