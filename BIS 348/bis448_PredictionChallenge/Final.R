organic.df <-read.csv("organics.csv")

#Imputing Two Means and Modes for NAs
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


targetone.df <- organic.df[which(organic.df[,12] == 1),]

targetzero.df <- organic.df[which(organic.df[,12] == 0),]


Mean_DemAfflOne<-mean(targetone.df$DemAffl, na.rm=T)
Mean_DemAfflZero<-mean(targetzero.df$DemAffl, na.rm=T)
Mean_PromTimeOne<-mean(targetone.df$PromTime, na.rm=T)
Mean_PromTimeZero<-mean(targetzero.df$PromTime, na.rm=T)
Mean_PromSpendOne<-mean(targetone.df$PromSpend, na.rm=T)
Mean_PromSpendZero<-mean(targetzero.df$PromSpend, na.rm=T)


Mean_DemAffl<-mean(organic.df$DemAffl, na.rm=T)
Mean_DemAge<-mean(organic.df$DemAge, na.rm=T)
Mode_DemCluster<-Mode(organic.df$DemCluster)
Mode_DemClusterGroup<-Mode(organic.df$DemClusterGroup)
Mode_DemReg<-Mode(organic.df$DemReg)
Mode_DemTVReg<-Mode(organic.df$DemTVReg)
Mode_PromClass<-Mode(organic.df$PromClass)
Mean_PromSpend<-mean(organic.df$PromSpend, na.rm=T)
Mean_PromTime<-mean(organic.df$PromTime, na.rm=T)

organic.df$DemAffl[is.na(organic.df$DemAffl) & organic.df$TargetBuy == 1 ]<-Mean_DemAfflOne
organic.df$DemAffl[is.na(organic.df$DemAffl) & organic.df$TargetBuy == 0 ]<-Mean_DemAfflZero

organic.df$PromTime[is.na(organic.df$PromTime) & organic.df$TargetBuy == 1 ]<-Mean_PromTimeOne
organic.df$PromTime[is.na(organic.df$PromTime) & organic.df$TargetBuy == 0 ]<-Mean_PromTimeZero

organic.df$PromSpend[is.na(organic.df$PromSpend) & organic.df$TargetBuy == 1 ]<-Mean_PromSpendOne
organic.df$PromSpend[is.na(organic.df$PromSpend) & organic.df$TargetBuy == 0 ]<-Mean_PromSpendZero


organic.df$DemAffl[is.na(organic.df$DemAffl)]<-Mean_DemAffl
organic.df$DemAge[is.na(organic.df$DemAge)]<-Mean_DemAge
organic.df$DemCluster[is.na(organic.df$DemCluster)]<-as.character(Mode_DemCluster)
organic.df$DemClusterGroup[is.na(organic.df$DemClusterGroup)]<-as.character(Mode_DemClusterGroup)
organic.df$DemGender[is.na(organic.df$DemGender)]<-as.character("U")
organic.df$DemGender[organic.df$DemGender==""] <- "U"
organic.df$DemReg[is.na(organic.df$DemReg)]<-as.character(Mode_DemReg)
organic.df$DemTVReg[is.na(organic.df$DemTVReg)]<-as.character(Mode_DemTVReg)
organic.df$PromClass[is.na(organic.df$PromClass)]<-as.character(Mode_PromClass)
organic.df$PromSpend[is.na(organic.df$PromSpend)]<-Mean_PromSpend
organic.df$PromTime[is.na(organic.df$PromTime)]<-Mean_PromTime

