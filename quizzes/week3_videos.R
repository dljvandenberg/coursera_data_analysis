# Exploratory Data Analysis - week 3

set.seed(12345)
par(mar=c(0.2, 0.2, 0.2, 0.2))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])