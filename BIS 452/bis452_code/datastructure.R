# Filename: datastructure.R
# The purpose of the program is to learn vector, matrix, and data.frame

##########################Vector###################
# Create a vector, c()
x1=c(1, 7, 12, 6, 3)
x1

x1[2]

min(x1)
max(x1)
mean(x1)
median(x1)
sum(x1)
var(x1)
sd(x1)


# The first 3 elements
# The : operator creates a sequence of integers inremented by 1
x1[1:3]

# Create more vectors
x2 = 2*(1:5)
x2

x3= 2*x1 + x2
x3

# x4 is a logical vector
x4=x1>6
x4

# mode() function returns the mode, or type (the way things are) of the elements
mode(x1)
mode(x4)

# charactor or string vector
x5=c("blue", "green", "red", "yellow", "purple")
x5
mode(x5)

########################Matrix##########################################################
# Create a numeric matrix using cbind()ti cobine vectors. x1, x2, and x3 are columns
y=cbind(x1, x2, x3)
y
cor(y)
cor(x1,x2)

# Display the first 3 rows for all columns
y[1:3,]

# 3 rows for the first 2 columns
y[1:3,1:2]

# another way to do matrix
M = matrix(1:12, 3, 4)
M
M[1:2,1:2]
M[1,]
M[,1]

################################Data Frame#############################################
# A dataframe in R is similar to a table
# It can store diferent types of variables
# Elements in matrix must be the same type 
z=data.frame(y,x4,x5)
z

# What happens when you try to combine different variable types in a matrix
z1 = cbind(x3, x4)
z2 = cbind(x3, x5)
z1
z2
mode(z2)
mode(z1)
# The 5th column of z
# $ points to the variable named x5 in the dataframe
z[,5] 
z$x5


# More on dataframes

# Informaiton about the dataframe
nrow(z)
ncol(z)
dim(z)
names(z)


# print the few rows 
head(z)
head(z, n=3)

# class is about the data structure
z
class(z)

y
class(y)