library(tidyverse)

read.csv("../canteunis/data/sivim/invATL.csv", fileEncoding = "latin1") %>%
  select(codi_xtr2, autors, anny, titol, publicacio) %>%
  rename(SIVIMID = codi_xtr2) %>%
  unique %>%
  filter(SIVIMID %in% header$SIVIMID) %>%
  select(-SIVIMID) %>%
  unique %>%
  filter(autors != "") %>%
  arrange(autors, anny, titol) %>%
  rename(Authors = autors,
         Year = anny,
         Title = titol,
         Publication = publicacio) %>%
  write.csv("results/publications/publications.csv", fileEncoding = "latin1", row.names = FALSE)
