library(tidyverse); library(vegan); library(NbClust)

rm(list = ls())

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>%
  filter(L1 == "Artemisietea vulgaris") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

# ### NBClust
# 
# NbClust(data = df1, 
#         diss = NULL, 
#         distance = "canberra", 
#         min.nc = 7, 
#         max.nc = 12, 
#         method = "centroid", 
#         index = "all", 
#         alphaBeale = 0.1)

### Twinspan

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 4,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>% ## Lower merges Pap + Polu, higher divides Arte
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters


header %>%
  merge(kclusters, by = "SIVIMID") -> header2

### DCA

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header2) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header2, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
# pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### Sintaxa

header2 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Dominant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header2, by = "SIVIMID") %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

# ### Revised sintaxonomy
# 
# header2 %>%
#   filter(Cluster != 1) %>%
#   mutate(L2 = fct_recode(as.factor(Cluster),
#                          "Arction lappae" = "2",
#                          "Smyrnienion olusatri" = "3",
#                          "Senecionion fluviatilis" = "4",
#                          "Epilobion angustifolii" = "5",
#                          "Sisymbrion officinalis" = "6")) %>%
#   select(-Cluster) %>%
#   write.csv("data/urban-header-5.1A1.csv", fileEncoding = "latin1")


#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

header2 %>%
  filter(Cluster == 4) %>%
  select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

# ### NBClust
# 
# NbClust(data = df1, 
#         diss = NULL, 
#         distance = "canberra", 
#         min.nc = 7, 
#         max.nc = 12, 
#         method = "centroid", 
#         index = "all", 
#         alphaBeale = 0.1)

### Twinspan

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 2,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>% ## Lower merges Pap + Polu, higher divides Arte
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header3 %>%
  merge(kclusters, by = "SIVIMID") -> header4

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header4, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
#RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### DCA

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header4) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

### Sintaxa

header4 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Dominant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header4, by = "SIVIMID") %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

### Revised sintaxonomy

header4 %>%
  mutate(L2 = fct_recode(as.factor(Cluster),
                         "Smyrnienion olusatri" = "1",
                         "Senecionion fluviatilis" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1A1.csv", fileEncoding = "latin1")


#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

header2 %>%
  filter(Cluster != 4) %>%
  select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

# ### NBClust
# 
# NbClust(data = df1, 
#         diss = NULL, 
#         distance = "canberra", 
#         min.nc = 7, 
#         max.nc = 12, 
#         method = "centroid", 
#         index = "all", 
#         alphaBeale = 0.1)

### Twinspan

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 3,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>% ## Lower merges Pap + Polu, higher divides Arte
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header3 %>%
  merge(kclusters, by = "SIVIMID") -> header4

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header4, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
#RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### DCA

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header4) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

### Sintaxa

header4 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Dominant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header4, by = "SIVIMID") %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

### Revised sintaxonomy

header4 %>%
  filter(Cluster != 3) %>%
  mutate(L2 = fct_recode(as.factor(Cluster),
                         "Balloto-Conion maculati" = "1",
                         "Cirsion richterano-chodati" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1A2.csv", fileEncoding = "latin1")


#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

header4 %>%
  filter(Cluster == 3) %>%
  select(-Cluster) -> header5

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header5$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

# ### NBClust
# 
# NbClust(data = df1, 
#         diss = NULL, 
#         distance = "canberra", 
#         min.nc = 7, 
#         max.nc = 12, 
#         method = "centroid", 
#         index = "all", 
#         alphaBeale = 0.1)

### Twinspan

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 2,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>% ## Lower merges Pap + Polu, higher divides Arte
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header5 %>%
  merge(kclusters, by = "SIVIMID") -> header6

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header4, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
#RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### DCA

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header6) %>%
  mutate(Cluster = as.factor(Cluster)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

### Sintaxa

header6 %>%
  group_by(Cluster, Sintaxon) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header6 %>%
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Dominant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Constant

species %>%
  merge(header4, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header4, by = "SIVIMID") %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame

### Revised sintaxonomy

header6 %>%
  mutate(L2 = fct_recode(as.factor(Cluster),
                         "Alliarienion petiolatae" = "1",
                         "Alliarienion petiolatae" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1A3.csv", fileEncoding = "latin1")