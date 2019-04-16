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
  OTU_final=xnum[,!Drop]
  
  #finally, we readd the sample column and move it to the first position
  OTU_final$sample=xlegend


write.csv(OTU_final,"DropMap.csv")
  
  
