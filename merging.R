#This script is what we used to merge the three different data files provided from DataDryad into a single central dataset

library(plyr)
library(dplyr)

reads <- read.csv("DropMap.csv")
metsum <- read.csv("summary_metadata.csv")
dist <- read.csv("MBTrial_tray-stem_distances.csv")

#Adds a "dist" column onto metsum using "uid" to pair distances with the proper sample
metsum <- join(metsum, dist, by = "uid")
head(metsum)

#removes uneeded data colums from "metsum"
metsum <- select(metsum, -c("combinationnotes", "combi", "project", "subproject", "well", "angle"))
#removes X from reads
reads <- select(reads, -("X"))
head(reads$sample)
head(metsum)

#Changes seqname column from "MBSeq_!-!!!" to"!!!"
IDs <- gsub(".*-", "", metsum$seqname)
#Removes placeholder "0" from IDs
IDs2 <- gsub("0(.+)","\\1",IDs)
#changes reads$sample to same format as IDs2 (no "0" placeholder)
editsample <- gsub("_.*", "", reads$sample)

#replaces original columns in metsun & reads with the above gsub commands
metsum$seqname <- IDs2
metsum$seqname
reads$sample <- editsample

#joins reads and metsum by the matching sample values. This adds the otu reads into the correct row in sumtab
colnames(reads)
colnames(metsum) <- c("X", "sample", "uid", "taxon", "size", "distance")
colnames(metsum)

sumtab <- join(metsum, reads, by = "sample")
str(sumtab)

<<<<<<< HEAD
#Writes central dataset with all required information for the project
=======
#Writes central dataset with all required information
>>>>>>> f8c303ca0699bc15cfa24c1e41e9c66beff2beb6
write.csv(sumtab, file = "summary_table.csv")

