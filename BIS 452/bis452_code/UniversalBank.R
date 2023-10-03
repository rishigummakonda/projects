bank <- read.csv("UniversalBank.csv")
names(bank)
nrow(bank)
head(bank)
attach(bank)
summary(bank)
summary(Age)

#subset data
selected <- c("Age", "Income", "Loan")
bank.subset <- bank[selected]
head(bank.subset)

# drio the first and fifth column 
bankdata1 <- bank[c(-3,-5)]
head(bankdata1)

#selecting the first 5 observations
first5 <- bank[1:5,]
head(first5)