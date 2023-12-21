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
# ### CwMs
# 
# traits %>%
#   gather(Trait, Value, -Analysis.Names) %>%
#   merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
#   group_by(SIVIMID, Trait) %>%
#   summarise(Value = weighted.mean(Value, Cover.percent)) %>%
#   spread(Trait, Value) %>%
#   merge(read.csv("data/header.csv", fileEncoding = "latin1")) -> cwms
# 
# save(cwms, file = "results/cwms/cwms.RData")

rm(list = ls())

load(file = "results/cwms/cwms.RData")
  
### PCA with species traits

cwms %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         floweringmean,
         floweringwidth,
         heightmax,
         #bryophyte,
         geophyte, 
         #hemicryptophyte,
         #hydrophyte,
         #phanerophyte,
         therophyte,
         neophyte) %>%
  column_to_rownames(var = "SIVIMID") %>%
  FactoMineR::PCA(graph = TRUE) -> pca1

pca1$eig; pca1$var

### PCA with species requirements

cwms %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  column_to_rownames(var = "SIVIMID") %>%
  FactoMineR::PCA(graph = TRUE) -> pca2

pca2$eig; pca2$var

### Get individual coordinates

cwms %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Alliance, Class) %>%
  merge(
    rbind(pca1$ind$coord %>%
            data.frame %>%
            rownames_to_column(var = "SIVIMID") %>%
            select(SIVIMID, Dim.1, Dim.2) %>%
            mutate(PCA = "(A) PCA of species traits: plots"),
          pca2$ind$coord %>%
            data.frame %>%
            rownames_to_column(var = "SIVIMID") %>%
            select(SIVIMID, Dim.1, Dim.2) %>%
            mutate(PCA = "(B) PCA of species preferences: plots"))) %>%
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
                              "Polygono-Poetea" = "Polygono-Poetea annuae")) ->
  inds

rbind(pca1$var$coord %>%
        data.frame %>%
        rownames_to_column(var = "Variable") %>%
        mutate(PCA = "(A) Community traits"),
      pca2$var$coord %>%
        data.frame %>%
        rownames_to_column(var = "Variable") %>%
        mutate(PCA = "(B) Community ecological preferences")) %>%
  mutate(Variable = fct_recode(Variable, 
                               "height" = "heightmax", 
                               "flowering\npeak" = "floweringmean", 
                               "flowering\nlength" = "floweringwidth", 
                               "geophytes" = "geophyte", 
                               "neophytes" = "neophyte", 
                               "thero-\nphytes" = "therophyte", 
                               "nutrients" = "EIVE1.N", 
                               "light" = "EIVE1.L", 
                               "temperature" = "EIVE1.T", 
                               "moisture" = "EIVE1.M", 
                               "soil\nreaction" = "EIVE1.R", 
                               "dist. severity" = "Disturbance.Severity", 
                               "dist. frequency" = "Disturbance.Frequency", 
                               "mowing" = "Mowing.Frequency", 
                               "grazing" = "Grazing.Pressure", 
                               "soil dist." = "Soil.Disturbance")) -> 
  vars

### Centroids

inds %>%
  group_by(PCA, Class) %>%
  summarise(Dim.1 = mean(Dim.1),
            Dim.2 = mean(Dim.2)) -> cents

cents %>%
  rename(oDim.1 = Dim.1,
         oDim.2 = Dim.2) %>%
  merge(inds) -> segs

### Plot

ggplot(inds, aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  facet_wrap(~ PCA, scales = "free") +
  scale_color_manual(name = "Vegetation class",
                     values = c("grey40",
                                "cadetblue4",
                                "chocolate1", 
                                "chocolate4",
                                "firebrick3",
                                "khaki1",
                                "darkmagenta", 
                                "limegreen",
                                "goldenrod1")) +
  #coord_fixed() +
  geom_segment(data = segs, 
               mapping = aes(xend = oDim.1, yend = oDim.2, color = Class), 
               show.legend = TRUE, alpha = 0.4, key_glyph = draw_key_point) +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = scales::label_number(accuracy = 0.1)) +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "bottom", 
        #legend.direction = "vertical",
        legend.title = element_text(size = 10),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        # strip.text = element_text(size = 12, hjust = 0, margin = margin(l = 0, b = 4)),
        strip.text = element_blank(),
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text.x = element_text(size = 8, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0.25,0.5,0,0.2), "cm")) +
  guides(colour = guide_legend(override.aes = list(alpha = 1))) -> 
  Fig3A; Fig3A

ggplot(vars, aes(Dim.1, Dim.2)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  facet_wrap(~ PCA, scales = "free") +
  geom_segment(aes(x = 0, y = 0, xend = Dim.1, yend = Dim.2), arrow = arrow(length = unit(1/2, "picas")), color = "grey60") +
  ggrepel::geom_text_repel(aes(x = Dim.1, y = Dim.2, label = Variable),  show.legend = FALSE, size = 3) +
  #coord_fixed() +
  ggthemes::theme_tufte() +
  xlab("PCA1") + ylab("PCA2") +
  scale_y_continuous(labels = scales::label_number(accuracy = 0.01)) +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "bottom", 
        legend.direction = "vertical",
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 9, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 12, hjust = 0, margin=margin(l = 0, b = 4)),
        # strip.text = element_blank(),
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.title.x = element_blank(),
        axis.text.x = element_text(size = 8, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0.5,0.5,0,0.2), "cm")) -> 
  Fig3B; Fig3B

### Merge

cowplot::plot_grid(Fig3B, Fig3A, ncol = 1) -> Fig3

ggsave(Fig3, file = "results/figures/cwms.png", bg = "white", 
       path = NULL, scale = 1, width = 179, height = 140, units = "mm", dpi = 600)

