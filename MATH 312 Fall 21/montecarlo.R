#===============================#
#=== Monte Carlo Integration ===#
#===============================#

# Example 6.1
m <- 10000
x <- runif(m)
theta.hat <- mean(exp(-x))
print(theta.hat)
print(1 - exp(-1))

# Example 6.2
m <- 10000
x <- runif(m, min=2, max=4)
theta.hat <- mean(exp(-x))*2
print(theta.hat)
print(exp(-2)-exp(-4))

# Example 6.3 Approach 1
x <- seq(0.1, 2.5, length = 10)
m <- 10000
u <- runif(m)
cdf <- numeric(length(x))
for (i in 1:length(x)){
  g <- x[i]*exp(-(u*x[i])^2/2)
  cdf[i] <- mean(g)/sqrt(2*pi)+0.5
}

Phi <- pnorm(x)
print(round(rbind(x,cdf,Phi),3))

# Example 6.3 Approach 2
x <- seq(0.1, 2.5, length = 10)
m <- 10000
cdf <- numeric(length(x))
for (i in 1:length(x)){
  u <- runif(m,0,x[i])
  g <- exp(-(u)^2/2)
  cdf[i] <- x[i]*mean(g)/sqrt(2*pi)+0.5
}

Phi <- pnorm(x)
print(round(rbind(x,cdf,Phi),3))

# Example 6.4
x <- seq(0.1, 2.5, length = 10)
m <- 10000
z <- rnorm(m)
cdf <- numeric(length(x))
for(i in 1:length(x)){
  cdf[i] <- mean(z < x[i])
}

Phi <- pnorm(x)
print(round(rbind(x,cdf,Phi),3))