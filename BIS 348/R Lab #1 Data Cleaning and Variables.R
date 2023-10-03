#Rishi Gummakonda

rm(list = ls())

##data summary and visualization
housing.df <- read.csv("WestRoxbury.csv", header = TRUE)  # load data
dim(housing.df)  # find the dimension of data frame
head(housing.df)  # show the first six rows
View(housing.df)  # show all the data in a new tab
# Practice showing different subsets of the data
housing.df[1:10, 1]  # show the first 10 rows of the first column only
housing.df[1:10, ]  # show the first 10 rows of each of the columns
housing.df[5, 1:10]  # show the fifth row of the first 10 columns
housing.df[5, c(1:2, 4, 8:10)]  # show the fifth row of some columns
housing.df[, 1]  # show the whole first column
summary(housing.df)  # find summary statistics for each column

##
str(housing.df) # list the structure of the data
housing.df$TAX <- 5 # Replace all the data in a field with a number
housing.df$YR.BUILT[housing.df$YR.BUILT>=1900] <- "new house" # Replace the data in a field based on equal to some value
housing.df$YR.BUILT[housing.df$ROOMS>=6] <- "big house" # Replace the data in a field based on equal to some value
housing.df$GOOD.HOUSE[housing.df$FLOORS==2] <- 1
housing.df$GOOD.HOUSE[is.na(housing.df$GOOD.HOUSE)] <- 0

##next:
##1. create a variable that takes log of GROSS.AREA
housing.df$LOG.GROSS.AREA <- log(housing.df$GROSS.AREA)
##2. create 3 dummy variables with each one corresponding to a level in REMODEL
housing.df$REMODEL.DUMMY[housing.df$REMODEL == "None"] <- 0
housing.df$REMODEL.DUMMY[housing.df$REMODEL == "Recent"] <- 1
housing.df$REMODEL.DUMMY[housing.df$REMODEL == "Old"] <- 2