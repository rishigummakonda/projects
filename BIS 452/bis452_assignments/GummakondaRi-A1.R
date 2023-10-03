# Rishi Gummakonda
# BIS 452

housing.df <- read.csv("BostonHousing.csv")
summary(housing.df)
attach(housing.df)

# 1 

avg.chas <- aggregate(MEDV, by= list(CHAS), FUN = mean)
names(avg.chas) <- c("CHAS", "MeanMedv")
barplot(avg.chas$MeanMedv, 
        names.arg = avg.chas$CHAS,xlab = "CHAS", ylab = "Avg.MEDV")
avg.chas

# 2 


medv.lm <- lm(MEDV ~ ., data = housing.df)
summary(medv.lm)
#If Crime Rate increases by one unit, MEDV will by $121.38
# There is a positive correlation between CHAS and MEDV
# MEDV = 41.62 + -0.12x + 0.046x + 0.013x + 2.84x + -18.76x + 3.66x + 0.003x 
# + -1.49x + 0.29x + -0.012x + -0.94x + -0.55x

# 3 

#partition data
#60% training, 40% validation
n = nrow(MEDV)
n_training <- floor(n*0.60)
n_validation <- n*0.40

#sampling
set.seed(123)
train_index <- sample (c(1:n), n_training)
train.df <- housing.df[train_index,]
valid.df <- housing.df[-train_index,]

# run regression model on training set
medv.lm.2 <- lm(MEDV ~ ., data = train.df)


#prediction accuracy
library(forecast)
valid.pred <- predict(medv.lm.2, valid.df)
accuracy(valid.pred)
train.pred <- predict(medv.lm.2, train.df)
accuracy(train.pred,train.df$MEDV)


#lm.acc <- accuracy(valid.pred,

#hist
all.resid <-housing.valid$MEDV - lm.pred
hist(all.resid, breaks = )


#lift cart
library(gains)
gain < gains(housing.valid$MEDV, lm.pred)
gain