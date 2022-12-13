library(tidyverse)

read.csv("data/urban-species-revised5.csv", fileEncoding = "latin1") -> species
read.csv("data/urban-header-revised8.csv", fileEncoding = "latin1") -> header

### Prepare WWF shapefiles

rgdal::readOGR(dsn = "../splot12db/data/maps/WWF", 
               layer = "wwf_terr_ecos") -> Ecoregions # Map files are in my home drive
rownames(Ecoregions@data) -> Ecoregions@data$id
fortify(Ecoregions, region = "id") -> Ecoregions.points 
plyr::join(Ecoregions.points, Ecoregions@data, by = "id") %>%
  filter(BIOME %in% c(4)) ->
  biomes

plyr::join(Ecoregions.points, Ecoregions@data, by = "id") -> land

### Plot map

header -> header1

biomes %>%
  ggplot(aes(x = long, y = lat)) + 
  # geom_hline(yintercept = 23.43644, linetype = "dotted", size = .1) +
  # geom_hline(yintercept = -23.43644, linetype = "dotted", size = .1) +
  geom_polygon(data = land, aes(x = long, y = lat, group = group), 
               color = NA, fill = "gainsboro") +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "limegreen", color = NA ) +
  geom_point(data = header1, aes(DEG_LON, DEG_LAT), size = 1, color = "gold") +
  ggthemes::theme_tufte() +
  coord_fixed(xlim= c(-10, 1), ylim = c(40, 45)) +
  theme(legend.position = "bottom",
        legend.title = element_blank(), 
        legend.direction = "horizontal",
        legend.text=element_text(size = 10),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) -> map; map

### Format for JUICE


  header %>%

  rownames_to_column(var = "Relevé number") %>%
  select(`Relevé number`, PriorCluster, SIVIMID, EUNIS_REVISED, EUNIS2020, 
         Twinspan, Twinspan2, 
         Class, Order, Alliance, Sintaxon,
         Aspect, Slope, Area, 
         Year, DEG_LON, DEG_LAT,
         Accuracy, Elevation) -> headerJUICE

species %>%
  merge(headerJUICE, by = "SIVIMID") %>%
  select(`Relevé number`, SIVIMID, Original.Taxon, 
         Analysis.Names, Cover, Cover.percent) -> speciesJUICE

write.csv(headerJUICE, "results/headerJUICE5.csv", row.names = FALSE, fileEncoding = "latin1")
write.csv(speciesJUICE, "results/speciesJUICE5.csv", row.names = FALSE, fileEncoding = "latin1")
