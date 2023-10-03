#Rishi Gummakonda


rm(list=ls())
mowers.df <- read.csv("~/OneDrive - Lehigh University/r_code/bis448/bis448_datasets/RidingMowers.csv")
str(mowers.df)

#part a
summary(mowers.df$Ownership)[2]/dim(mowers.df)[1]

#part b
plot(mowers.df$Income ~ mowers.df$Lot_Size, xlab = "Income", ylab = "Lot_Size",
     col = ifelse(mowers.df$Ownership == "Owner", "red", "black"))

#part c
library(caret)
options(scipen=999)


logit.reg <- glm(Ownership ~ Income + Lot_Size , data = mowers.df, family = "binomial")
summary(logit.reg)

logit.reg.pred <- predict(logit.reg, mowers.df[ , -3], type = "response")
data.frame(actual = mowers.df$Ownership, predicted = round(logit.reg.pred,2))

mowers.df$Ownership_dummy[mowers.df$Ownership == "Owner"] <- 1
mowers.df$Ownership_dummy[mowers.df$Ownership=="Nonowner"] <- 0

cmatrix0.5 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.5, 1, 0)),
                              as.factor(mowers.df$Ownership_dummy))
cmatrix0.5$overall[1]

#part d
cmatrix0.1 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.1, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.2 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.2, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.3 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.3, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.4 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.4, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.5 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.5, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.6 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.6, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.7 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.7, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.8 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.8, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]
cmatrix0.9 <- confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.9, 1, 0)), as.factor(mowers.df$Ownership_dummy))$overall[1]

cutoffs <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9)
cmatraix.all <- c(cmatrix0.1, cmatrix0.2, cmatrix0.3, cmatrix0.4, cmatrix0.5, cmatrix0.6,
                  cmatrix0.7, cmatrix0.8, cmatrix0.9)
plot(cmatraix.all ~ cutoffs,
     xlab="Cutoff", ylab="Accuracy", main="", type="l")

# part e
logit1 <- logit.reg$coefficients %*% c(1, 60, 20)
odds <- exp(logit1) 
prob <- odds / (1 + odds)

# part f
ifelse(prob>0.5, 1, 0)