rm(list = ls())

library(tidyverse)

### Reciprocal averaging

read.csv("data/traits.csv", fileEncoding = "latin1") %>%
  select(Analysis.Names,
         bryophyte:phanerophyte) %>%
  gather(Trait, Value,
         bryophyte:phanerophyte) %>%
  filter(Value == 1) %>%
  mutate(origin = ifelse(Trait == "therophyte", "Therophyte", "Other")) %>%
  mutate(origin = ifelse(Trait == "geophyte", "Geophyte", origin)) %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1"), all.y = TRUE) %>%
  group_by(SIVIMID, origin) %>%
  summarise(y = length(Analysis.Names)) %>%
  merge(read.csv("data/header.csv", fileEncoding = "latin1"), all.y = TRUE) %>%
  group_by(Class, Alliance, origin) %>%
  summarise(n = sum(y)) %>%
  na.omit() %>%
  group_by(Alliance) %>% 
  mutate(proportion = n / sum(n)) %>%
  group_by() %>% 
  filter(Alliance != "Noise") %>%
  mutate(origin = fct_relevel(origin, 
                              "Other",
                              "Geophyte",
                              "Therophyte")) %>%
  mutate(origin = fct_recode(origin, 
                             "Natives" = "native",
                             "Archaeophytes" = "archaeophyte",
                             "Neophytes" = "neophyte")) %>%
  mutate(Alliance = fct_relevel(Alliance,
                                "Senecionion fluviatilis",
                                "Cynancho-Convolvulion sepium",
                                "Epilobion angustifolii",
                                "Aegopodion podagrariae",
                                "Balloto-Conion maculati",
                                "Arction lappae",
                                "Geo urbani-Alliarion officinalis",
                                "Dauco-Melilotion", 
                                "Cirsion richterano-chodati",
                                "Carduo carpetani-Cirsion odontolepidis",
                                "Silybo mariani-Urticion piluliferae",
                                "Convolvulo arvensis-Agropyrion repentis",
                                "Paspalo-Agrostion semiverticillati",
                                "Bidention tripartitae",
                                "Sisymbrion officinalis",
                                "Linario polygalifoliae-Vulpion alopecuri",
                                "Echio-Galactition tomentosae",
                                "Chenopodion muralis",
                                "Geranio pusilli-Anthriscion caucalidis",
                                "Allion triquetri",
                                "Spergulo arvensis-Erodion cicutariae",
                                "Oxalidion europeae",
                                "Scleranthion annui",
                                "Caucalidion lappulae",
                                "Saginion procumbentis",
                                "Polygono-Coronopodion",
                                "Polycarpion tetraphylli",
                                "Cymbalario-Asplenion", 
                                "Galio valantiae-Parietarion judaicae")) %>%
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
  ggplot(aes(as.factor(Alliance), proportion, fill = Class)) +
  geom_bar(position="stack", stat="identity", color = "black", aes(alpha = origin)
           , show.legend =  TRUE) +
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
  xlab("Alliance") + ylab("Proportion of therophytes, geophytes and other life forms at the plot level") +
  coord_flip() +
  scale_alpha_manual(name = "Species origin",values = c(.35, .65, 1), guide = "none") +
  theme(text = element_text(family = "sans"),
        strip.background = element_blank(),
        legend.position = "right", 
        #legend.direction = "vertical",
        legend.title = element_text(size = 10),
        legend.spacing.x = unit(0, "mm"),
        legend.spacing.y = unit(0, "mm"),
        legend.text = element_text(size = 10, face = "italic"), 
        panel.background = element_rect(color = "black", fill = NULL),
        strip.text = element_text(size = 12, hjust = 0, margin = margin(l = 0, b = 4)),
        #strip.text = element_blank(),
        plot.title = element_text(size = 11),
        axis.title = element_text(size = 10),
        axis.title.y = element_blank(),
        axis.text.x = element_text(size = 10, color = "black"),
        axis.text.y = element_text(size = 8, color = "black", face = "italic"),
        plot.margin = unit(c(0,0,0,0), "cm")) +
  geom_hline(yintercept = 0.5, linetype = "dashed") -> Fig4; Fig4

ggsave(Fig4, file = "results/figures/F4 - lifeforms.png", bg = "white", 
       path = NULL, scale = 1, width = 180, height = 90, units = "mm", dpi = 600)
