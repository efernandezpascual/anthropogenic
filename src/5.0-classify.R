library(tidyverse); library(vegan); library(labdsv)

rm(list = ls())

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 6) %>%
  filter(Manmade == "Yes") %>%
  filter(Assigned != "Not Cantabrian") %>%
  pull(Alliance) %>%
  unique -> alliances

read.csv("data/urban-header-5.0.csv", fileEncoding = "latin1") %>%
  filter(Alliance %in% alliances) -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan 

twinspanR::twinspan(
  df1,
  modif = TRUE,
  cut.levels = c(0, 15, 25),
  min.group.size = 10,
  clusters = 15,
  diss = "multi.sorensen",
  mean.median = "mean",
  show.output.on.console = FALSE,
  quiet = TRUE) %>% 
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header2

### Permanova, find max number of significant clusters = 15

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header2, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")
# adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)
# anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))

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

### Sintaxa

header2 %>%
  group_by(Cluster, Class) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header2 %>% pull(Cluster) %>% unique
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

#### Cluster 1

header2 %>% filter(Cluster == 1) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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
  group_by(Cluster, Class) %>%
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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Oxalidion europaeae" = "1",
                         "Oxalidion europaeae" = "2",
                         "Oxalidion europaeae" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1A.csv", fileEncoding = "latin1")

#### Cluster 2

header2 %>% filter(Cluster == 2) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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
  group_by(Cluster, Class) %>%
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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Scleranthion annui" = "1",
                         "Scleranthion annui" = "2",
                         "Scleranthion annui" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1B.csv", fileEncoding = "latin1")

#### Cluster 3

header2 %>% filter(Cluster == 3) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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
  group_by(Cluster, Class) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Sintaxon) %>%
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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Scleranthion annui" = "1",
                         "Scleranthion annui" = "2",
                         "Extra" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1C.csv", fileEncoding = "latin1")

#### Cluster 4

header2 %>% filter(Cluster == 3) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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
  group_by(Cluster, Class) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Sintaxon) %>%
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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Scleranthion annui" = "1",
                         "Scleranthion annui" = "2",
                         "Mediterranean" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1C.csv", fileEncoding = "latin1")

#### Cluster 5

header2 %>% filter(Cluster == 5) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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
  group_by(Cluster, Class) %>%
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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Spergulo arvensis-Erodion cicutariae" = "1",
                         "Spergulo arvensis-Erodion cicutariae" = "2",
                         "Spergulo arvensis-Erodion cicutariae" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1D.csv", fileEncoding = "latin1")

#### Cluster 6

header2 %>% filter(Cluster == 6) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Bidention tripartitae" = "1",
                         "Paspalo-Agrostion semiverticillati" = "2",
                         "Bidention tripartitae" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1E.csv", fileEncoding = "latin1")

#### Cluster 7

header2 %>% filter(Cluster == 7) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Sisymbrion officinalis" = "1",
                         "Polygono-Coronopodion" = "2",
                         "Saginion procumbentis" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1F.csv", fileEncoding = "latin1")

#### Cluster 8

header2 %>% filter(Cluster == 8) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Sisymbrion officinalis" = "1",
                         "Balloto-Conion maculati" = "2",
                         "Arction lappae" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1G.csv", fileEncoding = "latin1")

#### Cluster 9

header2 %>% filter(Cluster == 9) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Balloto-Conion maculati" = "1",
                         "Aegopodion podagrariae" = "2",
                         "Alliarienion petiolatae" = "3",
                         "Geranio pusilli-Anthriscion caucalidis" = "4")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1H.csv", fileEncoding = "latin1")

#### Cluster 10

header2 %>% filter(Cluster == 10) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Smyrnienion olusatri" = "1",
                         "Senecionion fluviatilis" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1I.csv", fileEncoding = "latin1")

#### Cluster 11

header2 %>% filter(Cluster == 11) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>% 
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Dauco-Melilotion" = "1",
                         "Sisymbrion officinalis" = "2",
                         "Cynancho-Convolvulion sepium" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1J.csv", fileEncoding = "latin1")

#### Cluster 12

header2 %>% filter(Cluster == 12) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>% 
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Bidention tripartitae" = "1",
                         "Bidention tripartitae" = "2",
                         "Bidention tripartitae" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1K.csv", fileEncoding = "latin1")

#### Cluster 13

