# Rishi Gummakonda
# Exam 1

#Problem 1

p1.df <- read.csv("Problem1.csv")
summary(p1.df)
attach(p1.df)

#partition data
#60% training, 40% validation
n = nrow(p1.df$SPENDING)
n_training <- floor(n*0.60)
n_validation <- n*0.40

#sampling
set.seed(123) # set seed for reproducing the partition
n <- length(p1.df$Spending)
n1 <- floor(n*0.6)
train.index <- sample(c(1:n), n1)
p1.train <- p1.df[train.index, ]
p1.valid <- p1.df[-train.index, ]


# run regression model on training set
lm.train <- lm(Spending ~ ., data = p1.train)
lm.train

#prediction and his of residuals
library(forecast)
lm.pred <- predict(lm.train, p1.valid)
lm.acc <- accuracy(lm.pred, p1.valid$Spending)
lm.acc
all.residuals <- p1.valid$Spending - lm.pred
summary(all.residuals)
hist(all.residuals)


#Rishi Gummakonda
#Problem 2

p2.df <- read.csv("Problem2.csv")
attach(p2.df)

# partition data
n<-nrow(p2.df)
n1=floor(n*0.6)
set.seed(1) # set seed for reproducing the partition
train.index <- sample(c(1:n), n1)
train.df <- p2.df[train.index, ]
valid.df <- p2.df[-train.index, ]


reg<-glm(Phone_sale~Bonus_trans+Online_12+Any_cc_miles_12mo , data = train.df, family = "binomial") 
reg
summary(reg)

#Rishi Gummakonda
#Problem 3

p3.df <- read.csv("Problem3.csv")
attach(p2.df)

# partition data
n<-nrow(p3.df)
n1=300
set.seed(23) # set seed for reproducing the partition
train.index <- sample(c(1:n), n1)
print(train.index)
train.df <- p3.df[train.index, ]
valid.df <- p3.df[-train.index, ]
head(train.df)

library(rpart)
# grow tree 
set.seed(1)
fit <- rpart(C.MEDV ~ ., data=train.df, method = "class", minbucket = 5, maxdepth =5, xval = 10)
printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
#summary(fit) # detailed summary of splits

# plot tree 
prp(fit, type = 1, extra = 1, split.font = 1, varlen = 0,  digits= -1,
    main="Regression Tree for C.MEDV") 
library(rattle)
fancyRpartPlot(fit)


min.xerror <- fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]
pfit=prune(fit,cp = min.xerror) 
printcp(pfit)
prp(pfit, type = 1, extra = 1, split.font = 1, varlen = 0,  digits= -1,
    main="Pruned Regression Tree for C.MEDV")


best.pfit <- prune(fit,cp =0.015198) 

prp(best.pfit, type = 1, extra = 1, split.font = 1, varlen = 0,  digits= -1,
    main="Pruned Regression Tree for C.MEDV")

# Evaluate the new pruned tree on the validation set
valid_pred <- predict(pfit, valid.df) #minimum error tree
best.valid_pred <-predict(best.pfit,valid.df) #best prune tree
#accuracy performance measure
library(forecast)
accuracy(valid_pred,valid.df$C.MEDV)
accuracy(best.valid_pred,valid.df$C.MEDV)
