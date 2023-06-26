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
  merge(read.csv("results/2.EUNIS_VGG/header.csv", fileEncoding = "latin1")) -> cwm

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
  geom_point(aes(color = EUNIS_VGG)) +
  geom_label(data = vars, aes(x = Dim.1*4, y = Dim.2*4, label = Variable))

cwm %>%
  select(Disturbance.Frequency:Soil.Disturbance, EUNIS_VGG) %>%
  gather(Trait, Value, -EUNIS_VGG) %>%
  mutate(Value = as.numeric(Value)) %>%
  na.omit %>%
  group_by(EUNIS_VGG, Trait) %>%
  summarise(m = mean(Value)) %>%
  spread(Trait, m) %>%
  write.csv("lol.csv")
