rm(list = ls())

library(tidyverse)

### Reciprocal averaging

# read.csv("data/traits.csv", fileEncoding = "latin1") %>%
#   select(Analysis.Names,
#          EIVE1.M:Soil.Disturbance) %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   na.omit %>%
#   merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
#   group_by(SIVIMID, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) -> plotmeans
# 
# read.csv("data/species.csv", fileEncoding = "latin1") %>%
#   merge(plotmeans) %>%
#   group_by(Analysis.Names, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) %>%
#   rename(ravalue = Value) -> sppmeans
# 
# read.csv("data/traits.csv", fileEncoding = "latin1") %>%
#   select(Analysis.Names,
#          EIVE1.M:Soil.Disturbance) %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   merge(sppmeans, all.x = TRUE) %>%
#   mutate(value = ifelse(is.na(Value), ravalue, Value)) %>%
#   select(-c(Value, ravalue)) %>%
#   spread(Trait, value) -> raspp
# 
# read.csv("data/traits.csv", fileEncoding = "latin1") %>%
#   select(-c(EIVE1.M:Soil.Disturbance)) %>%
#   merge(raspp) -> traits
# 
# ### Plot means
# 
# traits %>%
#   select(Analysis.Names, Disturbance.Frequency, Disturbance.Severity,
#          EIVE1.T, EIVE1.M, EIVE1.L, EIVE1.N, EIVE1.R) %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
#   group_by(SIVIMID, Trait) %>%
#   summarise(Value = mean(Value)) %>%
#   spread(Trait, Value) %>%
#   merge(read.csv("data/header.csv", fileEncoding = "latin1")) -> plotmeans
# 
# save(plotmeans, file = "results/plotmeans/plotmeans.RData")

load(file = "results/plotmeans/plotmeans.RData")

plotmeans %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         Disturbance.Frequency,
         Disturbance.Severity,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  gather(Trait, Value, Disturbance.Frequency:EIVE1.L) %>%
  na.omit  %>%
  mutate(Trait = fct_relevel(Trait, 
                             "heightmax",
                             "floweringmean",
                             "floweringwidth",
                             "neophyte",
                             "geophyte",
                             "therophyte",
                             "EIVE1.T",
                             "EIVE1.M",
                             "EIVE1.L",
                             "EIVE1.N",
                             "EIVE1.R",
                             "Disturbance.Frequency",
                             "Disturbance.Severity",
                             "Soil.Disturbance",
                             "Mowing.Frequency",
                             "Grazing.Pressure")) %>%
  mutate(Trait = fct_recode(Trait, 
                            "(A) Vegetation height (cm)" = "heightmax",
                            "(B) Flowering peak (month)" = "floweringmean",
                            "Flowering length (months)" = "floweringwidth",
                            "Neophytes (% of total cover)" = "neophyte",
                            "Geophytes (% of total cover)" = "geophyte",
                            "Therophytes (% of total cover)" = "therophyte",
                            "(A) Temperature" = "EIVE1.T",
                            "(B) Moisture" = "EIVE1.M",
                            "(C) Light" = "EIVE1.L",
                            "(D) Nutrients" = "EIVE1.N",
                            "(E) Soil reaction" = "EIVE1.R",
                            "(F) Disturbance frequency" = "Disturbance.Frequency",
                            "(G) Disturbance severity" = "Disturbance.Severity",
                            "Soil disturbance (indicator)" = "Soil.Disturbance",
                            "Mowing frequency (indicator)" = "Mowing.Frequency",
                            "Grazing pressure (indicator)" = "Grazing.Pressure")) %>%
  mutate(Alliance = fct_relevel(Alliance, 
                                "Galio valantiae-Parietarion judaicae",
                                "Cymbalario-Asplenion",
                                "Polycarpion tetraphylli",
                                "Polygono-Coronopodion",
                                "Saginion procumbentis",
                                "Caucalidion lappulae",
                                "Scleranthion annui",
                                "Oxalidion europeae",
                                "Spergulo arvensis-Erodion cicutariae",
                                "Allion triquetri",
                                "Geranio pusilli-Anthriscion caucalidis",
                                "Chenopodion muralis",
                                "Echio-Galactition tomentosae",
                                "Linario polygalifoliae-Vulpion alopecuri",
                                "Sisymbrion officinalis",
                                "Bidention tripartitae",
                                "Paspalo-Agrostion semiverticillati",
                                "Convolvulo arvensis-Agropyrion repentis",
                                "Silybo mariani-Urticion piluliferae", 
                                "Carduo carpetani-Cirsion odontolepidis",
                                "Cirsion richterano-chodati",
                                "Dauco-Melilotion",
                                "Geo urbani-Alliarion officinalis",
                                "Arction lappae",
                                "Balloto-Conion maculati",
                                "Aegopodion podagrariae",
                                "Epilobion angustifolii",
                                "Cynancho-Convolvulion sepium",
                                "Senecionion fluviatilis")) %>%
  mutate(Class = fct_relevel(Class,
                             "Cymbalario-Parietarietea diffusae",
                             "Polygono-Poetea annuae",
                             "Papaveretea rhoeadis",
                             "Digitario sanguinalis-Eragrostietea minoris",
                             "Chenopodietea",
                             "Sisymbrietea",
                             "Bidentetea",
                             "Artemisietea vulgaris",
                             "Epilobietea angustifolii")) %>%
  mutate(Class = fct_recode(Class, 
                            "Artemisietea" = "Artemisietea vulgaris",
                            "Parietarietea" = "Cymbalario-Parietarietea diffusae",
                            "Digitario-Eragrostietea" = "Digitario sanguinalis-Eragrostietea minoris",
                            "Epilobietea" = "Epilobietea angustifolii",
                            "Papaveretea" = "Papaveretea rhoeadis",
                            "Polygono-Poetea" = "Polygono-Poetea annuae")) %>%
  mutate(group = as.numeric(Alliance)) %>%
  ggplot(aes(as.factor(group), Value, fill = Class)) +
  facet_wrap(~ Trait, scales = "free_y", ncol = 1) +
  geom_boxplot(outlier.size = 0.5,
               outlier.alpha = 0.6,
               lwd = 0.25) +
  scale_fill_manual(name = "Vegetation class",
                    values = c("grey60",
                               "cadetblue4",
                               "chocolate1", 
                               "chocolate4",
                               "firebrick3",
                               "khaki1",
                               "goldenrod1",
                               "darkmagenta", 
                               "limegreen")) +
  ggthemes::theme_tufte() +
  xlab("Alliance") + ylab("Value") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "right", 
        #legend.direction = "vertical",
        legend.title = element_text(size = 10),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 10, hjust = 0, margin = margin(l = 0, b = 4)),
        #strip.text = element_blank(),
        panel.spacing = unit(0.25, "lines"),
        plot.title = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.y = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0.1,0,0,0), "cm")) -> Fig4; Fig4

