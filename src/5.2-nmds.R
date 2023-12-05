library(tidyverse); library(vegan)

### All plots

rm(list = ls())

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("hellinger")-> df1

### NMDS plant communities

df1 %>%
  vegan::metaMDS(trymax = 100000, k = 2) -> 
  nmds # Ordination output

save(nmds, file = "results/nmds/NMDS-all-plots.RData")
load(file = "results/nmds/NMDS-all-plots.RData")

### Site scores

vegan::scores(nmds, "sites") %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  rename(Dim.1 = NMDS1, Dim.2 = NMDS2) %>%
  merge(header) %>%
  dplyr::select(SIVIMID, CANTEUNIS, Semisupervised, Order, Class, Dim.1, Dim.2) %>%
  mutate(Cluster = Class) -> sitescores

### Species scores

vegan::scores(nmds, "species") %>%
  data.frame() %>%
  rownames_to_column("Taxon") %>%
  rename(Dim.1 = NMDS1, Dim.2 = NMDS2) %>%
  mutate(Species = Taxon) %>%
  separate(Species, into = c("G", "S")) %>%
  mutate(Species = paste(substr(G, 1, 3), substr(S, 1, 3), sep = "")) %>%
  dplyr::select(Taxon, Species, Dim.1, Dim.2) -> sppscores

### Centroids 

cent <- aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = sitescores, FUN = mean)
segs <- merge(sitescores, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

### Plot NMDS sites

ggplot(sitescores, aes(x = Dim.1, y = Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
 # geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T) +
  geom_text(data = cent, aes(label = Cluster)) +
  # ggrepel::geom_text_repel(data = sppscores, aes(label = Species), color = "grey33", fontface = "italic", size = 4, segment.color = "transparent") +
  ggthemes::theme_tufte() +
  # guides(fill=guide_legend(override.aes=list(shape = 21))) + 
  ggtitle(label = "NMDS of plant communities") +
  theme(text = element_text(family = "sans"),
        legend.position = "right", legend.box = "vertical", legend.margin = margin(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10, color = "black"),
        panel.background = element_rect(color = "black", fill = NULL),
        axis.title = element_text(size = 10),
        axis.text = element_text(size = 10, color = "black")) +
  # coord_cartesian(xlim = c(-1.1, 1), ylim = c(-1, 1)) +
  # scale_color_manual(values = colores)+
  # scale_fill_manual(values = colores)  +
  scale_x_continuous(name = "NMDS1") + 
  scale_y_continuous(name = "NMDS2") -> F1; F1

ggsave(F1, file = "results/nmds/NMDS-all-plots.png", bg = "white",
      path = NULL, scale = 1, width = 200, height = 150, units = "mm", dpi = 600)

### No noise

rm(list = ls())

read.csv("data/urban-header-5.2.csv", fileEncoding = "latin1") %>%
  filter(! Semisupervised %in% "Noise") -> header

read.csv("data/urban-species-5.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  decostand("hellinger")-> df1

### NMDS plant communities

df1 %>%
  vegan::metaMDS(trymax = 100000, k = 2) -> 
  nmds # Ordination output

save(nmds, file = "results/nmds/NMDS-no-noise.RData")
load(file = "results/nmds/NMDS-no-noise.RData")

### Site scores

vegan::scores(nmds, "sites") %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  rename(Dim.1 = NMDS1, Dim.2 = NMDS2) %>%
  merge(header) %>%
  dplyr::select(SIVIMID, CANTEUNIS, Semisupervised, Order, Class, Dim.1, Dim.2) %>%
  mutate(Cluster = Class) -> sitescores

### Species scores

vegan::scores(nmds, "species") %>%
  data.frame() %>%
  rownames_to_column("Taxon") %>%
  rename(Dim.1 = NMDS1, Dim.2 = NMDS2) %>%
  mutate(Species = Taxon) %>%
  separate(Species, into = c("G", "S")) %>%
  mutate(Species = paste(substr(G, 1, 3), substr(S, 1, 3), sep = "")) %>%
  dplyr::select(Taxon, Species, Dim.1, Dim.2) -> sppscores

### Centroids 

cent <- aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = sitescores, FUN = mean)
segs <- merge(sitescores, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

### Plot NMDS sites

ggplot(sitescores, aes(x = Dim.1, y = Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  # geom_point(data = cent, shape = 21, size = 5, aes(fill = Cluster), show.legend = T) +
  geom_text(data = cent, aes(label = Cluster)) +
  # ggrepel::geom_text_repel(data = sppscores, aes(label = Species), color = "grey33", fontface = "italic", size = 4, segment.color = "transparent") +
  ggthemes::theme_tufte() +
  # guides(fill=guide_legend(override.aes=list(shape = 21))) + 
  ggtitle(label = "NMDS of plant communities") +
  theme(text = element_text(family = "sans"),
        legend.position = "right", legend.box = "vertical", legend.margin = margin(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10, color = "black"),
        panel.background = element_rect(color = "black", fill = NULL),
        axis.title = element_text(size = 10),
        axis.text = element_text(size = 10, color = "black")) +
  # coord_cartesian(xlim = c(-1.1, 1), ylim = c(-1, 1)) +
  # scale_color_manual(values = colores)+
  # scale_fill_manual(values = colores)  +
  scale_x_continuous(name = "NMDS1") + 
  scale_y_continuous(name = "NMDS2") -> F2; F2

ggsave(F2, file = "results/nmds/NMDS-no-noise.png", bg = "white",
       path = NULL, scale = 1, width = 200, height = 150, units = "mm", dpi = 600)
