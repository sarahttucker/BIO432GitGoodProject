library(plyr)
library(vegan)
library(ggplot2)

data <- read.csv("summary_table.csv")
#turns "coleoptera" into a more managable value
data$taxon <- gsub("coleoptera", "C", data$taxon)

#check and set class of the object
levels(data$taxon)
data$taxon=as.character(data$taxon)
#retreives all rows that match taxon values of "all" and "bulk", removes X clolumn
x=grep("all|bulk",data$taxon)
#removes all rows that do not match taxon = "C"
Dat2<-data[-(x), ]
#encodes taxon as a factor
Dat2$taxon=as.factor(Dat2$taxon)
levels(Dat2$taxon)
data1 <- Dat2
#returns list of selected elements
data1[,1:7] <- NULL

#computes dissilarity matrix
data_dist <- vegdist(data1, method = "bray")
#standardizes scaling
set.seed(2)
NMDSdat <- metaMDS(data_dist, k=2, trymax = 100)

# create a dataframe with NMDS results 
PDat <- data.frame(NMDS1=NMDSdat$point[,1], 
                   NMDS2=NMDSdat$point[,2],
                   taxon = Dat2$taxon) 
PDat2 <- join(Dat2, PDat, by = "taxon") 


# plot taxon effects
ggplot(data = PDat2, aes(x = NMDS1, y = NMDS2, colour = taxon), alpha=I(0.6)) +  
  geom_point(data=PDat2,aes(x=NMDS1,y=NMDS2),alpha=0.5) +
  geom_polygon(data=PDat2,aes(x=NMDS1,y=NMDS2,fill=taxon,group=taxon),alpha=0.30) +
  theme_classic()


#Creates NMDS plot based on distance as opposed to taxon (above)
Data2 <- data
Data2[,1:7] <- NULL
data$distance <- as.factor(data$distance)

data_dist2 <- vegdist(Data2, method = "bray")
NMDSdat2 <- metaMDS(data_dist2, k=2, trymax = 100)
set.seed(2)

# create a dataframe with NMDS results 
PDat3 <- data.frame(NMDS1=NMDSdat2$point[,1], 
                   NMDS2=NMDSdat2$point[,2],
                   distance = data$distance) 
PDat4 <- join(data, PDat3, by = "distance") 

ggplot(data = PDat4, aes(x = NMDS1, y = NMDS2, colour = distance), alpha=I(0.6)) +  # plot taxon effects
  geom_point(data=PDat4,aes(x=NMDS1,y=NMDS2),alpha=0.5) +
  geom_polygon(data=PDat4,aes(x=NMDS1,y=NMDS2,fill=distance,group=distance),alpha=0.30) +
  theme_classic()

