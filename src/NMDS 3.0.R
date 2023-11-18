library(tidyverse); library(vegan)

read.csv("data/urban-header-3.0.csv", fileEncoding = "latin1") %>%
  filter(Semisupervised == 1) -> header

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### NMDS

header %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 1000, k = 2) ->
  nmds # Ordination output

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header, by = "SIVIMID") -> headerNMDS

headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Revised.alliance)), show.legend = T)
