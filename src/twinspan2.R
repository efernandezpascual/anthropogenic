library(tidyverse); library(vegan)

read.csv("data/species.csv") -> species
read.csv("results/twinspan-header.csv") -> header

header %>%
  group_by(Cluster, EUNIS) %>%
  tally() %>%
  ggplot(aes(Cluster, n, fill = EUNIS)) +
  geom_bar(position = "fill", stat = "identity")

header %>%
  group_by(Cluster, EUNIS) %>%
  tally() %>%
  filter(EUNIS == "?")

### Cluster 1 (comunidades pisoteadas)

# header %>%
#   filter(Cluster == 1) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output

# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_point(aes(color = Sintaxon), show.legend = F) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)
# 
header %>%
  filter(Cluster == 1) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 1) %>%
  filter(Sintaxon %in% c("Inulo crithmoidis-Elymetum pycnanthi",
                         "Junco compressi-Caricetum divisae",
                         "Glycerio-Sparganion",
                         "Euphorbio-Agropyretum junceiformis",
                         "Comunidades higrófilas", 
                         "Comunidad de Typha latifolia",
                         "Beto maritimae-Lavateretum arboreae",
                         "Sagina maritimae-Catapodietum maritimae",
                         "Honkenyo-Euphorbietum peplis",
                         "Picrido echioidis-Raphanetum maritimi")) %>%
  pull(SIVIMID) -> no1

### Cluster 2 (malas hierbas)

# header %>%
#   filter(Cluster == 2) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output

# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_point(aes(color = Sintaxon)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 2) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 2) %>%
  filter(Sintaxon %in% c("Violo henriquesii-Silenetum littoreae",
                         "Iberidetum procumbentis",
                         "Euphorbio paraliae-Agropyretum junceiformis",
                         "Chaenorhino reyesii-Campanuletum fastigiatae")) %>%
  pull(SIVIMID) -> no2

### Cluster 3 (comunidades terofíticas de montaña med)

# header %>%
#   filter(Cluster == 4) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_point(aes(color = Sintaxon)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 3) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 3) %>%
  pull(SIVIMID) -> no3

### Cluster 4 (malas hierbas cultivos cerealistas submed)

# header %>%
#   filter(Cluster == 4) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_point(aes(color = Sintaxon)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 4) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 4) %>%
  filter(Sintaxon %in% c("Anogrammo leptophyllae-Parietarietum lusitanicae",
                         "Stellario alsines-Montietum",
                         "Violo henriquesii-Silenetum littoreae",
                         "Chaenorhino reyesii-Campanuletum fastigiatae")) %>%
  pull(SIVIMID) -> no4

### Cluster 5 (comunidades halófilas marinas)

# header %>%
#   filter(Cluster == 5) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 5) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 5) %>%
  pull(SIVIMID) -> no5

### Cluster 6 (malas hierbas de cultivos cerealistas submediterráneos)

# header %>%
#   filter(Cluster == 6) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 6) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

### Cluster 7 (más comunidades terofíticas mediterráneas)

# header %>%
#   filter(Cluster == 7) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 7) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 7) %>%
  pull(SIVIMID) -> no7

### Cluster 8 (pastizales terofíticos subnitrófilos mediterráneos)

header %>%
  filter(Cluster == 8) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n) %>%
  data.frame

header %>%
  filter(Cluster == 8) %>%
  pull(SIVIMID) -> no8

### Cluster 9 (gleras)

header %>%
  filter(Cluster == 9) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n) %>%
  data.frame

header %>%
  filter(Cluster == 9) %>%
  pull(SIVIMID) -> no9

### Cluster 10 (linderos de bosque)

header %>%
  filter(Cluster == 10) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n) %>%
  data.frame

header %>%
  filter(Cluster == 10) %>%
  pull(SIVIMID) -> no10

### Cluster 11 (malas hierbas de cultivos cerealistas mediterráneos, marginal a la ecorregión)

header %>%
  filter(Cluster == 11) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n) %>%
  data.frame

header %>%
  filter(Cluster == 11) %>%
  pull(SIVIMID) -> no11

