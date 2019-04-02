library(plyr)
library(vegan)
library(ggplot2)

data <- read.csv("summary_table.csv")

names(data)
data1 <- data
data1[,1:7] <- NULL

data_dist <- vegdist(data1, method = "bray")
NMDSdat <- metaMDS(data_dist, k=2, trymax = 100)
set.seed(2)

PDat <- data.frame(NMDS1=NMDSdat$point[,1], # create a dataframe with NMDS results 
                   NMDS2=NMDSdat$point[,2],
                   taxon = data$taxon) 
PDat2 <- join(data, PDat, by = "taxon") 
PDat2$taxon <- as.factor(PDat2$taxon)

ggplot(data = PDat2, aes(x = NMDS1, y = NMDS2, colour = taxon), alpha=I(0.6)) +  # plot taxon effects
  geom_point(data=PDat2,aes(x=NMDS1,y=NMDS2),alpha=0.5) +
  geom_polygon(data=PDat2,aes(x=NMDS1,y=NMDS2,fill=taxon,group=taxon),alpha=0.30) +
  theme_classic()

# remove all rows that have "bulk" or "all" in taxon

PDat3<-PDat2[!(PDat2$taxon=="bulk"  PDat2$taxon=="all"),]
levels(PDat3$taxon)
levels(PDat2$taxon)