header2 %>% filter(Cluster == 13) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Galio valantiae-Parietarion judaicae" = "1",
                         "Cymbalario-Asplenion" = "2",
                         "Cirsion richterano-chodati" = "3",
                         "Epilobion angustifolii" = "4")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1L.csv", fileEncoding = "latin1")

#### Cluster 14

header2 %>% filter(Cluster == 14) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Scleranthion annui" = "1",
                         "Polycarpion tetraphylli" = "2",
                         "Linario polygalifoliae-Vulpion alopecuri" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1M.csv", fileEncoding = "latin1")

#### Cluster 15

header2 %>% filter(Cluster == 15) %>% select(-Cluster) -> header3

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

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
  quiet = TRUE) %>%
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>% merge(kclusters, by = "SIVIMID") -> header4

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

### Save

header4 %>%
  mutate(L1 = fct_recode(as.factor(Cluster),
                         "Paspalo-Agrostion semiverticillati" = "1",
                         "Saginion procumbentis" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1N.csv", fileEncoding = "latin1")

### Update header with clusters

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 6) %>%
  select(Alliance, Class) %>%
  rename(L1 = Alliance, L0 = Class) %>%
  unique -> alliances

rbind(
read.csv("data/urban-header-5.1A.csv", fileEncoding = "latin1"),
read.csv("data/urban-header-5.1B.csv", fileEncoding = "latin1"),
read.csv("data/urban-header-5.1C.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1D.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1E.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1F.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1G.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1H.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1I.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1J.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1K.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1L.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1M.csv", fileEncoding = "latin1"), 
read.csv("data/urban-header-5.1N.csv", fileEncoding = "latin1")) %>%
  filter(L1 != "Mediterranean") %>%
  merge(alliances, all.x = TRUE) -> header7

header7 %>%
  select(SIVIMID, L1, L0) %>%
  merge(read.csv("data/urban-header-5.0.csv", fileEncoding = "latin1"), all.y = TRUE) -> header5.1

header5.1 %>%
  group_by(L1) %>%
  tally %>% data.frame

write.csv(header5.1, "data/urban-header-5.1.csv", row.names = FALSE, fileEncoding = "latin1")

### Test significance of classification

rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### DCA Classes

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(L0)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = L0), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots") +
  ggrepel::geom_text_repel(data = cent, aes(label = Cluster), color = "black") -> F1; F1

### Permanova classes = All classes significant p = 0.0036

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$L0, nperm = 9999, p.method = "holm")

### DCA alliances

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(L1)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = L1), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots") +
  ggrepel::geom_text_repel(data = cent, aes(label = Cluster), color = "black") -> F1; F1

### Permanova alliances = All significant p = 0.025 

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$L1, nperm = 9999, p.method = "holm")

### Epilobietea + Anthriscion

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>%
  filter(L0 == "Epilobietea angustifolii" | 
           L1 == "Geranio pusilli-Anthriscion caucalidis" |
           L0 == "Artemisietea vulgaris" |
           L0 == "Sisymbrietea") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### DCA alliances

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(L1)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = L1), show.legend = F) +
  #geom_point(data = cent, shape = 21, size = 5, aes(fill = Alliance.revised), show.legend = F) +
  ggtitle(label = "All plots") +
  ggrepel::geom_text_repel(data = cent, aes(label = Cluster), color = "black") -> F1; F1

### Permanova alliances = All significant p = 0.0066 

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$L1, nperm = 9999, p.method = "holm")

### Poetea + Papaveretea + Eragrostetea

read.csv("data/urban-header-5.1.csv", fileEncoding = "latin1") %>%
  filter(L0 == "Polygono-Poetea annuae" | 
           L0 == "Papaveretea rhoeadis" |
           L0 == "Digitario sanguinalis-Eragrostietea minoris") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

### DCA alliances

decorana(df1) -> dca1

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(L1)) -> df2

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)
segs <- merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)


df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = L1), show.legend = F) +
  ggtitle(label = "All plots") +
  ggrepel::geom_text_repel(data = cent, aes(label = Cluster), color = "black") -> F1; F1

### Permanova alliances = All significant p = 0.0015

# df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header, by = "SIVIMID") -> df1b
# RVAideMemoire::pairwise.perm.manova(dist(df1, "euclidian"), df1b$L1, nperm = 9999, p.method = "holm")
