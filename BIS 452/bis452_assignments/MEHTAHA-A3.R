
edges <- rbind(c("A", "B"), c("A", "C"), c("B", "C"), c("C", "D"), c("D", "E"))
edges

library(igraph)
g1 <- graph.edgelist(edges,direct=FALSE)
plot(g1,vertex.size=1,vertex.label.dist=0.5)


#directed network
g2 <- graph.edgelist(edges,direct=TRUE)
plot(g1,vertex.size=1,vertex.label.dist=0.5)
plot(g2,vertex.size=1,vertex.label.dist=0.5)
degree(g1)
degree(g2)
degree(g2,mode="in")
degree(g2,mode="out")
betweenness(g1)
betweenness(g2)
closeness(g1)
closeness(g2)
eigen_centrality(g1)$vector
eigen_centrality(g2)$vector
#get peter's 1-level ego network


#network level metrics
#degree distribution
degree(g1)
degree.distribution(g1)
table <- data.frame(c(0:3),degree.distribution(g1))
colnames(table) <- c("degree level","freqency")
table

#density
edge_density(g1)
edge_density(g2)


getwd()
dept <-  read.csv("~/OneDrive - Lehigh University/Fall 2018/r_code/bis452/bis452_datasets/DepartmentStoreSales.csv")

library(forecast)
summary(dept$Sales)

sales.ts<-ts(dept$Sales,
             start=c(1,1),end=c(6,4), freq=4)

sales.ts
plot(sales.ts,xlab="time",ylab="sales")


sales.lm<- tslm(sales.ts~trend)
summary(sales.lm)

nValid <- 4
nTrain <- length(sales.ts)-nValid
nTrain
train.ts<- window(sales.ts,start=c(1,1),
                  end=c(5,4))
train.ts
valid.ts<-window(sales.ts,start=c(6,1),
                 end=c(6,4))
valid.ts
train.lm <- tslm(sales.ts~trend+season, lambda=0)
summary(train.lm)


train.lm.expo.trend <- tslm(train.ts~trend+season, lambda=0)
summary(train.lm.expo.trend)


#forecast ploynomial trend based on the validation model
pred <- forecast(train.lm.expo.trend, h=4)
pred
accuracy(pred,valid.ts)




chain <- read.csv("~/OneDrive - Lehigh University/Fall 2018/r_code/bis452/bis452_datasets/chain.csv")
summary(chain)
Product= c(rep("1",16),rep("2",16),rep("3",16))
Product
Region= c(rep("East",8),rep("West",8),rep("East",8),rep("West",8),rep("East",8),rep("West",8))
Region
Sales=  c(as.matrix(chain$Product1),as.matrix(chain$Product2), as.matrix(chain$Product3)) 
Sales
aov2 <- aov(Sales ~ Product+Region,data=df1)
summary(aov2)
aov3 <- aov(Sales ~ Product*Region,data=df1)
summary(aov3)
df1<- data.frame(Region,Sales,Product)
df1
df2= data.frame(Sales,Product)
df2
aov1 <- aov(Sales ~ Product, data=df2)
summary(aov1)

boxplot(Sales ~ Product+Region,data=df1)
boxplot(Sales ~ Product, data=df2)

data.for.plot <- aggregate(Sales,by=list(Product,Region), FUN=sum)
data.for.plot