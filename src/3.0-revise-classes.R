library(tidyverse); library(vegan)

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 6) %>%
  select(Alliance, Class) %>% 
  unique -> classes

openxlsx::read.xlsx("data/urban-sintaxa.xlsx", sheet = 4) %>%
  select(Alliance, Sintaxon) %>% 
  unique -> sintaxa

merge(sintaxa, classes) -> sintaxonomy

read.csv("data/urban-header-3.0.csv", fileEncoding = "latin1") %>%
  select(-Alliance) %>%
  select(-Semisupervised) %>%
  merge(sintaxonomy, all.x = TRUE) %>%
  mutate(Alliance = ifelse(is.na(Alliance), "Unknown", Alliance)) %>%
  mutate(Semisupervised = ifelse(Revised.alliance == Alliance, 1, 0)) -> header

header %>% filter(Semisupervised == 1) %>% group_by(Alliance, Revised.alliance) %>% tally() %>% data.frame

read.csv("data/urban-species-3.0.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species


### NMDS

# header %>%
#   merge(species, by = "SIVIMID") %>%
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 1000, k = 2) ->
#   nmds # Ordination output
#
# save(nmds, file = "results/NMDS3.0.RData")
# 
# vegan::scores(nmds) -> s1
# 
# s1$sites %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header, by = "SIVIMID") -> headerNMDS
# 
# write.csv(headerNMDS, "results/NMDS3.0.RData.csv")



### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>%
  merge(kclusters, by = "SIVIMID") -> header2

df1 %>% rownames_to_column(var = "SIVIMID") %>% merge(header2, by = "SIVIMID") -> df1b

adonis2(df1 ~ Cluster, data = df1b, permutations = 9999)

anova(betadisper(vegdist(df1, method = "euclidean"), df1b$Cluster))

pairwise.perm.manova(dist(df1, "euclidian"), df1b$Cluster, nperm = 9999, p.method = "holm")

### Expert system

header2 %>%
  group_by(Cluster, EUNIS2020) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Sintaxa

header2 %>%
  group_by(Cluster, Class) %>%
  tally %>%
  arrange(Cluster, -n) %>%
  data.frame

### Constant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(F = length(Analysis.Names)) %>%
  group_by(Cluster) %>%
  slice_max(F, n = 5)

### Dominant

species %>%
  merge(header2, by = "SIVIMID") %>%
  group_by(Cluster, Analysis.Names) %>%
  summarise(D = sum(Cover.percent)) %>%
  group_by(Cluster) %>%
  slice_max(D, n = 5) %>%
  data.frame

### Indicator spp

library(labdsv)

species %>%
  merge(header2, by = "SIVIMID") %>%
  select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) -> plots

plots %>%
  pull(Cluster) -> groups

levels(groups) -> group.labels

plots %>%
  select(-c(SIVIMID, Cluster)) %>%
  indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  group_by(Community) %>%
  slice_max(Indicator, n = 4) %>%
  data.frame


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







## DCA ORDINATION OF THE PLOTS (ORDENACION)


header %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df4
  
decorana(df4) -> dca1

## CALCULATE TWINSPAN CLUSTERS (CLASIFICACION)

twinspanR::twinspan(df4, modif = T, clusters = 9) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df4) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

## MERGE CLUSTERS AND ORDINATION

scores(dca1) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(headerNMDS, by = "SIVIMID") %>%
  merge(kclusters, by = "SIVIMID") %>%
  mutate(Cluster = as.factor(Cluster)) -> df5

## TEST FOR SIGNIFICANT CLUSTERS

df4 %>% rownames_to_column(var = "SIVIMID") %>% merge(df5, by = "SIVIMID") -> df4b

adonis(df4 ~ Cluster, data = df4b, permutations = 9999)

anova(betadisper(vegdist(df4, method = "euclidean"), df4b$Cluster))

