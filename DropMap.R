<<<<<<< HEAD
#the goal of this script is to drop all possible contaminants from the map.csv datafile

  library(dplyr)
  x=read.csv("map.csv")
  #first I extracted the sample name column and then removed it, so that we could work with exclusivly numeric data
  xlegend=x$sample
  xnum=select (x,-c(sample))
  
  #This sets all wells with less than 5 appearances of the otu to 0
  xnum[xnum<5]=0
  #we then dropped all the columns with less than 5 total appearances as these were likely just contaminants
  Drop<-colSums(xnum) < 5
  sum(Drop)
  
  #the data is in the wrong form to drop a row, so i transposed then dropped, then transposed back.
  #theres probably a more efficeint way to do this (swap rows and columns for the drop thing), but this works
  xt=as.data.frame(t(xnum))
  OTU_reduced=xt[!Drop,]
  OTU_final=as.data.frame(t(OTU_reduced))
  
  #finally, we readd the sample column and move it to the first position
  OTU_final$sample=xlegend
=======
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
  
>>>>>>> a4c8e96d972fd60072bbe0a3900fb26bc6c23d2b
  OTU_final <- OTU_final %>%
    select(sample, everything())
write.csv(OTU_final,"DropMap.csv")
  
  
