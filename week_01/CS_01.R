
# load the iris dataset
data(iris)

# explore the mean function
?mean

# calculate the mean of the petal length
len = iris$Petal.Length
petal_length_mean = mean(len)


#plot using hist() and save it
png(file="petal_length_distribution_hist.png",
    width=500, height= 400)
hist(len,
     col="purple", border="white",
     main="Distribution of the Petal Length",
     xlab="Petal Length",
     ylab="Count")
dev.off()


