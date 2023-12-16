### Test significance of classification

rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

### DCA of new groups

species %>%
  merge(header) %>%
  filter(Semisupervised != "Noise") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = F) +
  geom_text(data = cent, aes(label = Cluster)) -> Fig; Fig

ggsave(Fig, file = "results/DCA2.png", bg = "white", 
       path = NULL, scale = 1, width = 200, height = 200, units = "mm", dpi = 600)

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
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = F) +
  geom_text(data = cent, aes(label = Cluster)) -> Fig; Fig

ggsave(Fig, file = "results/DCA1.png", bg = "white", 
       path = NULL, scale = 1, width = 200, height = 200, units = "mm", dpi = 600)