ggsave(Fig4, file = "results/figures/F6 - indicators.png", bg = "white", 
       path = NULL, scale = 1, width = 180, height = 185, units = "mm", dpi = 600)

### PCA with indicators

plotmeans %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Disturbance.Frequency,
         Disturbance.Severity,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  column_to_rownames(var = "SIVIMID") %>%
  FactoMineR::PCA(graph = TRUE) -> pca2

pca2$eig; pca2$var

### Get individual coordinates

plotmeans %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(pca2$ind$coord %>%
            data.frame %>%
            rownames_to_column(var = "SIVIMID") %>%
            select(SIVIMID, Dim.1, Dim.2) %>%
            mutate(PCA = "(B) PCA of species preferences: plots")) %>%
  mutate(Class = fct_relevel(Class,
                             "Cymbalario-Parietarietea diffusae",
                             "Polygono-Poetea annuae",
                             "Papaveretea rhoeadis",
                             "Digitario sanguinalis-Eragrostietea minoris",
                             "Chenopodietea",
                             "Sisymbrietea",
                             "Bidentetea",
                             "Artemisietea vulgaris",
                             "Epilobietea angustifolii")) %>%
  mutate(Class = fct_recode(Class, 
                            "Artemisietea" = "Artemisietea vulgaris",
                            "Parietarietea" = "Cymbalario-Parietarietea diffusae",
                            "Digitario-Eragrostietea" = "Digitario sanguinalis-Eragrostietea minoris",
                            "Epilobietea" = "Epilobietea angustifolii",
                            "Papaveretea" = "Papaveretea rhoeadis",
                            "Polygono-Poetea" = "Polygono-Poetea annuae")) ->
  inds

inds %>% group_by(Class) %>% summarise(PC1 = mean (Dim.1), PC2 = mean(Dim.2)) %>% arrange(PC1)
inds %>% group_by(Class) %>% summarise(PC1 = mean (Dim.1), PC2 = mean(Dim.2)) %>% arrange(PC2)

