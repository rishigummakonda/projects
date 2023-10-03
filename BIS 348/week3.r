# Rishi Gummakonda
# Homework: Descriptive Statistics and Data Visualization

setwd("~/OneDrive - Lehigh University/r_code/bis448/bis448_hw/bis448_hw_code")
rm(list = ls())
toyota <- read.csv("ToyotaCorolla.csv")

#Correlation Matrix and Summary Statistics
toyota$Fuel_Dummy[toyota$Fuel_Type == "Diesel"] <- 0
toyota$Fuel_Dummy[toyota$Fuel_Type == "Petrol"] <- 1
toyota$Fuel_Dummy[toyota$Fuel_Type == "CNG"] <- 2
toyota.2 <- toyota[, c("Price", "Age_08_04", "KM", "Fuel_Dummy","HP")]
summary(toyota.2)
cor_t2 <- cor(toyota.2)
cor_t2


#histograms
hist(toyota$Price,
     main = "Histogram of Price",
     xlab = "Price",
     col = "blue",
     xlim=c(4350,32500),
     ylim = c(0,600))
hist(toyota$Age_08_04,
     main = "Histogram of Age",
     xlab = "Age",
     col = "blue",
     xlim=c(1,80),
     ylim = c(0,250))
hist(toyota$KM,
     main = "Histogram of KM",
     xlab = "KM",
     col = "blue",
     xlim=c(1,243000),
     ylim = c(0,350))
hist(toyota$HP,
     main = "Histogram of HP",
     xlab = "HP",
     col = "blue",
     xlim=c(65,150),
     ylim = c(0,900))

#bar charts
# barplot(table(toyota$Price),
#         main = "Bar Chart of Price",
#         ylim = c(0,120))
# barplot(table(toyota$Met_Color), main = "Bar Chart of Met Color",
#         names.arg = c("Does not have", "Has"), ylim = c(0,1000))

plotdata <- aggregate(car.df$Price, by = list(car.df$Met_Color), FUN = mean)
names(plotdata) <- c("Met_Color", "Price")
barplot(plotdata$Price, names.arg = plotdata$Met_Color, xlab ="Met_Color", ylab = "Price")


#boxplots
boxplot(toyota$Price, main = "Box Plot of Price", ylab = "Price")
boxplot(toyota$Age_08_04,  main = "Box Plot of Age", ylab = "Age")
boxplot(toyota$KM,  main = "Box Plot of KM", ylab = "KM")
boxplot(toyota$HP,  main = "Box Plot of HP", ylab = "HP")

#boxplot of Price by Met_Color
boxplot(Price~Met_Color, data = toyota, main = "Price by Met Color", ylab= "Price", xlab = "Color")
