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


save(nmds, file = "results/NMDS3.0.RData")

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header, by = "SIVIMID") -> headerNMDS

write.csv(headerNMDS, "results/NMDS3.0.RData.csv")

headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Revised.alliance)), show.legend = T)

headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Revised.alliance)), show.legend = T) +
  coord_cartesian(xlim = c(-.5, .5))

headerNMDS %>% filter(NMDS1 < -0.05)

headerNMDS %>% filter(NMDS1 < -0.1) %>% select(SIVIMID) %>% merge(species) %>%
  arrange(SIVIMID, -Cover.percent)

headerNMDS %>% filter(NMDS1 > 0.05)

headerNMDS %>% filter(NMDS1 > 0.5) %>% select(SIVIMID) %>% merge(species) %>%
  arrange(SIVIMID, -Cover.percent)

headerNMDS %>% filter(NMDS2 < -0.05)
headerNMDS %>% filter(NMDS2 > 0.05)

headerNMDS %>%
  group_by(Revised.alliance) %>%
  summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_text(aes(label = Revised.alliance, color = as.factor(Revised.alliance)), show.legend = T) 
