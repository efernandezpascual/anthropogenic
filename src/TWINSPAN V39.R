library(tidyverse); library(vegan)

### Relevés

read.csv("data/header-revised.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID != "R-P20727") %>% # Polygono maritimi-Elytrigietum athericae (halonitrófila)
  filter(CODE %in% c("V38a", "V38b", "V39a", "V39b", "V39c", "V39d", "V39e", "V39f")) -> header

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  filter(SIVIMID %in% header$SIVIMID) -> species

### Twinspan

species %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") -> df1

twinspanR::twinspan(df1, modif = T, clusters = 8) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>%
  select(".") %>%
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

header %>%
  merge(kclusters, by = "SIVIMID") -> header2

# ### Expert system
# 
# header2 %>%
#   group_by(Cluster, EUNIS2020) %>%
#   tally %>%
#   arrange(Cluster, -n) %>%
#   data.frame
# 
# ### Sintaxa
# 
# header2 %>%
#   group_by(Cluster, Alliance) %>%
#   tally %>%
#   arrange(Cluster, -n) %>%
#   data.frame
# 
# ### Code
# 
# header2 %>%
#   group_by(Cluster, CODE) %>%
#   tally %>%
#   arrange(Cluster, -n) %>%
#   data.frame
# 
# ### Constant
# 
# species %>% 
#   merge(header2) %>%
#   group_by(Cluster, Analysis.Names) %>%
#   summarise(F = length(Analysis.Names)) %>%
#   group_by(Cluster) %>%
#   slice_max(F, n = 4) %>% data.frame
# 
# ### Dominant
# 
# species %>% 
#   merge(header2) %>%
#   group_by(Cluster, Analysis.Names) %>%
#   summarise(D = sum(Cover.percent)) %>%
#   group_by(Cluster) %>%
#   slice_max(D, n = 4) %>% data.frame
# 
# ### Indicator spp
# 
# library(labdsv)
# 
# species %>%
#   merge(header2) %>%
#   select(Cluster, SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) -> plots
# 
# plots %>%
#   pull(Cluster) -> groups
# 
# levels(groups) -> group.labels
# 
# plots %>%
#   select(-c(SIVIMID, Cluster)) %>%
#   indval(groups, numitr = 10000) -> indicators
# 
# data.frame(Community = indicators$maxcls, Indicator = indicators$indcls,
#            p = indicators$pval, p_adj = p.adjust(indicators$pval, "holm")) %>%
#   rownames_to_column(var = "Species") %>%
#   group_by(Community) %>%
#   slice_max(Indicator, n = 5) %>%
#   data.frame
# 
# ### NMDS
# 
# library(vegan)
# 
# header2 %>%
#   merge(species, by = "SIVIMID") %>%
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 200, k = 2) ->
#   nmds # Ordination output
# 
# vegan::scores(nmds) -> s1
# 
# s1$sites %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header2, by = "SIVIMID") -> header2NMDS
# 
# # write.csv(header4NMDS, "data/urban-header-nmds.csv", fileEncoding = "latin1", row.names = FALSE)
# 
# header2NMDS %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_point(aes(color = as.factor(Cluster)), show.legend = T)

### C1 Balloto-Conion maculati
### C2 Arction lappae (spp de Cirsion pero overlaps con Arction en NMDS)
### C3 Arction lappae
### C4 Geo urbani-Alliarion officinalis
### C5 Geranio pusilli-Anthriscion caucalidis
### C6 Geo urbani-Alliarion officinalis
### C7 Cirsion richterano-chodati
### C8 Cirsion richterano-chodati

header2 %>%
  select(SIVIMID, Cluster) %>%
  mutate(Revised.sintaxon = fct_recode(as.factor(Cluster), 
                                      "Balloto-Conion maculati" = "1",
                                      "Arction lappae" = "2",
                                      "Arction lappae" = "3",
                                      "Geo urbani-Alliarion officinalis" = "4",
                                      "Geranio pusilli-Anthriscion caucalidis" = "5",
                                      "Geo urbani-Alliarion officinalis"  = "6",
                                      "Cirsion richterano-chodati"  = "7",
                                      "Cirsion richterano-chodati"  = "8")) %>%
  select(-Cluster) %>%
  write.csv("results/Revised V39.csv", row.names = FALSE, fileEncoding = "Latin1") 

         