# JUICE file "T21" contains a selection of plots > 1700 m

# Export data in JUICE by using Ctrl-W and then "run"
# Then use this:

setwd("C:/Users/victo/OneDrive - Universidad de Oviedo/Escritorio/Investigacion/01_Canteunis")
All <- read.csv ('All.txt', sep = '\t', check.names = F, head = T, row.names = 1)
All.head <- read.csv ('AllHead.txt', sep='\t', head = T, fill = T)
#JUICE.short.head <- read.csv('ShortHead.txt', sep='\t', head = T)

#Hellinger Transformation
library(vegan)
Clust <- decostand(All, "hellinger")

# Clustering
distances <- vegdist (Clust, method = 'bray')
clustering <- hclust (distances, 'average')
plot (clustering, main = '', labels = FALSE)

# Convert hclust into a dendrogram and plot
clu <- as.dendrogram(clustering)
# Default plot
plot(clu, type = "rectangle", ylab = "Height", leaflab = "none")

# NMDS
windows()
nmds <- metaMDS(Clust)
plot(nmds)

data.scores2 <- (scores(nmds))
data.scores <- as.data.frame(data.scores$sites)   
data.scores$FinalEUNIS <- All.head$FinalEUNIS
data.scores$Type <- All.head$Type
write.csv(data.scores, "C:/Users/victo/OneDrive - Universidad de Oviedo/Escritorio/Investigacion/01_Canteunis/1_NMDS/NMDS.csv")

All.head$Type <- as.factor(All.head$Type)

library(tidyverse)

data.scores <- data.scores %>%
  mutate(Color = fct_recode(Type, # Braun-Blanquet to cover scale
                            "#ffcc00" = "Deciduous",
                            "#196719" = "Evergreen",
                            "#42ddd4" = "Coniferous"))

centroids <- aggregate(cbind(NMDS1, NMDS2) ~ FinalEUNIS, data = data.scores, FUN = mean)
seg <- merge(data.scores, setNames(centroids, c('FinalEUNIS','oNMDS1','oNMDS2')),
             by = 'FinalEUNIS', sort = FALSE)

write.csv(centroids, "1_NMDS/NMDS_centroids.csv")
write.csv(seg, "1_NMDS/NMDS_seg.csv")

library(ggrepel)

data.scores <- read.csv("1_NMDS/NMDS.csv")
centroids <- read.csv("1_NMDS/NMDS_centroids.csv")
seg <- read.csv("1_NMDS/NMDS_seg.csv")

unique(data.scores$Color)
         
final.nmds <- ggplot(data.scores, aes(x = -NMDS1, y = NMDS2)) + 
  #geom_segment(data = seg,
               #mapping = aes(xend = oNMDS1, yend = oNMDS2)) +
  #geom_encircle(aes(fill = Type), s_shape =1, expand = 0,
  #alpha = 0.5, color = "black", show.legend = FALSE) +
  #scale_fill_manual("TYPE OF FOREST", values = c("#31e3b7", 
  #                           "#ebb400",
  #                            "#2f5429")) +
  geom_point(size = 8, aes(colour = Type)) +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  coord_fixed() +  
  scale_color_manual("TYPE OF FOREST", values=c("#42aad4", 
                              "#0d520d",
                              "#ff8200")) +
  #geom_point(data=centroids, size=8, shape=21, colour="black", fill="white", stroke=4) +
  geom_label_repel(data = centroids, mapping = aes(x=-NMDS1, y=NMDS2, label=FinalEUNIS), size=10, force = 1, force_pull = 0) +
  theme_bw() +
  theme(
    axis.text = element_text(size=40, color = "black"),
    axis.title = element_text(size=40)) +
  theme(
    legend.title = element_text (size = 30),
    legend.text = element_text (size = 30),
    legend.key.size = unit (2, "cm"),
    panel.grid = element_blank())
final.nmds