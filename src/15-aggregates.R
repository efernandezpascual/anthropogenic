library(tidyverse)

read.csv("data/species.csv", fileEncoding = "latin1") %>%
  dplyr::filter(grepl("aggr.", Analysis.Names)) %>%
  select(Analysis.Names) %>%
  unique -> aggr

read.csv("../canteunis/results/SIVIM/species2.3.csv", fileEncoding = "latin1") %>%
  select(Analysis.Names, Expert.Revision) %>%
  unique %>%
  merge(aggr, by = "Analysis.Names") %>%
  mutate(Expert.Revision = gsub(" aggr.", "", Expert.Revision)) %>%
  unique %>%
  group_by(Analysis.Names) %>%
  filter(length(Expert.Revision) > 1) %>%
  data.frame
