rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

### PCA

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") -> df1

df1 %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

pca1$eig; pca1$var

### Paint by classes

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Class = fct_relevel(Class,
                             "Cymbalario-Parietarietea diffusae",
                             "Polygono-Poetea annuae",
                             "Papaveretea rhoeadis",
                             "Digitario sanguinalis-Eragrostietea minoris",
                             "Chenopodietea",
                             "Sisymbrietea",
                             "Artemisietea vulgaris",
                             "Epilobietea angustifolii",
                             "Bidentetea")) %>%
  mutate(Class = fct_recode(Class, 
                            "Artemisietea" = "Artemisietea vulgaris",
                            "Parietarietea" = "Cymbalario-Parietarietea diffusae",
                            "Digitario-Eragrostietea" = "Digitario sanguinalis-Eragrostietea minoris",
                            "Epilobietea" = "Epilobietea angustifolii",
                            "Papaveretea" = "Papaveretea rhoeadis",
                            "Polygono-Poetea" = "Polygono-Poetea annuae")) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Class, data = df2, FUN = mean) -> cent
merge(df2, setNames(cent, c("Class", "oDCA1", "oDCA2")), by = "Class", sort = FALSE) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Class), show.legend = FALSE, alpha = 0.5) +
  ggrepel::geom_text_repel(data = cent, aes(label = Class), size = 2, fontface = "italic", min.segment.length = .25) +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  coord_cartesian(clip = "off") +
  labs(title = "(A) All vegetation classes") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("grey60",
                                "cadetblue4",
                                "chocolate1", 
                                "chocolate4",
                                "firebrick3",
                                "khaki1",
                                "darkmagenta", 
                                "limegreen",
                                "goldenrod1")) -> Fig1A; Fig1A

### Get legend

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Class = fct_relevel(Class,
                             "Cymbalario-Parietarietea diffusae",
                             "Polygono-Poetea annuae",
                             "Papaveretea rhoeadis",
                             "Digitario sanguinalis-Eragrostietea minoris",
                             "Chenopodietea",
                             "Sisymbrietea",
                             "Artemisietea vulgaris",
                             "Epilobietea angustifolii",
                             "Bidentetea")) %>%
  mutate(Class = fct_recode(Class, 
                            "Artemisietea" = "Artemisietea vulgaris",
                            "Parietarietea" = "Cymbalario-Parietarietea diffusae",
                            "Digitario-Eragrostietea" = "Digitario sanguinalis-Eragrostietea minoris",
                            "Epilobietea" = "Epilobietea angustifolii",
                            "Papaveretea" = "Papaveretea rhoeadis",
                            "Polygono-Poetea" = "Polygono-Poetea annuae"))  %>%
  ggplot(aes(x = Dim.1, y = Dim.2, fill = Class)) + 
  geom_point(shape = 22, size= 3)  +
  ggthemes::theme_tufte() +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "right", 
        legend.direction = "vertical",
        legend.title = element_text(size = 10),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_fill_manual(name = "Vegetation class",
                    values = c("grey60",
                                "cadetblue4",
                                "chocolate1", 
                                "chocolate4",
                                "firebrick3",
                                "khaki1",
                                "darkmagenta", 
                                "limegreen",
                                "goldenrod1")) -> FigLegend; FigLegend

legend <- cowplot::get_legend(FigLegend + theme(legend.box.margin = margin(0, 0, 0, 12)))

### Cymbalario-Parietarietea diffusae, Polygono-Poetea annuae

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  filter(Class %in% c("Cymbalario-Parietarietea diffusae",
                      "Polygono-Poetea annuae")) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Cluster = as.factor(Alliance)) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(Dim.1 = ifelse(Cluster == 18, Dim.1+.05, Dim.1)) %>%
  mutate(Dim.1 = ifelse(Cluster == 25, Dim.1-.05, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 23, Dim.1+.1, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 22, Dim.1-.25, Dim.1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster,),
               show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  geom_text(data = cent, aes(label = Cluster), size = 2, fontface = "italic") +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  labs(title = "(B) Trampled and wall alliances") +
  coord_cartesian(clip = "off") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("grey60",
                                "grey60",
                                "cadetblue4",
                                "cadetblue4",
                                "cadetblue4")) -> Fig1B; Fig1B

