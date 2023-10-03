rm(list=ls())


### Part(a): check the empirical coverage rate


### Part(b)
cat('Estimating Porportion of Times Confidence Interval Misses:','\n\n')
#standard normal bootstrap CI
r<-numeric() #miss on the right
l<-numeric() #miss on the left
for(i in 1:1000){
  if(int.norm[i,1]>0) l[i]<-1 else l[i]<-0
  if(int.norm[i,2]<0) r[i]<-1 else r[i]<-0
}
cat ("Standard Normal Bootstrap CI:", '\n')
cat("miss on the right:",sum(r)/1000,'\n')
cat("miss on the left:",sum(l)/1000,'\n','\n')

#basic bootstrap CI
r<-numeric() #miss on the right
l<-numeric() #miss on the left
for(i in 1:1000){
  if(int.basic[i,1]>0) l[i]<-1 else l[i]<-0
  if(int.basic[i,2]<0) r[i]<-1 else r[i]<-0
}
cat ("Basic Bootstrap CI:", '\n')
cat("miss on the right:",sum(r)/1000,'\n')
cat("miss on the left:",sum(l)/1000,'\n', '\n')

#percentile CI
r<-numeric() #miss on the right
l<-numeric() #miss on the left
for(i in 1:1000){
  if(int.perc[i,1]>0) l[i]<-1 else l[i]<-0
  if(int.perc[i,2]<0) r[i]<-1 else r[i]<-0
}
cat ("Percentile CI:", '\n')
cat("miss on the right:",sum(r)/1000,'\n')
cat("miss on the left:",sum(l)/1000,'\n','\n')
