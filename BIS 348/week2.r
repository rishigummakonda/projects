# Rishi Gummakonda
# BIS 448
# Homework on R Introduction: Data Manipulation

#1 Set a working directory and read the data file.

setwd("~/OneDrive - Lehigh University/Fall 2018/BIS 448/bis448_rfiles")
ToyotaCorolla <- read.csv("ToyotaCorolla.csv")

#2.   Remove observations (i.e, rows) from 3-200, 500-502, and 1000-1205.

rows_removed <- c(3:200,500:502,1000:1205)
ToyotaCorolla <- ToyotaCorolla[-rows_removed,]

#3.   Remove observations if KM>=120,000. How many records did you remove?
km_removed <- c(ToyotaCorolla$KM[ToyotaCorolla$KM >= 120000])
length_km <- length(km_removed)
length_km
ToyotaCorolla <- ToyotaCorolla[-km_removed,]

#4.   Remove variable Met_Color.
ToyotaCorolla$Met_Color <- NULL
head(ToyotaCorolla)


#5.   Replace any value greater than 200 in HP with 180.
ToyotaCorolla$HP[ToyotaCorolla$HP > 200] <- 180

# 6. Create a new variable called “Old_Car”. If the Age_08_04>=120, it takes value of “Old”, otherwise “Not too old”.
ToyotaCorolla$Old_Car <- "Not too old"
ToyotaCorolla$Old_Car[ToyotaCorolla$Age_08_04 >= 120] <- "Old"
head(ToyotaCorolla)

#7.   Generate dummy variables for Fuel_Type
ToyotaCorolla$Fuel_Type.DUMMY[ToyotaCorolla$Fuel_Type == "CNG"] <- 0
ToyotaCorolla$Fuel_Type.DUMMY[ToyotaCorolla$Fuel_Type == "Diesel"] <- 1
ToyotaCorolla$Fuel_Type.DUMMY[ToyotaCorolla$Fuel_Type == "Petrol"] <- 2

str(ToyotaCorolla)
#8.   Create a 10% random sample from the data
#partition data
#10% training, 90% validation
n = nrow(ToyotaCorolla)
n_training <- n*0.10
n_validation <- n*0.90

#sampling
set.seed(10)
train_index <- sample (c(1:n), n_training)
train.df <- ToyotaCorolla[train_index,]
valid.df <- ToyotaCorolla[-train_index,]