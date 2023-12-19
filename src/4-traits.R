library(tidyverse)

read.csv("data/traits.csv", fileEncoding = "latin1") -> traits

species %>% filter(! Analysis.Names %in% traits$Analysis.Names)

# read.csv("data/urban-species-5.2.csv", fileEncoding = "latin1") -> species
# 
# read.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1") -> traits
#  
# read.csv("data/indicators/EIVE_Paper_1.0_SM_13_v.2022-11-06.xlsx - mainTable.csv", dec = ",") %>%
#   select(TaxonConcept, 
#          EIVE1.M,
#          EIVE1.N,
#          EIVE1.R,
#          EIVE1.L,
#          EIVE1.T) %>%
#   rename(link = TaxonConcept) %>%
#   unique -> eivs
# 
# read.csv("data/indicators/disturbance_indicator_values.csv") %>%
#   select(species, Disturbance.Severity:Soil.Disturbance) %>%
#   rename(link = species) %>%
#   unique -> deivs
# 
# traits %>%
#   mutate(link = gsub(" aggr.", "", Analysis.Names)) %>%
#   merge(eivs, all.x = TRUE) %>%
#   merge(deivs, all.x = TRUE) %>%
#   select(-link) -> traits2
# 
# filter(species, ! Analysis.Names %in% traits2$Analysis.Names)
# filter(traits2, ! Analysis.Names %in% species$Analysis.Names)
# 
# traits2 %>% write.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1", row.names = FALSE)
# 
# read.csv("data/urban-traits-5.2.csv", fileEncoding = "latin1") %>%
#   select(-c(heightmean, repetido)) %>%
#   rename(neophyte = alien) %>%
#   write.csv("data/traits.csv", fileEncoding = "latin1", row.names = FALSE)
