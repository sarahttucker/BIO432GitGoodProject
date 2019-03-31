# merge 

library(plyr)
library(dplyr)

reads <- read.csv("DropMap.csv")
metsum <- read.csv("summary_metadata.csv")
dist <- read.csv("MBTrial_tray-stem_distances.csv")

metsum <- join(metsum, dist, by = "uid")
head(metsum)

metsum <- select(metsum, -c("combinationnotes", "combi", "project", "subproject", "well", "angle"))
reads <- select(reads, -("X"))
head(reads$sample)
head(metsum)

IDs <- gsub(".*-", "", metsum$seqname)
editsample <- gsub("_.*", "", reads$sample)

spliteditsample <- strsplit(IDs, split = "")
