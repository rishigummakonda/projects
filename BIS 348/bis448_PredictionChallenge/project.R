
organic.df <- read.csv("~/OneDrive - Lehigh University/Fall 2018/r_code/bis448/bis448_datasets/organics.csv")
attach(organic.df)


organic.df <- na.omit(organic.df)

#PreProcess Data (Dummy Variables)
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
organic.df$Cluster_ <-ifelse(organic.df$DemClusterGroup=="", 1,0)

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



#Particition Data
n <- nrow(organic.df)
n1 <- floor(n*.6)
set.seed(1233)
train_index <-sample(c(1:n),n1)
train.df <-organic.df[train_index,]
valid.df <-organic.df[-train_index,]

#Multiple Linear Regression
multi.reg <-lm(TargetBuy~.-id-TargetAmt-PromClass-DemReg-DemTVReg-DemGender-DemCluster-DemClusterGroup, data=train.df)
summary(multi.reg)
library(forecast)
multi.reg.pred <-predict(multi.reg, data=valid.df)
residuals <-valid.df$TargetBuy - multi.reg.pred
hist(residuals)
multi.reg.acc <-accuracy(multi.reg.pred, valid.df$TargetBuy)
multi.reg.acc
confusionMatrix(as.factor(ifelse(multi.reg.pred>.5,1,0)),as.factor(organic.df$TargetBuy))

########## Selecting variables to drop AIC both
multi.reg.both <- step(multi.reg, direction="both")
summary(multi.reg.both) #which variable did it drop?
multi.reg.both.pred <- predict(multi.reg.both, valid.df)
accuracy(multi.reg.both.pred, valid.df$TargetBuy)


library(neuralnet)
########## NN with AIC backward specification
nn <- neuralnet(TargetBuy ~ DemAffl + DemAge + PromTime + Male + 
                  Female + North + N_East + Platinum + Silver + Cluster_B, 
                data = train.df, linear.output = F, hidden = 4, stepmax=1e6)
plot(nn)
