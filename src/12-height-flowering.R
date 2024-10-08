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

load(file = "results/cwms/cwms.RData")

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
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
  gather(Trait, Value, floweringmean:EIVE1.L) %>%
  filter(Trait %in% c("heightmax", "floweringmean", "floweringwidth")) %>%
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
                            "(B) Median flowering month" = "floweringmean",
                            "(C) Flowering length (months)" = "floweringwidth",
                            "Neophytes (% of total cover)" = "neophyte",
                            "Geophytes (% of total cover)" = "geophyte",
                            "Therophytes (% of total cover)" = "therophyte",
                            "Temperature (indicator)" = "EIVE1.T",
                            "Moisture (indicator)" = "EIVE1.M",
                            "Light (indicator)" = "EIVE1.L",
                            "Nutrients (indicator)" = "EIVE1.N",
                            "Soil reaction (indicator)" = "EIVE1.R",
                            "Disturbance frequency (indicator)" = "Disturbance.Frequency",
                            "Disturbance severity (indicator)" = "Disturbance.Severity",
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
                               "Onopordion acanthii",
                               "Silybo mariani-Urticion piluliferae", 
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
        panel.spacing = unit(0.25, "lines"),
        #strip.text = element_blank(),
        plot.title = element_text(size = 10),
        axis.title = element_text(size = 10),
        axis.title.y = element_blank(),
        axis.text.x = element_text(size = 6, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0.1,0,0,0), "cm")) -> Fig4; Fig4

ggsave(Fig4, file = "results/figures/F5 - height-flowering.png", bg = "white", 
       path = NULL, scale = 1, width = 180, height = 85, units = "mm", dpi = 600)

