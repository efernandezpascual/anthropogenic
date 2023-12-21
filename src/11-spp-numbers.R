library(tidyverse)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(Analysis.Names)


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(Analysis.Names) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  group_by(Area) %>% tally %>% arrange(-n)


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise" & Area == "20") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise" & Area == "20") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% arrange(n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise" & Area == "20") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% pull(n) %>% mean


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% arrange(n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(SIVIMID, Analysis.Names) %>%
  unique %>%
  group_by(SIVIMID) %>% tally %>% pull(n) %>% mean


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1")) %>%
  filter(neophyte == 1) %>%
  group_by(Analysis.Names)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1")) %>%
  select(Analysis.Names, bryophyte:phanerophyte) %>%
  unique %>%
  gather(Trait, Value, bryophyte:phanerophyte) %>%
  group_by(Trait) %>%
  summarise(n = sum(Value)/1167) %>% arrange(-n)


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1")) %>%
  select(Alliance, bryophyte:phanerophyte) %>%
  gather(Trait, Value, bryophyte:phanerophyte) %>%
  group_by(Alliance, Trait) %>%
  summarise(n = sum(Value)) %>% spread(Trait, n) %>% data.frame
