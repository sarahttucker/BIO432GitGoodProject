library(plyr)
library(vegan)
library(ggplot2)

data <- read.csv("summary_table.csv")
levels(data$taxon)
data$taxon=as.character(data$taxon)
x=grep("all|bulk",data$taxon)
Dat2<-data[-(x), ]
Dat2$taxon=as.factor(Dat2$taxon)
levels(Dat2$taxon)

data1 <- Dat2
data1[,1:7] <- NULL

data_dist <- vegdist(data1, method = "bray")
NMDSdat <- metaMDS(data_dist, k=2, trymax = 100)
set.seed(2)

PDat <- data.frame(NMDS1=NMDSdat$point[,1], # create a dataframe with NMDS results 
                   NMDS2=NMDSdat$point[,2],
                   taxon = Dat2$taxon) 
PDat2 <- join(Dat2, PDat, by = "taxon") 



ggplot(data = PDat2, aes(x = NMDS1, y = NMDS2, colour = taxon), alpha=I(0.6)) +  # plot taxon effects
  geom_point(data=PDat2,aes(x=NMDS1,y=NMDS2),alpha=0.5) +
  geom_polygon(data=PDat2,aes(x=NMDS1,y=NMDS2,fill=taxon,group=taxon),alpha=0.30) +
  theme_classic()



