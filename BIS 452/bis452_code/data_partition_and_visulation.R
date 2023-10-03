getwd()

bank <- read.csv("UniversalBank.csv")

names(bank) ##gives variable names
str(bank)  ## gives the structure of the data
nrow(bank) ## number of observation in the dataset

head(bank) ##show the first 6 observations

attach(bank)
hist(Age)

#subset data
selected <- c("Age", "Income", "Loan")
bank.subset <- bank[selected]
head(bank.subset)

#drop the third(Family) and fifth variable(Mortgage)
bankdata1 <- bank[c(-3,-5)]
head(bankdata1)

# selecting first 5 observations
first5 <- bank[1:5,]

#select some observations with criteria
#income no larger than 200k
bank.new <- bank[which(bank$Income <=200),]
nrow(bank.new)

bank.new2 <-bank[which(Income <=200),]
nrow(bank.new2)

#sampling
## take a random sample of size 100
set.seed(123)
sample_row <- sample(1:nrow(bank),100,replace=FALSE)
sample_row
bank_sample <- bank[sample_row,]

#sample size
n <- length(Age)
n
#Data Partition
#create training set 60% of data
#create validation set 40% of data
n1 <- floor(n*0.6)  # training set sample size
n1
n2 <- n-n1 #validation set sample size
n2

#generate training and validation set
set.seed(123)
train=sample(1:n,n1)
bank_train <- bank[train,] #training set
bank_valid <- bank[-train,] #validation set

summary(bank_train)
summary(bank_valid)

#visualization
hist(Age)
hist(bank$Age)
hist(Income)
hist(Family)

#draw 3 histograms in one plot
par(mfrow=c(1,3))
hist(Age)
hist(Income)
hist(Family)

par(mfrow=c(1,1))

#scatterplot
plot(CCAvg ~ Income,data=bank)

#matrix plot
pairs(~ Loan+Age+Income+Family+CCAvg+Mortgage, data=bank)

#boxplot of avgerage cc by loan decisions
boxplot (CCAvg ~ Loan,data=bank)

#Add labels
boxplot(CCAvg ~ Loan, data=bank, xlab="loan decision",
  ylab="Avg credit card spending", col="blue")

?boxplot
?hist
