library(tidyverse)

read.csv("data/header-revised.csv", fileEncoding = "latin1") %>%
  group_by(CODE, EUNIS2020) %>%
  tally %>%
  spread(EUNIS2020, n, fill = 0) %>%
  write.csv("classification-vs-expert.csv", row.names = FALSE)

library(tidyverse)

read.csv("data/header-revised.csv", fileEncoding = "latin1") %>%
  group_by(CODE, Alliance) %>%
  tally %>%
  spread(Alliance, n, fill = 0) %>%
  write.csv("classification-vs-alliance.csv", row.names = FALSE)
