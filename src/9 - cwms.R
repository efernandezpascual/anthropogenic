rm(list = ls())

library(tidyverse)

# ### Reciprocal averaging
# 
# read.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1") %>%
#   select(Analysis.Names,
#          EIVE1.M:Soil.Disturbance) %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   na.omit %>%
#   merge(read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1")) %>%
#   group_by(SIVIMID, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) -> plotmeans
# 
# read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") %>%
#   merge(plotmeans) %>%
#   group_by(Analysis.Names, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) %>% 
#   rename(ravalue = Value) -> sppmeans
# 
# read.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1") %>%
#   select(Analysis.Names,
#          EIVE1.M:Soil.Disturbance) %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   merge(sppmeans, all.x = TRUE) %>%
#   mutate(value = ifelse(is.na(Value), ravalue, Value)) %>%
#   select(-c(Value, ravalue)) %>%
#   spread(Trait, value) -> raspp
# 
# read.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1") %>%
#   select(-c(EIVE1.M:Soil.Disturbance, repetido)) %>%
#   merge(raspp) -> traits
# 
# ### CwMs
# 
# traits %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   merge(read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1")) %>%
#   group_by(SIVIMID, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) %>%
#   spread(Trait, Value) %>%
#   merge(read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1")) -> cwms
# 
# save(cwms, file = "results/cwms/cwms.RData")

load(file = "results/cwms/cwms.RData")
  
### PCA

cwms %>%
  filter(Semisupervised != "Noise") %>%
  select(SIVIMID, alien:therophyte, Elevation) %>%
  column_to_rownames(var = "SIVIMID") %>%
  FactoMineR::PCA(graph = FALSE) -> pca1

pca1$var

pca1$ind$coord %>%
  data.frame %>%
  rownames_to_column(var = "SIVIMID") %>%
  merge(cwms) -> cwm2

pca1$var$coord %>%
  data.frame %>%
  rownames_to_column(var = "Variable") -> vars

cent <- aggregate(cbind(Dim.1, Dim.2) ~ Semisupervised, data = cwm2, FUN = mean)
segs <- merge(cwm2, setNames(cent, c("Semisupervised", "oDCA1", "oDCA2")), by = "Semisupervised", sort = FALSE)

ggplot(cwm2, aes(Dim.1, Dim.2)) +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Semisupervised), show.legend = F) +
  geom_text(data = cent, aes(label = Semisupervised)) -> Fig; Fig

ggsave(Fig, file = "results/CWMs.png", bg = "white", 
       path = NULL, scale = 1, width = 200, height = 200, units = "mm", dpi = 600)
