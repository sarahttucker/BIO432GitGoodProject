  library(seqinr)
  library(dplyr)
  
  
  x=read.fasta("otu.fa")
  x=read.csv("map.csv")
  xlegend=x$sample
  xnum=select (x,-c(sample))
  xnum[xnum<5]=0
  Drop<-colSums(xnum) < 5
  sum(Drop)
  xt=as.data.frame(t(xnum))
  OTU_reduced<-xt[!Drop,]
  OTU_final=as.data.frame(t(OTU_reduced))
  OTU_final$sample=xlegend
  
  OTU_final <- OTU_final %>%
    select(sample, everything())
write.csv(OTU_final,"DropMap.csv")
  
  
