library(tidyverse); library(vegan)

rm(list = ls())

read.csv("data/urban-header-3.1.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID != "U-P12220") %>% # Fountain community
  filter(SIVIMID != "T-P32083") %>% # Scree community
  filter(SIVIMID != "Q-P10409") %>% # Med trampled
  filter(SIVIMID != "T-P18308") %>% # Pre-forest
  filter(SIVIMID != "T-P27333") %>% # Trifolio-Geranietea
  filter(!SIVIMID %in% c("T-P17240", "T-P17242", "T-P17233")) %>% # Rhamno-Juniperetum lyciae
  filter(!SIVIMID %in% c("Q-P09920", "Q-P09917", "R-P24470")) %>% # Walls at border of Med region
  filter(!SIVIMID %in% c("T-P18091", "T-P18090", "T-P18092")) %>% # Ranunculetum saniculifolii
  filter(Revised.class == "Epilobietea angustifolii") -> header

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 5) %>% ## Optimal number, higher divides Papaveretea and Epilobietea
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

df2 %>% arrange(-DCA1) %>% head %>% select(DCA1, SIVIMID) %>% merge(species) %>% arrange(-DCA1, -Cover.percent)
df2 %>% arrange(-DCA2) %>% head %>% select(DCA2, SIVIMID) %>% merge(species) %>% arrange(-DCA2, -Cover.percent)

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header2, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### Sintaxa

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

### Revised sintaxonomy

header2 %>%
  filter(Cluster != 1) %>%
  mutate(Revised.alliance = fct_recode(as.factor(Cluster),
                                       "Dauco-Melilotion" = "2",
                                       "Cynancho-Convolvulion sepium" = "3",
                                       "Senecionion fluviatilis" = "4",
                                       "Epilobion angustifolii" = "5")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-3.1D1.csv", fileEncoding = "latin1")

#======================================================================

### group 1

header2 %>%
  filter(Cluster == 1) %>%
  select(-Cluster) -> header

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 4) %>% ## Optimal number, higher divides Papaveretea and Epilobietea
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

df2 %>% arrange(-DCA1) %>% head %>% select(DCA1, SIVIMID) %>% merge(species) %>% arrange(-DCA1, -Cover.percent)
df2 %>% arrange(-DCA2) %>% head %>% select(DCA2, SIVIMID) %>% merge(species) %>% arrange(-DCA2, -Cover.percent)
df2 %>% arrange(DCA2) %>% head %>% select(DCA2, SIVIMID) %>% merge(species) %>% arrange(DCA2, -Cover.percent)

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T)

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header2, by = "SIVIMID") -> df1b
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### Sintaxa

header2 %>%
  group_by(Cluster, Sintaxon) %>%
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

### Revised sintaxonomy

header2 %>%
  mutate(Revised.alliance = fct_recode(as.factor(Cluster),
                                       "Arction lappae" = "1",
                                       "Balloto-Conion maculati" = "2",
                                       "Alliarienion petiolatae" = "3",
                                       "Smyrnienion olusatri" = "4")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-3.1D2.csv", fileEncoding = "latin1")
