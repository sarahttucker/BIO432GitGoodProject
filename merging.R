# merge 

library(plyr)
library(dplyr)

reads <- read.csv("DropMap.csv")
metsum <- read.csv("summary_metadata_filtered.csv")
dist <- read.csv("MBTrial_tray-stem_distances.csv")

metsum <- join(metsum, dist, by = "uid")
head(metsum)

metsum <- select(metsum, -c("combinationnotes", "combi", "project", "subproject", "well", "angle"))
reads <- select(reads, -("X"))
head(reads$sample)
head(metsum)

IDs <- gsub(".*-", "", metsum$seqname)
IDs2 <- gsub("0(.+)","\\1",IDs)
editsample <- gsub("_.*", "", reads$sample)

metsum$seqname <- IDs2
metsum$seqname
reads$sample <- editsample

colnames(reads)
colnames(metsum) <- c("X", "sample", "uid", "taxon", "size", "distance")
colnames(metsum)

sumtab <- join(metsum, reads, by = "sample")

str(sumtab)

write.csv(sumtab, file = "summary_table.csv")

