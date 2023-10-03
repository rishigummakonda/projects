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