### Papaveretea rhoeadis and Digitario sanguinalis-Eragrostietea minoris

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  filter(Class %in% c("Papaveretea rhoeadis",
                      "Digitario sanguinalis-Eragrostietea minoris")) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Cluster = as.factor(Alliance)) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(Dim.1 = ifelse(Cluster == 18, Dim.1+.05, Dim.1)) %>%
  mutate(Dim.1 = ifelse(Cluster == 25, Dim.1-.05, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 23, Dim.1+.1, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 22, Dim.1-.25, Dim.1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster,),
               show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  geom_text(data = cent, aes(label = Cluster), size = 2, fontface = "italic") +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  coord_cartesian(clip = "off") +
  labs(title = "(C) Crop weed alliances") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("chocolate1",
                                "chocolate1",
                                "chocolate1",
                                "chocolate4")) -> Fig1C; Fig1C

### Chenopodietea and Sisymbrietea

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  filter(Class %in% c("Chenopodietea", "Sisymbrietea", "Bidentetea")) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Cluster = as.factor(Alliance)) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(Dim.1 = ifelse(Cluster == 18, Dim.1+.05, Dim.1)) %>%
  mutate(Dim.1 = ifelse(Cluster == 25, Dim.1-.05, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 23, Dim.1+.1, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 22, Dim.1-.25, Dim.1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster,),
               show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  ggrepel::geom_text_repel(data = cent, aes(label = Cluster), size = 2, fontface = "italic", min.segment.length = .25) +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  coord_cartesian(clip = "off") +
  labs(title = "(D) Annual ruderal alliances") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("firebrick3",
                                "goldenrod1",
                                "firebrick3",
                                "firebrick3",
                                "firebrick3",
                                "firebrick3",
                                "goldenrod1",
                                "khaki1")) -> Fig1D; Fig1D

### Artemisietea vulgaris

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  filter(Class %in% c("Artemisietea vulgaris")) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Cluster = as.factor(Alliance)) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(Dim.1 = ifelse(Cluster == 18, Dim.1+.05, Dim.1)) %>%
  mutate(Dim.1 = ifelse(Cluster == 25, Dim.1-.05, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 23, Dim.1+.1, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 22, Dim.1-.25, Dim.1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster,),
               show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  geom_text(data = cent, aes(label = Cluster), size = 2, fontface = "italic") +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  coord_cartesian(clip = "off") +
  labs(title = "(E) Dry perennial ruderal alliances") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("darkmagenta", 
                                "darkmagenta",
                                "darkmagenta",
                                "darkmagenta",
                                "darkmagenta",
                                "darkmagenta")) -> Fig1E; Fig1E

### Epilobietea angustifolii

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  filter(Class %in% c("Epilobietea angustifolii")) %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>% 
  decostand(method = "hellinger") %>%
  FactoMineR::PCA(graph = TRUE, scale.unit = FALSE) -> pca1

header %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca1$ind$coord %>%
          data.frame %>%
          rownames_to_column(var = "SIVIMID") %>%
          select(SIVIMID, Dim.1, Dim.2)) %>%
  mutate(Cluster = as.factor(Alliance)) -> df2

aggregate(cbind(Dim.1, Dim.2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(Dim.1 = ifelse(Cluster == 18, Dim.1+.05, Dim.1)) %>%
  mutate(Dim.1 = ifelse(Cluster == 25, Dim.1-.05, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 23, Dim.1+.1, Dim.1))%>%
  mutate(Dim.1 = ifelse(Cluster == 22, Dim.1-.25, Dim.1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) -> segs

df2 %>%
  ggplot(aes(x = Dim.1, y = Dim.2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster,),
               show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  geom_text(data = cent, aes(label = Cluster), size = 2, fontface = "italic") +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = function(x) format(x, nsmall = 2)) +
  scale_x_continuous(labels = function(x) format(x, nsmall = 2)) +
  coord_cartesian(clip = "off") +
  labs(title = "(F) Mesic-wet perennial ruderal alliances") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "none", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 9),
        axis.title = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 6, color = "black"),
        plot.margin = unit(c(0.3,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen")) -> Fig1F; Fig1F

### Merge

cowplot::plot_grid(Fig1A, Fig1B,
                   Fig1C, Fig1D,
                   Fig1E, Fig1F,ncol = 2) -> Fig1

cowplot::plot_grid(Fig1, legend, rel_widths = c(3, 1)) -> Figure1; Figure1

ggsave(Figure1, file = "results/figures/F2 - pca.png", bg = "white", 
       path = NULL, scale = 1, width = 180, height = 180, units = "mm", dpi = 600)