### Plot each class

inds %>% 
  filter(Class == "Parietarietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "grey60",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Parietarietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3B; Fig3B

inds %>% 
  filter(Class == "Polygono-Poetea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "cadetblue4",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Polygono-Poetea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3C; Fig3C

inds %>% 
  filter(Class == "Papaveretea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "chocolate1",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Papaveretea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3D; Fig3D

inds %>% 
  filter(Class == "Digitario-Eragrostietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "chocolate4",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Digitario-Eragrostietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3E; Fig3E

inds %>% 
  filter(Class == "Chenopodietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "firebrick3",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Chenopodietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3F; Fig3F

inds %>% 
  filter(Class == "Sisymbrietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "khaki1",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Sisymbrietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3G; Fig3G

inds %>% 
  filter(Class == "Bidentetea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "goldenrod1",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Bidentetea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3H; Fig3H

inds %>% 
  filter(Class == "Artemisietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "darkmagenta",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Artemisietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3I; Fig3I

inds %>% 
  filter(Class == "Epilobietea") %>%
  ggplot(aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(data = inds, color = "grey",
             show.legend = TRUE, size = 1) +
  geom_point(color = "limegreen",
             show.legend = TRUE, size = 2.2) +
  ggthemes::theme_tufte() +
  annotate("text", x = 0, y = -4, size = 3, family = "sans", fontface = "italic", label = "Epilobietea") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        panel.background = element_rect(color = "black", fill = NULL),
        legend.title = element_text(size = 10, face = "italic"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) -> 
  Fig3J; Fig3J

cowplot::plot_grid(Fig3B, Fig3C, Fig3D,
                   Fig3E, Fig3F, Fig3G,
                   Fig3H, Fig3I, Fig3J) -> Fig3BJ
Fig3BJ

### Arrows

pca2$var$coord %>%
        data.frame %>%
        rownames_to_column(var = "Variable") %>%
        mutate(PCA = "(B) Community ecological preferences") %>%
  mutate(Dim.1 = ifelse(Variable == "EIVE1.M", Dim.1 + .20, Dim.1)) %>%
  mutate(Variable = fct_recode(Variable, 
                               "height" = "heightmax", 
                               "flowering\npeak" = "floweringmean", 
                               "flowering\nlength" = "floweringwidth", 
                               "geophytes" = "geophyte", 
                               "neophytes" = "neophyte", 
                               "thero-\nphytes" = "therophyte", 
                               "Nutrients" = "EIVE1.N", 
                               "Light" = "EIVE1.L", 
                               "Temperature" = "EIVE1.T", 
                               "Moisture" = "EIVE1.M", 
                               "pH" = "EIVE1.R", 
                               "Disturbance severity" = "Disturbance.Severity", 
                               "Disturbance frequency" = "Disturbance.Frequency", 
                               "mowing" = "Mowing.Frequency", 
                               "grazing" = "Grazing.Pressure", 
                               "soil dist." = "Soil.Disturbance")) -> 
  vars


aggregate(cbind(Dim.1, Dim.2) ~ Class, data = inds, FUN = mean) -> cent
merge(inds, setNames(cent, c("Class", "oDCA1", "oDCA2")), by = "Class", sort = FALSE) -> segs

### Plot

ggplot(inds, aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(color = "grey",
             show.legend = TRUE, size = 1, alpha = 0.75) +
  geom_segment(data = vars, aes(x = 0, y = 0, xend = Dim.1*3.5, yend = Dim.2*3.5), color = "grey50") +
  geom_text(data = vars, aes(x = Dim.1*3.8, y = Dim.2*3.8, label = Variable),  show.legend = FALSE, size = 3) +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = scales::label_number(accuracy = 0.1)) +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "right", 
        #legend.direction = "vertical",
        legend.title = element_text(size = 10),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        # strip.text = element_text(size = 12, hjust = 0, margin = margin(l = 0, b = 4)),
        strip.text = element_blank(),
        panel.spacing = unit(0.05, "lines"),
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text.x = element_text(size = 8, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0,0,0,0), "cm")) +
  guides(colour = guide_legend(override.aes = list(alpha = 1))) -> 
  Fig3A; Fig3A

cowplot::plot_grid(Fig3A, Fig3BJ) -> Fig3

### Merge

ggsave(Fig3, file = "results/figures/F7 - pca.png", bg = "white", 
       path = NULL, scale = 1, width = 179, height = 85, units = "mm", dpi = 600)

