#combines the distance column of "MBTrial_...distance.csv" into "summary_metadat.csv"
Dist<-read.csv("MBTrial_tray-stem_distances.csv")
Summary<-read.csv("summary_metadata.csv")
Summary["distance"]<-NA
head(Combined)

  
Summary$uid <- as.character(Summary$uid) 
Dist$uid <- as.character(Dist$uid) 
i1 <- which(names(Summary) == "distance") 

Combined<-merge(Summary[-i1], Dist, by = "uid") 
  
  
Combined$angle=NULL
  
write.csv(Combined, file = "summary_metadata_distance.csv")


