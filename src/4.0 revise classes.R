library(tidyverse); library(vegan)

rm(list = ls())

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 6) %>%
  select(Alliance, Class) %>% 
  rename(Revised.alliance = Alliance) %>%
  unique -> classes

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 4) %>%
  select(Alliance, Sintaxon) %>% 
  unique -> sintaxa

rbind(read.csv("data/urban-header-3.1A.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1B1.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1B2.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1B3.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1C.csv", fileEncoding = "latin1"),
      read.csv("data/urban-header-3.1D1.csv", fileEncoding = "latin1"),
      read.csv("data/urban-header-3.1D2.csv", fileEncoding = "latin1"),
      read.csv("data/urban-header-3.1E.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1F.csv", fileEncoding = "latin1"), 
      read.csv("data/urban-header-3.1G.csv", fileEncoding = "latin1")) %>%
  select(-c(X.1, X)) %>%
  select(-Class) %>%
  select(-Alliance) %>%
  select(-Semisupervised) %>%
  rename(Cluster1 = Revised.class) %>%
  merge(classes, all.x = TRUE) %>%
  merge(sintaxa, all.x = TRUE) %>%
  mutate(Alliance = ifelse(is.na(Alliance), "Unknown", Alliance)) %>%
  mutate(Semisupervised = ifelse(Revised.alliance == Alliance, 1, 0)) %>% 
  select(SIVIMID:Elevation, Sintaxon, Alliance, Revised.alliance, Class, Cluster1, Semisupervised) %>%
  rename(Alliance.original = Alliance,
         Alliance.revised = Revised.alliance,
         Class.Mucina = Class,
         Class.Twinspan = Cluster1) -> 
  header

# write.csv(header, "data/urban-header-4.0.csv", fileEncoding = "latin1", row.names = FALSE)

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Permanova

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Alliance.revised, nperm = 9999, p.method = "holm")
adonis2(df1 ~ Alliance.revised, data = df1b, permutations = 9999)
anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Alliance.revised))

### NMDS

library(vegan)

header %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 10000, k = 2) ->
  nmds # Ordination output

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header, by = "SIVIMID") -> headerNMDS

write.csv(headerNMDS, "results/4.0-nmds.csv", fileEncoding = "latin1", row.names = FALSE)
save(nmds, file = "results/4NMDS.RData")

headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Cluster)), show.legend = T)

### Sintaxa

header %>%
  group_by(Alliance.revised, Alliance.original) %>%
  tally %>%
  arrange(Alliance.revised, -n) %>%
  data.frame

header %>%
  group_by(Class.Twinspan, Class.Mucina) %>%
  tally %>%
  arrange(Class.Twinspan, -n) %>%
  data.frame

### DCA

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Alliance.revised)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Alliance.revised, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Alliance.revised), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots") +
  geom_text(data = cent, aes(label = Alliance.revised), color = "black") -> F1; F1

ggsave(F1, file = "results/DCA alliances 1.png", 
       path = NULL, scale = 1, width = 300, height = 200, units = "mm", dpi = 600)

### DCA

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Class.Twinspan)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Class.Twinspan, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Class.Twinspan), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots") +
  geom_text(data = cent, aes(label = Class.Twinspan), color = "black") -> F1; F1

ggsave(F1, file = "results/DCA classes 1.png", 
       path = NULL, scale = 1, width = 300, height = 200, units = "mm", dpi = 600)

### DCA

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Class.Mucina)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Class.Mucina, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Class.Mucina), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots Mucina classes") +
  geom_text(data = cent, aes(label = Class.Mucina), color = "black") -> F1; F1

ggsave(F1, file = "results/DCA classes 3.png", 
       path = NULL, scale = 1, width = 300, height = 200, units = "mm", dpi = 600)

### Only original agreement

header %>%
  filter(Semisupervised == 1) %>%
  filter(SIVIMID %in% species$SIVIMID) -> header

species %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### DCA

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Alliance.revised)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Alliance.revised, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Alliance.revised), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "Original classif") +
  geom_text(data = cent, aes(label = Alliance.revised), color = "black") -> F1; F1

ggsave(F1, file = "results/DCA alliances 2.png", 
       path = NULL, scale = 1, width = 300, height = 200, units = "mm", dpi = 600)

### DCA

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Class.Twinspan)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Class.Twinspan, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Class.Twinspan), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "Original classif") +
  geom_text(data = cent, aes(label = Class.Twinspan), color = "black") -> F1; F1

ggsave(F1, file = "results/DCA classes 2.png", 
       path = NULL, scale = 1, width = 300, height = 200, units = "mm", dpi = 600)