pairwise.perm.manova(dist(df4, "euclidian"), df4b$Cluster, nperm = 9999, p.method = "holm")






## EXPLORE CLUSTER PHYTOSOCIOLOGY

df5 %>% group_by(Cluster, Class) %>% tally %>% arrange(Cluster, -n) %>% data.frame

df5 %>% group_by(Cluster, Alliance) %>% summarise(n = length(Alliance)) %>% data.frame %>%
  group_by(Cluster) %>% filter(n == max(n))

df5 %>% group_by(Cluster, Community) %>% summarise(n = length(Community)) %>% data.frame

## EXPLORE CLUSTER GEOGRAPHY

df5 %>% group_by(Cluster) %>%
  summarise(Elevation_median =  median(Elevation),
            Elevation_mean =  mean(Elevation),
            Elevation_min =  min(Elevation),
            Elevation_max =  max(Elevation))

df5 %>% group_by(Cluster) %>%
  summarise(Longitude_median =  median(Longitude),
            Longitude_mean =  mean(Longitude),
            Longitude_min =  min(Longitude),
            Longitude_max =  max(Longitude))

df5 %>% group_by(Cluster) %>%
  summarise(Latitude_median =  median(Latitude),
            Latitude_mean =  mean(Latitude),
            Latitude_min =  min(Latitude),
            Latitude_max =  max(Latitude))

ggplot(df5, aes(x = Longitude, y = Latitude, color = Cluster)) + 
  geom_polygon(data = map_data("worldHires"), aes(x = long, y = lat, group = group), color = "grey") + 
  geom_text(aes(label = Cluster)) +
  coord_cartesian(xlim = c(-10, -4), ylim = c(40, 46))  

## EXPLORE CLUSTER DIAGNOSTIC SPECIES

df5 %>% pull(Cluster) -> groups

levels(as.factor(groups)) -> group.labels

df4 %>% indval(groups, numitr = 10000) -> indicators

data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
           p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
  rownames_to_column(var = "Species") %>%
  mutate(Community = factor(Community, labels = group.labels)) %>%
  filter(p_adj <= 0.05) -> best.indicators
best.indicators %>% arrange(Community)

## SELECT SPECIES FOR THE PLOT

scores(dca1, "species") %>%
  data.frame() %>%
  rownames_to_column("Species") %>%
  merge(best.indicators, by = "Species") -> 
  sppscores

## CALCULATE CLUSTER CENTROIDS

cent <- aggregate(cbind(DCA1, DCA2) ~ Cluster, data = df5, FUN = mean)
segs <- merge(df5, setNames(cent, c("Cluster", "oDCA1", "oDCA2")), by = "Cluster", sort = FALSE)

## DCA PLOT

df5 %>%
  ggplot(aes(x = DCA1, y = DCA2)) + 
  geom_segment(data = segs, mapping = aes(xend = oDCA1, yend = oDCA2, color = Cluster), show.legend = F) +
  geom_label_repel(data = sppscores, aes(x = DCA1, y = DCA2, label = Species, color = Community), 
                   size = 2, fontface = "italic", show.legend = F) +
  geom_point(data = cent, size = 5, aes(color = Cluster), show.legend = T) + 
  theme(legend.position = "top", legend.title = element_blank(), 
        legend.justification = c(0.5, 0.5), 
        legend.margin = margin(t = 0, r = 0, b = -0.4, l = 0, unit = "cm"),
        plot.margin = unit(x = c(0, 0, 0, 0), units = "cm"),
        plot.title = element_text(size = 16))+
  geom_point(data = subset(df5, Locality %in% c("Comeya", "Liordes")), 
             aes(x = DCA1, y = DCA2, color = Cluster), alpha= 0.3, size = 4, show.legend = F) +
  geom_label_repel(data = subset(df5, Locality %in% c("Comeya", "Liordes")), 
                   aes(label = Community, x = DCA1, y = DCA2, color = Cluster), show.legend = F)
