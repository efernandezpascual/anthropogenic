library(tidyverse)

### Get trait values from sources

openxlsx::read.xlsx("data/urban-traits.xlsx") %>%
  select(Analysis.Names,
         EIVE1.M, EIVE1.L, EIVE1.T, EIVE1.R, EIVE1.N,
         Disturbance.Severity, Disturbance.Frequency,
         Mowing.Frequency, Grazing.Pressure, Soil.Disturbance) %>%
  gather(Trait, Value, -Analysis.Names) %>%
  na.omit %>%
  merge(read.csv("data/urban-species.csv")) %>%
  group_by(SIVIMID, Trait) %>%
  summarise(Value = weighted.mean(Value, Cover.percent)) %>%
  spread(Trait,Value) %>%
  merge(read.csv("data/urban-header.csv", fileEncoding = "latin1")) -> cwm

cwm %>%
  select(SIVIMID, Disturbance.Frequency:Soil.Disturbance) %>%
  column_to_rownames(var = "SIVIMID") %>%
  FactoMineR::PCA() -> pca1

pca1$ind$coord %>%
  data.frame %>%
  rownames_to_column(var = "SIVIMID") %>%
  merge(cwm) -> cwm2

pca1$var$coord %>%
  data.frame %>%
  rownames_to_column(var = "Variable") -> vars

ggplot(cwm2, aes(Dim.1, Dim.2)) +
  geom_point(aes(color = EUNISL2)) +
  geom_label(data = vars, aes(x = Dim.1*4, y = Dim.2*4, label = Variable))

### Prepare traits completes by Greta

openxlsx::read.xlsx("data/urban-traits.xlsx") %>%
  mutate(height = as.numeric(height),
         heightMAX = as.numeric(heightMAX),
         flowering1 = fct_recode(flowering1,
                                 "1" = "I",
                                 "2" = "II",
                                 "3" = "III",
                                 "4" = "IV",
                                 "5" = "V",
                                 "6" = "VI",
                                 "7" = "VII",
                                 "8" = "VIII",
                                 "9" = "IX",
                                 "10" = "X",
                                 "11" = "XI",
                                 "12" = "XII"),
         flowering1 = as.character(flowering1),
         flowering1 = as.numeric(flowering1),
         flowering2 = fct_recode(flowering2,
                                 "1" = "I",
                                 "2" = "II",
                                 "3" = "III",
                                 "4" = "IV",
                                 "5" = "V",
                                 "6" = "VI",
                                 "7" = "VII",
                                 "8" = "VIII",
                                 "9" = "IX",
                                 "10" = "X",
                                 "11" = "XI",
                                 "12" = "XII"),
         flowering2 = as.character(flowering2),
         flowering2 = as.numeric(flowering2),
         flowering3 = (flowering1 + flowering2) / 2,
         Alien = fct_recode(Native, 
                            "1" = "No",
                            "0" = "Yes"),
         Alien = as.character(Alien),
         Alien = as.numeric(Alien),
         Annual = ifelse(Lifeform == "Therophyte", 1, 0),
         Annual = as.character(Annual),
         Annual = as.numeric(Annual)) %>%
  select(Analysis.Names, 
         height:flowering2,
         flowering3,
         Alien, 
         Annual,
         EIVE1.M,
         EIVE1.N,
         EIVE1.R,
         EIVE1.L,
         EIVE1.T,
         Disturbance.Severity,
         Disturbance.Frequency,
         Mowing.Frequency,
         Grazing.Pressure,
         Soil.Disturbance) %>%
  gather(Trait, Value,  height:Soil.Disturbance) %>%
  na.omit -> traits

### Get releves

read.csv("data/urban-header.csv") -> header
read.csv("data/urban-species.csv") -> species

### Calculate CWMs

species %>%
  merge(traits, by = "Analysis.Names") %>%
  merge(header, by = "SIVIMID") %>%
  group_by(SIVIMID, EUNISL2, Trait) %>%
  summarise(CWM = weighted.mean(Value, Cover.percent, na.rm = TRUE)) -> cwms

cwms %>%
  group_by(EUNISL2, Trait) %>%
  summarise(CWM = mean(CWM)) %>%
  spread(EUNISL2, CWM) %>%
  write.csv("results/CWMs.csv")
