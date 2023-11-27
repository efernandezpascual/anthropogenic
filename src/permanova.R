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
