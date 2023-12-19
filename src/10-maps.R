rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") %>%
  filter(! Alliance %in% "Noise") %>%
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
                            "Polygono-Poetea" = "Polygono-Poetea annuae"))%>%
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
  mutate(Alliance = fct_recode(Alliance, 
                               "Galio valantiae-\nParietarion judaicae" = "Galio valantiae-Parietarion judaicae",
                                # "Cymbalario-Asplenion",
                                # "Polycarpion tetraphylli",
                                # "Polygono-Coronopodion",
                                # "Saginion procumbentis",
                                # "Scleranthion annui",
                                # "Oxalidion europeae",
                               "Convolvulo arvensis-\nAgropyrion repentis" = "Convolvulo arvensis-Agropyrion repentis",
                               "Silybo mariani-\nUrticion piluliferae" = "Silybo mariani-Urticion piluliferae", 
                               "Spergulo arvensis-\nErodion cicutariae" = "Spergulo arvensis-Erodion cicutariae",
                                # "Allion triquetri",
                               "Geranio pusilli-\nAnthriscion caucalidis" = "Geranio pusilli-Anthriscion caucalidis",
                               "Echio-\nGalactition tomentosae" = "Echio-Galactition tomentosae",
                               "Linario polygalifoliae-\nVulpion alopecuri" = "Linario polygalifoliae-Vulpion alopecuri",
                                # "Sisymbrion officinalis",
                               "Carduo carpetani-\nCirsion odontolepidis" = "Carduo carpetani-Cirsion odontolepidis",
                               "Cirsion\nrichterano-chodati" = "Cirsion richterano-chodati",
                                # "Dauco-Melilotion",
                               "Geo urbani-\nAlliarion officinalis" = "Geo urbani-Alliarion officinalis",
                                # "Arction lappae",
                                # "Balloto-Conion maculati",
                                # "Aegopodion podagrariae",
                                # "Epilobion angustifolii",
                               "Cynancho-\nConvolvulion sepium" = "Cynancho-Convolvulion sepium",
                                # "Senecionion fluviatilis",
                                # "Bidention tripartitae",
                               "Paspalo-\nAgrostion semiverticillati" = "Paspalo-Agrostion semiverticillati"))-> 
  header

### Map

rgdal::readOGR(dsn = "data/map", layer = "IberoAtlantic") -> Ecoregions # Map files are in my home drive

header %>%
  ggplot(aes(Longitude, Latitude)) +
  facet_wrap( ~ Alliance, ncol = 5) +
  geom_polygon(data = Ecoregions, aes(x = long, y = lat, group = group), 
               color = "black", fill = "gainsboro", size = 0.25, show.legend = FALSE) +
  geom_point(aes(color = Class), show.legend = TRUE, alpha = 0.4) +
  ggthemes::theme_tufte() +
  coord_fixed() +
  xlab("Longitude (º)") + ylab("Latitude (º)") +
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
        strip.text = element_text(size = 8, face = "italic"),
        # strip.text = element_blank(),
        plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text.x = element_text(size = 8, color = "black"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.margin = unit(c(0,0.2,0,0.2), "cm")) +
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
  guides(colour = guide_legend(override.aes = list(alpha = 1))) -> Fig2; Fig2

ggsave(Fig2, file = "results/figures/maps.png", bg = "white", 
       path = NULL, scale = 1, width = 179, height = 160, units = "mm", dpi = 600)

