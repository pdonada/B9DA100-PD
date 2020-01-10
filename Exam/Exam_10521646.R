
###QUESTION 1:

#loading the file
#setwd("C:/github/B9DA100-PD/Exam")
iris_new <- read.csv(file="iris_new.data", header=F, sep=",")

#CHANGING HEADERS
head(iris_new)
names(iris_new) <- c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width', 'Species')
head(iris_new)

#FINDING MEAN FIRST 5 ROWS...
mean(iris_new$Sepal.Length[1:5])
  #mean of iris_new$Sepal.Length[1:5] is 4.86
#REMOVING 'IRIS' FROM SPECIES AND CAPITALIZING LETTERS...
iris_new$Species
iris_new$Species = sub("Iris-", "", as.character(iris_new$Species))


###QUESTION 2

#CREATE A NEW DATASET...
iris_sub <- subset(iris_new, Sepal.Length < 6.4 & Petal.Length > 5.1)

#NUMBER OF ROWS
nrow(iris_sub)
  #number of rows is 5

#MEANS OF SEPAL.WIDTH AND PETAL.LENTH
mean(iris_sub$Sepal.Width)
  #mean of iris_sub$Sepal.Width is 3.12
mean(iris_sub$Petal.Length)
  #mean of iris_sub$Petal.Length is 5.64

###QUESTION 3

#

###QUESTION 4
library(ggplot2)
library(reshape2)

#LOADING DATA AND CHANGING HEAD
iris <- read.csv(file="iris_new.data", header=F, sep=",")
names(iris) <- c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width', 'Species')

#EXCLUDING THE COLUMN I DONT NEED TO THE PLOT
iris_ex <- iris
iris_ex$Petal.Width <- NULL

#MAKING SPECIES A COLUM TO BE USE AS REFERENCE
iris2 <- melt(iris_ex, id.vars="Species")

#BUILDING THE PLOT
bar1 <- ggplot(data=iris2, aes(x=Species, y=value, fill=variable))
bar1 + geom_bar(stat="identity", position="dodge") + 
  scale_fill_manual(values=c("orange", "blue", "darkgreen", "purple"),
                    name="Iris\nMeasurements",
                    breaks=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                    labels=c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width"))
