### Test significance of classification

rm(list = ls())

library(tidyverse); library(vegan)

read.csv("data/header.csv", fileEncoding = "latin1") -> 
  header

read.csv("data/species.csv", fileEncoding = "latin1") %>% filter(SIVIMID %in% header$SIVIMID) -> species

### Map

rgdal::readOGR(dsn = "data/map", layer = "IberoAtlantic") -> Ecoregions # Map files are in my home drive

header %>%
  filter(Semisupervised != "Noise") %>%
  ggplot(aes(Longitude, Latitude, color = as.factor(Semisupervised))) +
  facet_wrap(~ Semisupervised, ncol = 5) +
  geom_polygon(data = Ecoregions, aes(x = long, y = lat, group = group), 
               color = "black", fill = "gainsboro", size = 0.25, show.legend = FALSE) +
  geom_point(show.legend = FALSE) -> Fig2; Fig2

ggsave(Fig2, file = "results/Maps.png", bg = "white", 
       path = NULL, scale = 1, width = 200, height = 270, units = "mm", dpi = 600)