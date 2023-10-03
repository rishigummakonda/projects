##Swetha Ramesh
## Week 5 Lab 7

## Q1
## inverse transform method
## rweibull can use this to generate samples
# but we want to use the inverse transformaiton method
# we have the pdf, so we need the cdf (Can do integration of pdf)

# Step 1: find the cdf
inv.cdf <- function(x,a,b){
  a*(-log(1-x))^(1/b)
}

n <- 1000
u <- runif(n)
x <- inv.cdf(u, 2, 3)
hist(x, prob = T)

## check the density
curve(dweibull(x,3,2), add = TRUE, col = 2)


## Q2 : generate discrete random variables
## if starting with pmf, find the cdf

pmf <- c(0.1,0.2,0.3,0.4)
cdf <- cumsum(pmf)

u <- runif(n)
x <- numeric(n)
for(i in 1:n){
  if(u[i] <= 0.1)  x[i] = 1
  else if(0.1 < u[i] & u[i]<=0.3) x[i] =2
  else if (0.3 < u[i] & u[i]<=0.6) x[i] =3
  else x[i] = 4
}

hist(x)
table(x)/n


## Q3
# transformation method to generate random variables
trans <- function(y, lambda, kappa){
  lambda*y^(-1/kappa)
}

U <- runif(n)
X <- trans(U, 4, 100)
hist(X)

## Q4
## will finish next class, try to submit something tho
inv.cdf1 <- function(x,a,m,b){
  a + sqrt(x*(b-a)*(m-b))
}

inv.cdf2 <- function(x,a,m,b){
  b - sqrt((1-x)*(b-a)*(b-m))
}

n <- 1000
u <- runif(n)
u <- runif(n)
x <- numeric(n)
for(i in 1:n){
  if(u[i] > 0 & u[i] < (1/3))  x[i] = inv.cdf1(u[i],0,1/3,1)
  else if(u[i] >= (1/3) & u[i] < 1) x[i] = inv.cdf2(u[i],0,1/3,1)
}

hist(x)
