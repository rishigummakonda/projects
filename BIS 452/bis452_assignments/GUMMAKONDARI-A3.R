# Rishi Gummakonda
# 11/20/2018
# Indiv. Assignment 3

#Problem 1

department.store <-  read.csv("~/OneDrive - Lehigh University/Fall 2018/r_code/bis452/bis452_datasets/DepartmentStoreSales.csv")

#plot time series
library(forecast)
ts.sales <-ts(department.store$Sales,
              start=c(1,1),end=c(6,4), freq=4)
ts.sales
plot(ts.sales,xlab="Time (Quarterly)",ylab="Sales (in Dollars)")

#fit to linear regression model
lm.sales<- tslm(sales.ts~trend)

n.valid <- 4
n.train <- length(sales.ts)-n.valid
train.ts<- window(sales.ts,start=c(1,1),
                  end=c(5,4))
valid.ts<-window(sales.ts,start=c(6,1),
                 end=c(6,4))
train.lm <- tslm(sales.ts~trend+season, lambda=0)
summary(train.lm)

train.lm.trend <- tslm(train.ts~trend+season, lambda=0)
summary(train.lm.trend)


#forecasted
pred <- forecast(train.lm.expo.trend, h=4)
pred
accuracy(pred,valid.ts)