### Cluster 12 (malas hierbas de cultivos de hortalizas)

# header %>%
#   filter(Cluster == 12) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   # group_by(Sintaxon) %>%
#   # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = FALSE)

header %>%
  filter(Cluster == 12) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 12) %>%
  filter(Sintaxon %in% c("Honkenyo-Euphorbietum peplis",
                         "comunidad de Phalaris arundinacea",
                         "Inulo crithmoidis-Elymetum pycnanthi",
                         "Glycerietum plicatae")) %>%
  pull(SIVIMID) -> no12

### Cluster 13 (comunidades de muros)

# header %>%
#   filter(Cluster == 13) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 500, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon))

header %>%
  filter(Cluster == 13) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n)

header %>%
  filter(Cluster == 13) %>%
  filter(Sintaxon %in% c("Anogramma leptophylla-Davallia canariensis",
                         "Anogrammo leptophyllae-Parietarietum lusitanicae",
                         "Anogrammo leptophyllae-Umbilicetum rupestris",
                         "Lunulario-Anogrammetum leptophyllae")) %>%
  pull(SIVIMID) -> no13

### Cluster 14 (nitrófilas de lindero)

# header %>%
#   filter(Cluster == 14) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 14) %>%
  group_by(Sintaxon) %>%
  tally() %>%
  arrange(-n) %>% data.frame

### Cluster 15 (nitrófilas de lindero)

# header %>%
#   filter(Cluster == 15) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 15) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 15) %>%
  filter(Sintaxon %in% c("Saxifragion praetermissae",
                         "Linarion triornithophorae",
                         "Comunidades de Cytisus sp.")) %>%
  pull(SIVIMID) -> no15

### Cluster 16 (nitrófilas)

# header %>%
#   filter(Cluster == 16) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 16) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 16) %>%
  filter(Sintaxon %in% c("Comunidad de Typha latifolia",
                         "Aconitetum neapolitano-vulgare",
                         "Comunidades de Cytisus sp.")) %>%
  pull(SIVIMID) -> no16

### Cluster 17 (pastos y nitrófilas mediterráneas)

# header %>%
#   filter(Cluster == 17) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 17) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 17) %>%
  pull(SIVIMID) -> no17

### Cluster 18 (guijarrales de rios)

# header %>%
#   filter(Cluster == 17) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 18) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 18) %>%
  pull(SIVIMID) -> no18

### Cluster 19 (megaforbios naturales)

# header %>%
#   filter(Cluster == 19) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 19) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 19) %>%
  pull(SIVIMID) -> no19

### Cluster 20 (megaforbios naturales)

# header %>%
#   filter(Cluster == 20) %>%
#   merge(species, by = "SIVIMID") %>% 
#   select(SIVIMID, Analysis.Names, Cover.percent) %>%
#   spread(Analysis.Names, Cover.percent, fill = 0) %>%
#   column_to_rownames(var = "SIVIMID") %>%
#   metaMDS(trymax = 100, k = 2) -> 
#   nmds # Ordination output
# 
# scores(nmds) %>%
#   data.frame() %>%
#   rownames_to_column("SIVIMID") %>%
#   merge(header) %>%
#   group_by(Sintaxon) %>%
#   summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
#   ggplot(aes(x = NMDS1, y = NMDS2)) +
#   geom_text(aes(label = Sintaxon, color = Sintaxon), show.legend = F)

header %>%
  filter(Cluster == 20) %>%
  group_by(Sintaxon) %>%
  tally() %>% 
  arrange(-n) %>% data.frame()

header %>%
  filter(Cluster == 20) %>%
  filter(Sintaxon %in% c("Rhamno-Juniperetum lyciae",
                         "Cryptogrammo crispae-Dryopteridetum oreadis",
                         "Ranunculetum saniculifolii")) %>%
  pull(SIVIMID) -> no20

### Plots to remove

c(no1, no10, no11, no12, no13, no15, no16, no17, no18, no19,
  no2, no20,
  no3, no4, no5, no7, no8, no9) -> noes

header %>%
  filter(! SIVIMID %in% noes) -> header2

