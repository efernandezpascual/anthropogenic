rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

### DCA

species %>%
  merge(header) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

decorana(df1) -> dca1

### Paint by classes

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Class)) %>%
  mutate(Cluster = fct_recode(Cluster, 
                              "Artemisietea" = "Artemisietea vulgaris",
                              "Parietarietea" = "Cymbalario-Parietarietea diffusae",
                              "Digitario-Eragrostietea" = "Digitario sanguinalis-Eragrostietea minoris",
                              "Epilobietea" = "Epilobietea angustifolii",
                              "Papaveretea" = "Papaveretea rhoeadis",
                              "Polygono-Poetea" = "Polygono-Poetea annuae")) -> df2

aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean)%>%
  mutate(DCA1 = ifelse(Cluster == "Parietarietea", DCA1+.06, DCA1))%>%
  mutate(DCA1 = ifelse(Cluster == "Chenopodietea", DCA1-.06, DCA1))%>%
  mutate(DCA2 = ifelse(Cluster == "Papaveretea", DCA2+.08, DCA2))%>%
  mutate(DCA2 = ifelse(Cluster == "Sisymbrietea", DCA2-.08, DCA2)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) -> segs

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = FALSE, alpha = 0.5) +
  geom_text(data = cent, aes(label = Cluster), size = 2.5) +
  ggthemes::theme_tufte() +
  coord_fixed() +
  labs(title = "(A) Vegetation classes") +
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
        strip.text = element_text(size = 10),
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text.x = element_text(size = 10, color = "black"),
        axis.text.y = element_text(size = 10, color = "black"),
        plot.margin = unit(c(0,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("darkmagenta",  
                                "goldenrod1", 
                                "firebrick3", 
                                "grey40",
                                "chocolate4", 
                                "limegreen",
                                "chocolate1",  
                                "cadetblue4", 
                                "khaki1")) -> Fig1A; Fig1A

### Paint by alliances

vegan::scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header) %>%
  mutate(Cluster = as.factor(Alliance)) %>%
  mutate(Cluster = fct_relevel(Cluster, 
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
                                "Convolvulo arvensis-Agropyrion repentis",
                                "Carduo carpetani-Cirsion odontolepidis",
                                "Silybo mariani-Urticion piluliferae", 
                                "Cirsion richterano-chodati",
                                "Dauco-Melilotion",
                                "Geo urbani-Alliarion officinalis",
                                "Arction lappae",
                                "Balloto-Conion maculati",
                                "Aegopodion podagrariae",
                                "Epilobion angustifolii",
                                "Cynancho-Convolvulion sepium",
                                "Senecionion fluviatilis",
                                "Bidention tripartitae",
                                "Paspalo-Agrostion semiverticillati")) %>%
  mutate(Cluster = as.numeric(Cluster)) -> df2

aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df2, FUN = mean) %>%
  mutate(DCA1 = ifelse(Cluster == 18, DCA1+.05, DCA1)) %>%
  mutate(DCA1 = ifelse(Cluster == 25, DCA1-.05, DCA1))%>%
  mutate(DCA1 = ifelse(Cluster == 23, DCA1+.1, DCA1))%>%
  mutate(DCA1 = ifelse(Cluster == 22, DCA1-.25, DCA1)) -> cent
merge(df2, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE) %>%
  mutate(Group = paste(Cluster, Alliance)) %>%
  mutate(Group = fct_reorder(Group, Cluster)) -> segs

df2 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Group), show.legend = TRUE, alpha = 0.4, key_glyph = "blank") +
  geom_text(data = cent, aes(label = Cluster), size = 2) +
  ggthemes::theme_tufte() +
  coord_fixed() +
  labs(title = "(B) Vegetation alliances") +
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
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text.x = element_text(size = 10, color = "black"),
        axis.text.y = element_text(size = 10, color = "black"),
        plot.margin = unit(c(0,0.2,0,0.2), "cm")) +
  scale_color_manual(values = c("grey40",
                                "grey40",
                                "cadetblue4",
                                "cadetblue4",
                                "cadetblue4",
                                "chocolate1",
                                "chocolate1",
                                "chocolate1",
                                "chocolate4", 
                                "firebrick3", 
                                "firebrick3",
                                "firebrick3",
                                "firebrick3",
                                "firebrick3",
                                "khaki1",
                                "darkmagenta", 
                                "darkmagenta",  
                                "darkmagenta",  
                                "darkmagenta",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "limegreen",
                                "goldenrod1",
                                "goldenrod1")) -> Fig1B; Fig1B

### Merge

cowplot::plot_grid(Fig1A, Fig1B, ncol = 2) -> Fig1

ggsave(Fig1, file = "results/figures/dca.png", bg = "white", 
       path = NULL, scale = 1, width = 179, height = 90, units = "mm", dpi = 600)

