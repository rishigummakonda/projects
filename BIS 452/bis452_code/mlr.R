getwd()
car.df<- read.csv("ToyotaCorolla.csv")
head(car.df)
#select useful variables
car <- car.df[,c(3,4,7,8,9,10,12,13,14,17,18)]

# create dummy variable for fuel_type
car$Diesel <- ifelse(car$Fuel_Type=="Diesel",1,0)
car$CNG <- ifelse(car$Fuel_Type=="CNG",1,0)
head(car)

#partition data
#60% training, 40% validation
n = nrow(car)
n_training <- n*0.60
n_validation <- n*0.40

#sampling
set.seed(23)
train_index <- sample (c(1:n), n_training)
train.df <- car[train_index,]
valid.df <- car[-train_index,]

# run regression model on training set
car.lm <- lm(Price ~ .-Fuel_Type, data = train.df)
summary(car.lm)

options(scipen = 999)
summary(car.lm)