### New groups

header2 %>%
  group_by(Cluster, EUNIS) %>%
  tally() %>%
  ggplot(aes(Cluster, n, fill = EUNIS)) +
  geom_bar(position = "fill", stat = "identity")

header2 %>%
  group_by(Cluster, EUNIS) %>%
  tally() %>% data.frame %>%
  arrange(Cluster, -n)

header2 %>%
  mutate(Twinspan1 = fct_recode(as.factor(Cluster), 
                                "Walls" = "13",
                                "Trampled (V35)" = "1",
                                "Weeds (V15)" = "2",
                                "Weeds (V15)" = "4",
                                "Weeds (V15)" = "6",
                                "Weeds (V15)" = "12",
                                "Mesic ruderals (V39)" = "14",
                                "Mesic ruderals (V39)" = "15",
                                "Xeric ruderals (V38)" = "16",
                                "Xeric ruderals (V38)" = "20")) ->
  header3

header3 %>%
  group_by(Twinspan1) %>%
  tally()

species %>%
  filter(SIVIMID %in% header3$SIVIMID) -> species3

### New twinspan

### Format species for twinspan

species3 %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>% 
  column_to_rownames(var = "SIVIMID") -> df1

### Twinspan clusters

twinspanR::twinspan(df1, modif = T, clusters = 5) %>% ## IR INCREMENTANDO EL NUMERO DE CLUSTERS
  cut() %>%
  cbind(df1) %>% 
  select(".") %>% 
  rename("Cluster" = ".") %>%
  rownames_to_column(var = "SIVIMID") -> kclusters

### Merge clusters and ordination

header3 %>%
  merge(kclusters, by = "SIVIMID") %>%
  select(-c(DCA1, DCA2, Cluster.x)) %>%
  rename(Twinspan2 = Cluster.y) -> header4

header4 %>%
  group_by(Twinspan1, Twinspan2) %>%
  tally %>%
  arrange(Twinspan2, -n)

header4 %>%
  mutate(Twinspan2 = fct_recode(as.factor(Twinspan2), 
                                "Walls" = "5",
                                "Trampled (V35)" = "2",
                                "Weeds (V15)" = "1",
                                "Mesic ruderals (V39)" = "3",
                                "Xeric ruderals (V38)" = "4")) -> header5


header5 %>%
  select(`Relevé.number`, Twinspan2, Class, EUNIS, Sintaxon, SIVIMID, Plant.Cover,
         Aspect, Slope, Area, Year, DEG_LON, DEG_LAT,
         Accuracy, Elevation) %>%
  rename(`Releve number` = Relevé.number) -> headerJUICE

species3 %>%
  rename(`Releve number` = Releve.number) -> speciesJUICE

write.csv(headerJUICE, "results/twinspan2-headerJUICE.csv", row.names = FALSE)
write.csv(speciesJUICE, "results/twinspan2-speciesJUICE.csv", row.names = FALSE)

write.csv(header5, "results/twinspan2-header.csv", row.names = FALSE)
write.csv(species3, "results/twinspan2-species.csv", row.names = FALSE)


### New NMDS

header5 %>%
  merge(species, by = "SIVIMID") %>%
  select(SIVIMID, Analysis.Names, Cover.percent) %>%
  spread(Analysis.Names, Cover.percent, fill = 0) %>%
  column_to_rownames(var = "SIVIMID") %>%
  metaMDS(trymax = 100, k = 2) ->
  nmds # Ordination output

scores(nmds) %>%
  data.frame() %>%
  rownames_to_column("SIVIMID") %>%
  merge(header5) -> header6

write.csv(header6, "results/twinspan2-header.csv", row.names = FALSE)

header6 %>%
  filter(NMDS1 > -1) %>%
  # group_by(Twinspan2) %>%
  # summarise(NMDS1 = mean(NMDS1), NMDS2 = mean(NMDS2)) %>%
  ggplot(aes(x = NMDS1, y = NMDS2)) +
  geom_point(aes(color = Twinspan2)) +
  geom_text(aes(label = Sintaxon))
