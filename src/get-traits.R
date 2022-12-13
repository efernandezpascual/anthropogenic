library(tidyverse); library(vegan)

read.csv("data/urban-species.csv", fileEncoding = "latin1") %>%
  select(Analysis.Names) %>%
  unique -> species

read.csv("data/traits/sivim_checklist_2.1.csv") %>%
  select(Analysis.Names, Family:Native) %>%
  na.omit %>%
  unique  %>% 
  group_by(Analysis.Names) %>%
  filter(length(Analysis.Names) == 1) -> sivimchecklist

read.csv("data/traits/Checklist9.csv") %>%
  select(Binomen.trinomen, Lifeform) %>%
  rename(Analysis.Names = Binomen.trinomen) %>%
  unique -> cantchecklist

read.csv("data/traits/EIVE_Paper_1.0_SM_13_v.2022-11-06.xlsx - mainTable.csv", dec = ",") %>%
  select(TaxonConcept, 
         EIVE1.M, EIVE1.M.nw3,
         EIVE1.N, EIVE1.N.nw3,
         EIVE1.R, EIVE1.R.nw3,
         EIVE1.L, EIVE1.L.nw3,
         EIVE1.T, EIVE1.T.nw3) %>%
  rename(Analysis.Names = TaxonConcept) %>%
  unique -> eivs

read.csv("data/traits/disturbance_indicator_values.csv") %>%
  select(-c(family, n.replications, n.EUNIS.habitats)) %>%
  rename(Analysis.Names = species) %>%
  unique -> deivs

species %>%
  mutate(height = NA, heightMAX = NA, flowering1 = NA, flowering2 = NA) %>%
  merge(sivimchecklist, all.x = TRUE, by = "Analysis.Names") %>%
  merge(cantchecklist, all.x = TRUE, by = "Analysis.Names") %>%
  merge(eivs, all.x = TRUE, by = "Analysis.Names")  %>%
  merge(deivs, all.x = TRUE, by = "Analysis.Names") -> traits
