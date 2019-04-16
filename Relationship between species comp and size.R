library(ggplot2)
library(ape)
library(ggtree)
library(vegan)
library(dplyr)
library(plyr)


mainTab<-read.csv("summary_table.csv")

#rmove anything that is isnt spool//d



SizeVariable<-mainTab
mainTab<-mainTab[-c(48:87),]
mainTab<-mainTab[-grep("prop",mainTab$size),]
mainTab<-mainTab[,-c(1:7)]

mainTabDF<-as.data.frame(mainTab)

Survey_dist<-vegdist(mainTabDF)
Survey_tree<-nj(Survey_dist)



ggtree(Survey_tree,layout="rectangular") %<+% SizeVariable +
  geom_tiplab(aes(colour=size)) +
  theme(legend.position="right")


