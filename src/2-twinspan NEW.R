library(tidyverse); library(vegan); library(labdsv)

rm(list = ls())

read.csv("results/sintaxonomy/original-sintaxonomy.csv", fileEncoding = "latin1") %>%
  select(Original, Alliance, Order, Class) %>%
  unique -> syntaxonomy

syntaxonomy %>% group_by(Alliance)

read.csv("data/header.csv", fileEncoding = "latin1") %>%
  select(-c(Alliance, Order, Class, CANTEUNIS)) %>%
  merge(syntaxonomy)-> header

header %>% group_by(Alliance)
header %>% group_by(SIVIMID)
header %>% pull(Class) %>% unique

#### Cluster 1

header %>% filter(Class == "Cymbalario-Parietarietea diffusae") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
                         "Cymbalario-Asplenion" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1A.csv", fileEncoding = "latin1")

#### Cluster 2

header %>% filter(Class == "Polygono-Poetea annuae") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
                         "Polygono-Coronopodion" = "1",
                         "Saginion procumbentis" = "2",
                         "Polycarpion tetraphylli" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1B.csv", fileEncoding = "latin1")

#### Cluster 3

header %>% filter(Class == "Papaveretea rhoeadis") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Oxalidion europeae" = "1",
                         "Scleranthion annui" = "2",
                         "Scleranthion annui" = "3")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1C.csv", fileEncoding = "latin1")

#### Cluster 4

header %>% filter(Class == "Chenopodietea") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  clusters = 5,
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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Echio-Galactition tomentosae" = "1",
                         "Chenopodion muralis" = "2",
                         "Allion triquetri" = "3",
                         "Geranio pusilli-Anthriscion caucalidis" = "4",
                         "Linario polygalifoliae-Vulpion alopecuri" = "5")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1D.csv", fileEncoding = "latin1")

#### Cluster 5

header %>% filter(Class == "Sisymbrietea") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Sisymbrion officinalis" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1E.csv", fileEncoding = "latin1")

#### Cluster 6

header %>% filter(Class == "Bidentetea") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Paspalo-Agrostion semiverticillati" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1F.csv", fileEncoding = "latin1")

#### Cluster 7

header %>% filter(Class == "Artemisietea vulgaris") -> header3
header3 %>% group_by(Original) %>% tally
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  clusters = 5,
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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Silybo mariani-Urticion piluliferae" = "2",
                         "Cirsion richterano-chodati" = "3",
                         "Carduo carpetani-Cirsion odontolepidis" = "4",
                         "Cirsion richterano-chodati" = "5")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1G.csv", fileEncoding = "latin1")

#### Cluster 8

header %>% filter(Class == "Epilobietea angustifolii" ) -> header3
# header %>% filter(Order %in% c( "Convolvuletalia sepium") ) -> header3
# header %>% filter(Alliance %in% c( "Aegopodion podagrariae", "Balloto-Conion maculati", "Geo urbani-Alliarion officinalis") ) -> header3
header3 %>% group_by(Original) %>% tally %>% print(n =222)
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  clusters = 6,
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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

# header4 %>%
#   filter(SIVIMID %in% c("R-P23949", "R-P24668", "T-P06561", "T-P06562", "T-P06564", "T-P06571", "T-P06581", "T-P06582", "T-P06583", "T-P07926", "T-P07928", "T-P07929", "T-P13200"))

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "Balloto-Conion maculati" = "2",
                         "Geo urbani-Alliarion officinalis" = "3",
                         "Arction lappae" = "4",
                         "Senecionion fluviatilis" = "5",
                         "Epilobion angustifolii" = "6")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1H.csv", fileEncoding = "latin1")

#### Cluster 9

header %>% filter(Class == "Digitario sanguinalis-Eragrostietea minoris" ) -> header3
# header %>% filter(Order %in% c( "Convolvuletalia sepium") ) -> header3
header3 %>% group_by(Original) %>% tally %>% print(n =222)
header3 %>% group_by(Alliance) %>% tally

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header3$SIVIMID) -> species

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
  group_by(Cluster, Alliance) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

header4 %>%
  group_by(Cluster, Original) %>%
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
                         "NA" = "2")) %>%
  select(-Cluster) %>%
  write.csv("data/urban-header-5.1I.csv", fileEncoding = "latin1")

### Update header with clusters

rbind(
  read.csv("data/urban-header-5.1A.csv", fileEncoding = "latin1"),
  read.csv("data/urban-header-5.1B.csv", fileEncoding = "latin1"),
  read.csv("data/urban-header-5.1C.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1D.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1E.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1F.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1G.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1H.csv", fileEncoding = "latin1"), 
  read.csv("data/urban-header-5.1I.csv", fileEncoding = "latin1")) %>% 
  select(SIVIMID, L1) -> header7

read.csv("data/header.csv", fileEncoding = "latin1") %>%
  select(-c(Alliance, Order, Class, CANTEUNIS)) %>%
  merge(syntaxonomy, all.x = TRUE) %>%
  merge(header7, all.x = TRUE) %>%
  mutate(Fixed = ifelse((L1 != Alliance | is.na(L1)), 0, 1)) ->
  header5.1

header5.1 %>%
  group_by(Fixed) %>%
  tally

header5.1 %>%
  group_by(L1) %>%
  na.omit %>%
  tally %>% print(n = 100)

write.csv(header5.1, "data/urban-header-5.1.csv", row.names = FALSE, fileEncoding = "latin1")