organic.df$DemAffl[organic.df$DemAffl==""]<-Mean_DemAffl
organic.df$DemAge[organic.df$DemAge==""]<-Mean_DemAge
organic.df$DemCluster[organic.df$DemCluster==""]<-as.character(Mode_DemCluster)
organic.df$DemClusterGroup[organic.df$DemClusterGroup==""]<-as.character(Mode_DemClusterGroup)
organic.df$DemReg[organic.df$DemReg==""]<-as.character(Mode_DemReg)
organic.df$DemTVReg[organic.df$DemTVReg==""]<-as.character(Mode_DemTVReg)
organic.df$PromClass[organic.df$PromClass==""]<-as.character(Mode_PromClass)
organic.df$PromSpend[organic.df$PromSpend==""]<-Mean_PromSpend
organic.df$PromTime[organic.df$PromTime==""]<-Mean_PromTime


##Dummy Variables
organic.df$Male <-ifelse(organic.df$DemGender=="M", 1,0)
organic.df$Female <-ifelse(organic.df$DemGender=="F", 1,0)
organic.df$Unknown <-ifelse(organic.df$DemGender=="U", 1,0)

organic.df$Cluster_A <-ifelse(organic.df$DemClusterGroup=="A", 1,0)
organic.df$Cluster_B <-ifelse(organic.df$DemClusterGroup=="B", 1,0)
organic.df$Cluster_C <-ifelse(organic.df$DemClusterGroup=="C", 1,0)
organic.df$Cluster_D <-ifelse(organic.df$DemClusterGroup=="D", 1,0)
organic.df$Cluster_E <-ifelse(organic.df$DemClusterGroup=="E", 1,0)
organic.df$Cluster_F <-ifelse(organic.df$DemClusterGroup=="F", 1,0)
organic.df$Cluster_U <-ifelse(organic.df$DemClusterGroup=="U", 1,0)

for(level in unique(organic.df$DemCluster)){organic.df[level] <-ifelse(organic.df$DemCluster==level, 1,0)}

organic.df$Southeast <-ifelse(organic.df$DemReg=="South East", 1,0)
organic.df$Midlands <-ifelse(organic.df$DemReg=="Midlands", 1,0)
organic.df$North <-ifelse(organic.df$DemReg=="North", 1,0)
organic.df$Scottish <-ifelse(organic.df$DemReg=="Scottish", 1,0)
organic.df$SouthWest <-ifelse(organic.df$DemReg=="South West", 1,0)

organic.df$Border <-ifelse(organic.df$DemTVReg=="Border", 1,0)
organic.df$C_Scotland <-ifelse(organic.df$DemTVReg=="C Scotland", 1,0)
organic.df$East <-ifelse(organic.df$DemTVReg=="East", 1,0)
organic.df$London <-ifelse(organic.df$DemTVReg=="London", 1,0)
organic.df$Midlands_TVReg <-ifelse(organic.df$DemTVReg=="Midlands", 1,0)
organic.df$N_East <-ifelse(organic.df$DemTVReg=="N East", 1,0)
organic.df$N_Scot <-ifelse(organic.df$DemTVReg=="N Scot", 1,0)
organic.df$N_West <-ifelse(organic.df$DemTVReg=="N West", 1,0)
organic.df$SSEast <-ifelse(organic.df$DemTVReg=="S & S East", 1,0)
organic.df$S_West <-ifelse(organic.df$DemTVReg=="S West", 1,0)
organic.df$Ulster <-ifelse(organic.df$DemTVReg=="Ulster", 1,0)
organic.df$WalesWest <-ifelse(organic.df$DemTVReg=="Wales & West", 1,0)
organic.df$Yorkshire <-ifelse(organic.df$DemTVReg=="Yorkshire", 1,0)

organic.df$Gold <-ifelse(organic.df$PromClass=="Gold", 1,0)
organic.df$Platinum <-ifelse(organic.df$PromClass=="Platinum", 1,0)
organic.df$Silver <-ifelse(organic.df$PromClass=="Silver", 1,0)
organic.df$Tin <-ifelse(organic.df$PromClass=="Tin", 1,0)


#Normalize PromSpend and Promtime
library(caret)
nor <- preProcess(organic.df[, 10:11], method=c("range"))
organic.df[, 10:11] <- predict(nor, organic.df[, 10:11]) 

