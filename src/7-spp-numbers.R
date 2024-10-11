library(tidyverse)


read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  group_by(SIVIMID)

### General species diversity

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1"))

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(Analysis.Names) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(Class, Analysis.Names) %>%
  unique() %>%
  group_by(Class) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>% 
  filter(Area >= 10) %>%
  filter(Area <= 30) %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(SIVIMID) %>%
  summarise(l = length(Analysis.Names)) %>%
  pull(l) %>% mean

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>% 
  filter(Area >= 10) %>%
  filter(Area <= 30) %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(SIVIMID) %>%
  summarise(l = length(Analysis.Names)) %>%
  pull(l) %>% min

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>% 
  filter(Area >= 10) %>%
  filter(Area <= 30) %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  group_by(SIVIMID) %>%
  summarise(l = length(Analysis.Names)) %>%
  pull(l) %>% max

### Species origin

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  select(Analysis.Names, origin) %>%
  unique %>%
  group_by(origin) %>% tally

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  select(Class, Analysis.Names, origin) %>%
  unique %>%
  group_by(Class, origin) %>% tally %>%
  group_by(Class) %>%
  mutate(T = sum(n)) %>%
  mutate(per = n/T) %>%
  select(Class, origin, per) %>%
  spread(origin, per)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  select(Alliance, Analysis.Names, origin) %>%
  unique %>%
  group_by(Alliance, origin) %>% tally %>%
  group_by(Alliance) %>%
  mutate(T = sum(n)) %>%
  mutate(per = n/T) %>%
  select(Alliance, origin, per) %>%
  spread(origin, per) %>%
  arrange(-archaeophyte )

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  select(Alliance, Analysis.Names, origin) %>%
  unique %>%
  group_by(Alliance, origin) %>% tally %>%
  group_by(Alliance) %>%
  mutate(T = sum(n)) %>%
  mutate(per = n/T) %>%
  select(Alliance, origin, per) %>%
  spread(origin, per) %>%
  arrange(-neophyte )

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  filter(origin == "neophyte") %>%
  group_by(Analysis.Names) %>% tally %>% arrange(-n)

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  filter(origin == "archaeophyte") %>%
  group_by(Analysis.Names) %>% tally %>% arrange(-n)

### Life forms

read.csv("data/header.csv", fileEncoding = "latin1") %>% 
  filter(Alliance != "Noise") %>%
  merge(read.csv("data/species.csv", fileEncoding = "latin1")) %>%
  select(Analysis.Names) %>%
  unique %>%
  merge(read.csv("data/traits.csv", fileEncoding = "latin1"))  %>%
  select(Analysis.Names, bryophyte:phanerophyte) %>%
  gather(Trait,Value, bryophyte:phanerophyte) %>%
  filter(Value == 1) %>%
  group_by(Trait) %>% tally %>%
  mutate(per = round(100*(n/1133))) %>%
  arrange(-per)

### Plant height

load(file = "results/cwms/cwms.RData")

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  group_by(Class) %>%
  summarise(m = mean(heightmax)) %>%
  arrange(m)

### Flowering

load(file = "results/cwms/cwms.RData")

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  group_by(Class) %>%
  summarise(m = mean(floweringmean, na.rm = TRUE)) %>%
  arrange(m)

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  group_by(Class) %>%
  summarise(m = round(mean(floweringwidth, na.rm = TRUE))) %>%
  arrange(m)

### Inds

load(file = "results/cwms/cwms.RData")

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  group_by(Class) %>%
  summarise(m = mean(EIVE1.T, na.rm = TRUE)) %>%
  arrange(-m)

cwms %>%
  filter(heightmax < 300) %>%
  filter(Alliance != "Noise") %>%
  select(SIVIMID,
         Class,
         Alliance,
         floweringmean,
         floweringwidth,
         heightmax,
         geophyte, 
         therophyte,
         neophyte,
         Disturbance.Frequency,
         Disturbance.Severity,
         Grazing.Pressure,
         Mowing.Frequency,
         Soil.Disturbance,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.T,
         EIVE1.L) %>%
  group_by(Class) %>%
  summarise(m = mean(Disturbance.Severity, na.rm = TRUE)) %>%
  arrange(-m)
