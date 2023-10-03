# Rishi Gummmakonda
# Logistic Regression
#questions 10.4 a-c,
#d. present a confusion matrix for both models.
#f. present a lift chart with both models in it, and the base case line.


ebay <- read.csv("~/OneDrive - Lehigh University/Fall 2018/r_code/bis448/bis448_datasets/eBayAuctions.csv")
attach(ebay)

#data pre-processing
for(level in unique(Category))
{
  ebay[level] <- ifelse(Category == level, 1, 0)  
}

for(level in unique(currency))
{
  ebay[level] <- ifelse(currency == level, 1, 0)  
}

for(level in unique(endDay))
{
  ebay[level] <- ifelse(endDay == level, 1, 0)  
}

#a)
pivot.cat <- aggregate(Competitive., by = list(Category), FUN = mean)
pivot.cur <- aggregate(Competitive., by = list(currency), FUN = mean)
pivot.end <- aggregate(Competitive., by = list(endDay), FUN = mean)
pivot.dur <- aggregate(Competitive., by = list(Duration), FUN = mean)
names(pivot.cat) <- c("Category", "Mean of Competitive")
names(pivot.cur) <- c("Currency", "Mean of Competitive")
names(pivot.end) <- c("end Day", "Mean of Competitive")
names(pivot.dur) <- c("Duration", "Mean of Competitive")

ebay$USEUR <- ebay$US + ebay$EUR

#b)
set.seed(12345)
n = nrow(ebay)
n.training <- n*0.60
train.index <- sample (c(1:n), n.training)
train.df <- ebay[train.index,]
valid.df <- ebay[-train.index,]

lr <- glm(Competitive. ~ ., data=train.df, family = "binomial")
options(scipen = 999)

lr.pred <- predict(lr,valid.df[,-8], type="response")

#d)
library(caret)
cm <- confusionMatrix(as.factor(ifelse(lr.pred>0.5,1,0)), as.factor(valid.df$Competitive.))
cm