#Partition Data
n <- nrow(organic.df)
n1 <- floor(n*.6)
set.seed(1233)
train_index <-sample(c(1:n),n1)
train.df <-organic.df[train_index,]
valid.df <-organic.df[-train_index,]
attach(organic.df)

#GLM
log <-glm(TargetBuy~DemAffl + DemAge + Female + Male +   Unknown + Yorkshire + `51` + `29` + `10` + Cluster_A + `26` + 
            `14` + `28`, data=train.df, family="binomial")
pred.log <-predict(log, valid.df, type="response")
cmatrix0.1 <- confusionMatrix(as.factor(ifelse(pred.log > 0.1, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.2 <- confusionMatrix(as.factor(ifelse(pred.log > 0.2, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.3 <- confusionMatrix(as.factor(ifelse(pred.log > 0.3, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.4 <- confusionMatrix(as.factor(ifelse(pred.log > 0.4, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.45 <- confusionMatrix(as.factor(ifelse(pred.log > 0.45, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.5 <- confusionMatrix(as.factor(ifelse(pred.log > 0.5, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.6 <- confusionMatrix(as.factor(ifelse(pred.log > 0.6, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.7 <- confusionMatrix(as.factor(ifelse(pred.log > 0.7, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.8 <- confusionMatrix(as.factor(ifelse(pred.log > 0.8, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
cmatrix0.9 <- confusionMatrix(as.factor(ifelse(pred.log > 0.9, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]

cutoff <- c(0.1, 0.2, 0.3, 0.4, .45, 0.5, 0.6, 0.7, 0.8, 0.9)
cmatraix.all <- c(cmatrix0.1, cmatrix0.2, cmatrix0.3, cmatrix0.4, cmatrix0.45, cmatrix0.5, cmatrix0.6,
                  cmatrix0.7, cmatrix0.8, cmatrix0.9)
plot(cmatraix.all ~ cutoff,
     xlab="Cutoff", ylab="Accuracy", main="Logistic Model", type="l", ylim = c(0,1))

###NeuralNEt
library(neuralnet)
nn <-neuralnet(TargetBuy~DemAffl + DemAge + Female + Male +   Unknown + Yorkshire + `51` + `29` + `10` + Cluster_A + `26` + 
                 `14` + `28`, data=train.df, linear.output = F, hidden=4, threshold=.1, stepmax=1e6)
nn.pred <-compute(nn, data.frame(valid.df$DemAffl, valid.df$DemAge, valid.df$Female, valid.df$Male, valid.df$Unknown, valid.df$Yorkshire, 
                                 valid.df$"51", valid.df$"29", valid.df$"10", valid.df$Cluster_A, valid.df$"26", 
                                 valid.df$"14", valid.df$"28"))
nn.pred <- as.numeric(unlist(nn.pred$net.result)) #convert to numeric list
nncmatrix0.1 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.1, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.2 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.2, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.3 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.3, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.4 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.4, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.45 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.45, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.5 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.5, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.6 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.6, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.7 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.7, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.8 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.8, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]
nncmatrix0.9 <- confusionMatrix(as.factor(ifelse(nn.pred > 0.9, 1, 0)), as.factor(valid.df$TargetBuy))$overall[1]

nncutoff <- c(0.1, 0.2, 0.3, 0.4, 0.45, 0.5, 0.6, 0.7, 0.8, 0.9)
nncmatraix.all <- c(nncmatrix0.1, nncmatrix0.2, nncmatrix0.3, nncmatrix0.4, nncmatrix0.45, nncmatrix0.5, nncmatrix0.6,
                  nncmatrix0.7, nncmatrix0.8, nncmatrix0.9)
plot(nncmatraix.all ~ nncutoff,
     xlab="Cutoff", ylab="Accuracy", main="Neural Net Model", type="l", ylim = c(0,1))
nncmatrix0.5 #81.77727784%

#display predictions
prediction(nn)

#plot the NN
plot(nn, rep="best")

###SCORE DATA
scoreorganic.df <- read.csv("scoreorganics.csv")
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


Mean_DemAffl<-mean(scoreorganic.df$DemAffl, na.rm=T)
Mean_DemAge<-mean(scoreorganic.df$DemAge, na.rm=T)
Mode_DemCluster<-Mode(scoreorganic.df$DemCluster)
Mode_DemClusterGroup<-Mode(scoreorganic.df$DemClusterGroup)
Mode_DemReg<-Mode(scoreorganic.df$DemReg)
Mode_DemTVReg<-Mode(scoreorganic.df$DemTVReg)
Mode_PromClass<-Mode(scoreorganic.df$PromClass)
Mean_PromSpend<-mean(scoreorganic.df$PromSpend, na.rm=T)
Mean_PromTime<-mean(scoreorganic.df$PromTime, na.rm=T)



scoreorganic.df$DemAffl[is.na(scoreorganic.df$DemAffl)]<-Mean_DemAffl
scoreorganic.df$DemAge[is.na(scoreorganic.df$DemAge)]<-Mean_DemAge
scoreorganic.df$DemCluster[is.na(scoreorganic.df$DemCluster)]<-as.character(Mode_DemCluster)
scoreorganic.df$DemClusterGroup[is.na(scoreorganic.df$DemClusterGroup)]<-as.character(Mode_DemClusterGroup)
scoreorganic.df$DemGender[is.na(scoreorganic.df$DemGender)]<-as.character("U")
scoreorganic.df$DemGender[scoreorganic.df$DemGender==""] <- "U"
scoreorganic.df$DemReg[is.na(scoreorganic.df$DemReg)]<-as.character(Mode_DemReg)
scoreorganic.df$DemTVReg[is.na(scoreorganic.df$DemTVReg)]<-as.character(Mode_DemTVReg)
scoreorganic.df$PromClass[is.na(scoreorganic.df$PromClass)]<-as.character(Mode_PromClass)
scoreorganic.df$PromSpend[is.na(scoreorganic.df$PromSpend)]<-Mean_PromSpend
scoreorganic.df$PromTime[is.na(scoreorganic.df$PromTime)]<-Mean_PromTime


##Dummy Variables
scoreorganic.df$Male <-ifelse(scoreorganic.df$DemGender=="M", 1,0)
scoreorganic.df$Female <-ifelse(scoreorganic.df$DemGender=="F", 1,0)
scoreorganic.df$Unknown <-ifelse(scoreorganic.df$DemGender=="U", 1,0)

scoreorganic.df$Cluster_A <-ifelse(scoreorganic.df$DemClusterGroup=="A", 1,0)
scoreorganic.df$Cluster_B <-ifelse(scoreorganic.df$DemClusterGroup=="B", 1,0)
scoreorganic.df$Cluster_C <-ifelse(scoreorganic.df$DemClusterGroup=="C", 1,0)
scoreorganic.df$Cluster_D <-ifelse(scoreorganic.df$DemClusterGroup=="D", 1,0)
scoreorganic.df$Cluster_E <-ifelse(scoreorganic.df$DemClusterGroup=="E", 1,0)
scoreorganic.df$Cluster_F <-ifelse(scoreorganic.df$DemClusterGroup=="F", 1,0)
scoreorganic.df$Cluster_U <-ifelse(scoreorganic.df$DemClusterGroup=="U", 1,0)

for(level in unique(scoreorganic.df$DemCluster)){scoreorganic.df[level] <-ifelse(scoreorganic.df$DemCluster==level, 1,0)}

scoreorganic.df$Southeast <-ifelse(scoreorganic.df$DemReg=="South East", 1,0)
scoreorganic.df$Midlands <-ifelse(scoreorganic.df$DemReg=="Midlands", 1,0)
scoreorganic.df$North <-ifelse(scoreorganic.df$DemReg=="North", 1,0)
scoreorganic.df$Scottish <-ifelse(scoreorganic.df$DemReg=="Scottish", 1,0)
scoreorganic.df$SouthWest <-ifelse(scoreorganic.df$DemReg=="South West", 1,0)

scoreorganic.df$Border <-ifelse(scoreorganic.df$DemTVReg=="Border", 1,0)
scoreorganic.df$C_Scotland <-ifelse(scoreorganic.df$DemTVReg=="C Scotland", 1,0)
scoreorganic.df$East <-ifelse(scoreorganic.df$DemTVReg=="East", 1,0)
scoreorganic.df$London <-ifelse(scoreorganic.df$DemTVReg=="London", 1,0)
scoreorganic.df$Midlands_TVReg <-ifelse(scoreorganic.df$DemTVReg=="Midlands", 1,0)
scoreorganic.df$N_East <-ifelse(scoreorganic.df$DemTVReg=="N East", 1,0)
scoreorganic.df$N_Scot <-ifelse(scoreorganic.df$DemTVReg=="N Scot", 1,0)
scoreorganic.df$N_West <-ifelse(scoreorganic.df$DemTVReg=="N West", 1,0)
scoreorganic.df$SSEast <-ifelse(scoreorganic.df$DemTVReg=="S & S East", 1,0)
scoreorganic.df$S_West <-ifelse(scoreorganic.df$DemTVReg=="S West", 1,0)
scoreorganic.df$Ulster <-ifelse(scoreorganic.df$DemTVReg=="Ulster", 1,0)
scoreorganic.df$WalesWest <-ifelse(scoreorganic.df$DemTVReg=="Wales & West", 1,0)
scoreorganic.df$Yorkshire <-ifelse(scoreorganic.df$DemTVReg=="Yorkshire", 1,0)

scoreorganic.df$Gold <-ifelse(scoreorganic.df$PromClass=="Gold", 1,0)
scoreorganic.df$Platinum <-ifelse(scoreorganic.df$PromClass=="Platinum", 1,0)
scoreorganic.df$Silver <-ifelse(scoreorganic.df$PromClass=="Silver", 1,0)
scoreorganic.df$Tin <-ifelse(scoreorganic.df$PromClass=="Tin", 1,0)


#Normalize PromSpend and Promtime
library(caret)
nor <- preProcess(scoreorganic.df[, 10:11], method=c("range"))
scoreorganic.df[, 10:11] <- predict(nor, scoreorganic.df[, 10:11]) 

nn.score <- compute(nn, data.frame(scoreorganic.df$DemAffl, 
                                   scoreorganic.df$DemAge, 
                                   scoreorganic.df$Female, 
                                   scoreorganic.df$Male,
                                   scoreorganic.df$Unknown,
                                   scoreorganic.df$Yorkshire,
                                   scoreorganic.df$"51",
                                   scoreorganic.df$"29", 
                                   scoreorganic.df$"10",
                                   scoreorganic.df$Cluster_A,
                                   scoreorganic.df$"26", 
                                   scoreorganic.df$"14",
                                   scoreorganic.df$"28"))


column <-data.frame("DemAffl"=scoreorganic.df$DemAffl, 
           "DemAge"=scoreorganic.df$DemAge, 
           "Female"=scoreorganic.df$Female, 
           "Male"=scoreorganic.df$Male, 
           "Unknown"=scoreorganic.df$Unknown,
           "29"=scoreorganic.df$"29", 
           "Yorkshire"=scoreorganic.df$Yorkshire, 
           "26"=scoreorganic.df$"26", 
           "51"=scoreorganic.df$"51", 
           "10"=scoreorganic.df$"10", 
           "28"=scoreorganic.df$"28", 
           "ClusterA"=scoreorganic.df$Cluster_A, 
           "14"=scoreorganic.df$"14",
           "Predicted" = round(nn.score$net.result,2), 
           "Classifcation" = ifelse(nn.score$net.result>0.5, 1, 0))
scoreorganic.df$Classifcation <- column$Classifcation
