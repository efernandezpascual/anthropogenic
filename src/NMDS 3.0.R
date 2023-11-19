library(tidyverse); library(vegan)

read.csv("data/urban-header-3.0.csv", fileEncoding = "latin1") %>%
  filter(Semisupervised == 1) -> header

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### NMDS

header %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 1000, k = 2) ->
  nmds # Ordination output


save(nmds, file = "results/NMDS3.0.RData")

vegan::scores(nmds) -> s1

s1$sites %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header, by = "SIVIMID") -> headerNMDS

write.csv(headerNMDS, "results/NMDS3.0.RData.csv")

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 6) %>%
  select(Alliance, Class) %>%
  merge(read.csv("results/NMDS3.0.RData.csv")) -> headerNMDS



headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Revised.alliance)), show.legend = T)

headerNMDS %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = as.factor(Class)), show.legend = T, alpha = 0.6, size = 3) +
  coord_cartesian(xlim = c(-.05, .05))

headerNMDS %>% filter(NMDS1 < -0.05)

headerNMDS %>% filter(NMDS1 < -0.1) %>% select(SIVIMID) %>% merge(species) %>%
  arrange(SIVIMID, -Cover.percent)

headerNMDS %>% filter(NMDS1 > 0.05)

headerNMDS %>% filter(NMDS1 > 0.5) %>% select(SIVIMID) %>% merge(species) %>%
  arrange(SIVIMID, -Cover.percent)

headerNMDS %>% filter(NMDS2 < -0.05)
headerNMDS %>% filter(NMDS2 > 0.05)

headerNMDS %>%
  group_by(Revised.alliance) %>%
  summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_text(aes(label = Revised.alliance, color = as.factor(Revised.alliance)), show.legend = T) 




openxlsx::read.xlsx("data/urban-traits.xlsx") %>%
  mutate(height = as.numeric(height),
         heightMAX = as.numeric(heightMAX),
         flowering1 = fct_recode(flowering1,
                                 "1" = "I",
                                 "2" = "II",
                                 "3" = "III",
                                 "4" = "IV",
                                 "5" = "V",
                                 "6" = "VI",
                                 "7" = "VII",
                                 "8" = "VIII",
                                 "9" = "IX",
                                 "10" = "X",
                                 "11" = "XI",
                                 "12" = "XII"),
         flowering1 = as.character(flowering1),
         flowering1 = as.numeric(flowering1),
         flowering2 = fct_recode(flowering2,
                                 "1" = "I",
                                 "2" = "II",
                                 "3" = "III",
                                 "4" = "IV",
                                 "5" = "V",
                                 "6" = "VI",
                                 "7" = "VII",
                                 "8" = "VIII",
                                 "9" = "IX",
                                 "10" = "X",
                                 "11" = "XI",
                                 "12" = "XII"),
         flowering2 = as.character(flowering2),
         flowering2 = as.numeric(flowering2),
         flowering3 = (flowering1 + flowering2) / 2,
         Alien = fct_recode(Native, 
                            "1" = "No",
                            "0" = "Yes"),
         Alien = as.character(Alien),
         Alien = as.numeric(Alien),
         Annual = ifelse(Lifeform == "Therophyte", 1, 0),
         Annual = as.character(Annual),
         Annual = as.numeric(Annual)) %>%
  select(Analysis.Names, 
         height:flowering2,
         flowering3,
         Alien, 
         Annual,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.L,
         EIVE1.T,
         Disturbance.Severity,
         Disturbance.Frequency,
         Mowing.Frequency,
         Grazing.Pressure,
         Soil.Disturbance) %>%
  gather(Trait, Value,  height:Soil.Disturbance) %>%
  na.omit -> traits

### Calculate CWMs

species %>%
  merge(traits, by = "Analysis.Names") %>%
  merge(headerNMDS, by = "SIVIMID") %>%
  group_by(SIVIMID, Class, Trait) %>%
  summarise(CWM = weighted.mean(Value, Cover.percent, na.rm = TRUE)) -> cwms

# cwms %>%
#   group_by(EUNISL2, Trait) %>%
#   summarise(CWM = mean(CWM)) %>%
#   spread(EUNISL2, CWM) %>%
#   write.csv("results/CWMs.csv")

### PCA

cwms %>%
  spread(Trait, CWM) -> matriz

matriz %>%
  group_by() %>%
  select(-c(SIVIMID, Class, flowering1:flowering2, heightMAX)) %>%
  FactoMineR::PCA() -> pca1


cbind((matriz %>%  dplyr::select(Class)), data.frame(pca1$ind$coord[, 1:2])) -> pcaInds

pca1$var$coord[, 1:2] %>%
  data.frame %>%
  rownames_to_column(var = "Variable") -> pcaVars

### Plot PCA

ggplot(pcaInds, aes(x = Dim.1, y = Dim.2)) +
  coord_fixed() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_point(aes(color = Class), size = 3, alpha = .6) +
  geom_segment(data = pcaVars, aes(x = 0, y = 0, xend = 4.5*Dim.1, yend = 4.5*Dim.2)) +
  ggrepel::geom_label_repel(data = pcaVars, aes(x = 4.5*Dim.1, y = 4.5*Dim.2, label = Variable),  show.legend = FALSE, size = 4) +
  ggthemes::theme_tufte() + 
  theme(text = element_text(family = "sans"),
        legend.position = "right", 
        legend.title = element_blank(),
        legend.text = element_text(size = 12, color = "black"),
        panel.background = element_rect(color = "black", fill = NULL),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12, color = "black"),
        plot.margin = unit(c(0, 0.1, 0, 0), "cm")) +
  guides(fill = guide_legend(override.aes = list(shape = 22))) +
  scale_x_continuous(name = paste("Axis 1 (", round(pca1$eig[1, 2], 0),
                                  "% variance explained)", sep = "")) + 
  scale_y_continuous(name = paste("Axis 2 (", round(pca1$eig[2, 2], 0), 
                                  "% variance explained)", sep = "")) -> f1; f1

pca1$eig
pca1$var
