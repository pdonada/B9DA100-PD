my_mean <- function(x) {
  sum(x) / length(x)
}


my_mean(c(2,4,5))

mean(c(2,4,5))


evaluate <- function(func, dat){
  func(dat)
}


evaluate(sum, c(2, 4, 6))
evaluate(median, c(7, 40, 9))
evaluate(floor, 11.1)



telegram <- function(...){
  paste("START",...,"STOP")
}

telegram("Good", "morning")



mad_libs <- function(...){
  # Do your argument unpacking here!
  args <- list(...)
  place <- args[1]
  adjective <- args[2]
  noun  <- args[3]  
  
  # Don't modify any code below this comment.
  # Notice the variables you'll need to create in order for the code below to
  # be functional!
  paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}


mad_libs("AAA", "BBB", "CCCC")



"%p%" <- function(left, right)
  {   paste(left,right)}

"Good" %p% "job!"

library(ggplot2)
dat <- read.csv(file="newwords.csv", header=F, sep=",")
dat
#attach(dat)
words <- dat[1]
words
count <- dat[2]
count
ggplot(data=dat, aes(x=words, y=count)) +
    geom_bar(stat="identity")
    

library(ggplot2)
dat <- read.csv(file="stdin", header=TRUE, sep=",")
dat
ggplot(data=dat, aes(x=Words, y=Count)) +
    geom_bar(stat="identity")
    
    
###########################################################
#---------------------------------------------------------#
######### Lecture 3 code: lists and data frames ###########
#---------------------------------------------------------#
###########################################################

# Clear everything in the workspace:
rm(list=ls())

###########################################################
# Introduction:
# Lists and data frames allow us to store and therefore analyse more complex
# forms of data
# 
# In a list we can store objects of different types, e.g. numbers, text, vectors,
# matrices, etc and they can have different lengths or dimensions
# 
# A data frame is more like a matrix, except that each column can have a
# different type
#
# Technically, a list is a vector (which we've met already),
# except that, unlike atomic vectors (which cannot be broken
# down into smaller components), lists are
# recursive vectors, which means, e.g., the first component of
# my.list can be a single number, a character vector, a matrix,
# a dataframe, another list... etc.!

##################################
# Creating a list
##################################

# Let's imagine we want to create an employee database

# For each employee, we want to store their name,
# their salary, and a Boolean indicating their membership of a union

# A list is a perfect object to store these details of mixed type

# Let's create the list:
j <- list(name='Joe', salary=55000, union=T)

# Now let's print it:
j

# Here, name, salary and union are optional tags (component names).
# Without them the components would be named [[1]], [[2]], and [[3]]

j2 <- list('Joe', 55000, T)
j2

# Accessing list components: (at least 3 different ways)
# These return the object in the data type stored in it
# (e.g., it returns a numeric vector if a numeric vector is stored there):
j$salary
j[['salary']]
j[[2]]

# If we don't use double square brackets, R returns another list
# - a subset of the original list
# This can be a little confusing:
j['salary']
j[2]
j[1:2] # A list is really a (recursive) vector, so this is allowed
j[c(1, 3)]

# We can add new components after a list has been created:
j$sales <- c(10400, 12300, 13700)
j$role <- 'Manager'
j

# We can delete components by setting it to NULL:
j$role <- NULL
j

# Since a list is a vector, length() gives the number of tags in the list.
# (Note: this *doesn't* give the number of raw elements):
length(j)
length(j$sales)

# Find names or structure of a list:
names(j)
str(j) # The structure str() function is very useful

# The function unlist() will convert a list into
# a vector using the mode of the lowest common
# denominator (here, that is the character mode)
unlist(j)
mode(unlist(j))
?unlist

# By default R will give names to an unlisted object
# taken from the tags. We can remove them via the
# unname command or giving an extra argument:
unname(unlist(j))
unlist(j, use.names=FALSE)

new.j <- unlist(j)
names(new.j) <- NULL
new.j

##################################
# The lapply function:
##################################
# The family of apply functions (which we first met for matrices) has a version
# for lists known as lapply:

# Use lapply on list (and return a list):
list1 <- list(c(1, 2, 5, 4), c(21, 3, 56, 45, 31))
list1
lapply(list1, median)

# Use sapply (simplified apply) to return a vector:
sapply(list1, median)

# Check the sum instead:
lapply(list1, sum)
sapply(list1, sum)

# There’s nothing to stop you having a list within a list...
list(a=1, b=2, c=list(d=5, e=9))

#  ... or matrix in a list... etc.
list(a=1, b=matrix(c(1,2,3,4), ncol=2, nrow=2))

##################################
# Example:
##################################

# You will use the lm() function in your class to fit a
# linear model to variables x and y

# The object returned from this function has lots of different parts
# and lots of different sizes
# It contains lists within lists too

# Create a sequence x:
x <- seq(-10, 10, length.out = 60)

# Create y, dependent on x, with some 'noise'
set.seed(13)
y <- -1 + rnorm(60, x, 2)

# Plot x against y:
plot(x, y, pch = 16)

# Fit a linear model to predict new values of y
# from new values of x:
lm(y ~ x)

# Save this object:
mod1 <- lm(y ~ x)
str(mod1)

# You can just access the parts you need, e.g.:
abline(mod1$coefficients[1], mod1$coefficients[2], col = "red", lwd = 2)

##################################
# Data Frames
##################################

# A data frame is just like a matrix,
# except that each column can have a different mode

# Technically, a dataframe is a list, with the restriction
# that each component is an equal-length vector

# Simple example:
names <- c('Jack', 'Jill')
ages <- c(12, 10)

d <- data.frame(names, ages, stringsAsFactors = FALSE)
d
mode(d)
str(d)

# By default R will turn strings (names) into factors which are another data
# type. Setting stringsAsFactors = FALSE avoids this
# We will cover factors later in the course

# Accessing data frames:
d[[2]]
d$names
d$names[1]

##################################
# Example:
##################################

# While R treats a data frame like a list,
# it also allows us to extract and filter in
# the same way as if it were a matrix

# Load in the data frame airquality containing daily measurements
# on air quality in New York in 1973
# Read about it by running: ?airquality
data(airquality)
str(airquality)

# Look at the top of it:
head(airquality)

# Extract parts of it:
airquality[1:10, ]

# Select only the rows from June (month = 6):
airquality[airquality$Month == 6, ]
subset(airquality, Month == 6)

# Select days on which the Ozone was below 30:
subset(airquality, Ozone < 30) # Note that airquality$Ozone is not needed here

# Note that subset ignores NA values
sum(is.na(airquality$Ozone))

# Look at complete.cases - this function removes any rows with NA in them:
airquality[complete.cases(airquality), ]

# The rbind and cbind functions we met for matrices also work
# for data frames, provided the dimensions match:

# Creating new data frames with added data:
airquality2 <- airquality[1:10, ]
airquality3 <- cbind(airquality2, Label=letters[1:10], stringsAsFactors = FALSE)
airquality4 <- rbind(airquality3, list(15, 300, 10, 70, 5, 11, 'k'))

# We can attached new columns as functions of old columns:
vec1 <- (airquality$Temp - 32) * (5/9)
vec1

# This looks a little messy. Let's use the round() function:
vec1 <- round(vec1, 1)
vec1

# Attaching this to the data frame:
airquality <- cbind(airquality, vec1)
head(airquality)

# The names() function is useful because the default names given by R
# to the data frame columns can sometimes be a bit messy,
# especially when created by combining other columns:
names(airquality)
names(airquality)[7] <- 'Temp.C'
head(airquality)
names(airquality)

# I should haven't Temp and Temp.C - it could confuse people
# Best to call the old Temp Temp.F:
names(airquality)[4] <- 'Temp.F'

# Couldn't we do this in fewer steps? Yes!
airquality$Temp.Celsius <- round((airquality$Temp.F - 32) * (5/9))
head(airquality)

##################################
# Extended example 1 - urine data with logistic regression:
##################################

# Logistic regression is a statistical method used to predict whether a binary
# variable is 0 or 1 based on other explanatory variables
# Look at the example on students passing exams on the Wikipedia page:
# https://en.wikipedia.org/wiki/Logistic_regression

# We will estimate the necessary parameters using the R function
# glm() with the argument family = 'binomial'

# Load the dataset urine (it's in the library called boot)
library(boot)
help(urine)
str(urine)

# From the above commands we can see that there are 7 columns, the first of
# which (r) represents the binary response variable which is the presence
# of certain type of crystals

# The other columns represent potential explanatory variables

# Write a function that fits a logistic regression model using each of
# the remaining explanatory variables in turn
logfun <- function(x) {
  
  # Fit a generalised linear model:
  glm(urine$r ~ x, family=binomial)$coef

}

# Apply it to all columns:
sapply(urine[,-1], logfun)
# The top row here contains values of beta0 (the intercept),
# while the second row contains values of beta1 (the slope)

# Notice that one of the coefficients of x is negative, indicating that
# as ph increases, the probability of the presence of crystals goes down

# Example output (try this for other variables too):
# Let’s see the relationship between calc and r in a plot:
mod <- glm(urine$r ~ urine$calc, family=binomial)$coef

plot(jitter(urine$calc), urine$r, col="red", pch = 16)

points(sort(urine$calc), 1/(1 + exp(-(mod[1] + mod[2] * sort(urine$calc)))),
       pch = 16, col="black", type="l", lwd=2)

##################################
# Extended example 2 - text concordance
##################################
# Suppose we had a block of text like the following:

"It was the best of times, it was the worst of times, it was the age of wisdom,
it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity,
it was the season of Light, it was the season of Darkness, it was the spring of hope,
it was the winter of despair, we had everything before us, we had nothing before us,
we were all going direct to Heaven, we were all going direct the other way -
in short, the period was so far like the present period,
that some of its noisiest authorities insisted on its being received,
for good or for evil, in the superlative degree of comparison only."

# What is this from?

# We're going to create a function which lists the different words used
# and their position in the text
# For example, 'It' is used in positions 1, 7, 13 etc.

# To keep this simple, we'll first remove all the non-letter
# characters and save them into a text object:
firstpar <- 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way - in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
firstpar
firstpar <- gsub(",", "", firstpar)
firstpar <- gsub("\\.", "", firstpar)
firstpar <- gsub("-", "", firstpar)
firstpar <- gsub("  ", " ", firstpar)
firstpar

# A suitable function would be:
findwords <- function(tf) {
  
  # Read in the words from the text and separate into a vector:
  txt <- unlist(strsplit(tf,' '))
  
  # Turn this to lowercase:
  txt <- tolower(txt)
  
  # Create an empty list to store the words and their positions
  wl <- list()
  
  # Loop through each word
  for(i in 1:length(txt)) {
    
    # Get the current word
    wrd <- txt[i]
    
    # Add its position to the list with the appropriate tag
    wl[[wrd]] <- c(wl[[wrd]], i)
  }
  
  # Return the answer as a list
  return(wl)
}

findwords(firstpar)
words.list <- findwords(firstpar)

# What about a function to sort text alphabetically?

# Simple sort-alphabetically function
alphawl <- function(wrdlst) {
  
  # Find the tags of the list:
  nms <- names(wrdlst)
  
  # Sort them alphabetically:
  sn <- sort(nms) 
  
  # Return them in this sorted order:
  return(wrdlst[sn]) 
}

# Run this function:
alphawl(words.list)

# Or what if we want to sort by frequency?
freqwl <- function(wrdlst) {
  
  # Find the frequency of each word:
  freqs <- sapply(wrdlst,length)
  
  # Return them in order - add decreasing=T argument to change order:
  return(wrdlst[order(freqs)])
}

freqwl(words.list)

######################################################################################################
# Extra reading:
######################################################################################################
##################################
# Extended example 3 - merging dataframes
##################################
# It is very common to have two data frames that need to be
# merged together in some way.
# The R function for this is merge(x, y) where x
# and y are two data frames with at least one common column name:

d1 <- data.frame(kids=c('Jack', 'Jill', 'Jillian', 'John'),
                 county=c('Dublin', 'Cork', 'Donegal', 'Kerry'))

d2 <- data.frame(ages=c(10, 7, 12),
                 kids=c('Jill', 'Lillian', 'Jack'))
d1
d2

merge(d1, d2)
# Note that this only allows *full* entries -
# that is, where we have data for all columns

# If we're happy with missing values, we could run:
merge(d1, d2, all=TRUE)

# Be careful matching with duplicates:
d3 <- rbind(d2, list(15, 'Jill')) # d3 now contains two Jills
d1
d3

merge(d1, d3)
# The merge now thinks both Jills come from Cork

##################################
# lapply() on data frames:
##################################

# R treats data frames like a list, so calling
# lapply() on a data frame with a function f() will
# evaluate the function on each of the data frame’s columns,
# with the return value given as a list

# Using lapply on a data frame
lapply(d, sort)

# To get it back into a data frame, we could use:
data.frame(lapply(d, sort))
# This is not a very sensible result -
# both were sorted separately, meaning the row structure has been broken

###########################################################
#---------------------------------------------------------#
############## Lecture 5 code: Plotting ###################
#---------------------------------------------------------#
###########################################################

# Clear everything in the workspace:
rm(list=ls())

###########################################################
# Introduction
# We're going to learn:

# About plotting
# R is able to create excellent publication-quality graphics

# There are some great blogs and advanced ideas here:
# http://www.sr.bham.ac.uk/~ajrs/R/r-gallery.html
# http://flowingdata.com/2010/01/21/how-to-make-a-heatmap-a-quick-and-easy-solution/
# http://spatial.ly/2012/02/great-maps-ggplot2/
# http://paulbutler.org/archives/visualizing-facebook-friends/
# https://www.harding.edu/fmccown/r/

# Plotting is a *big* topic
# There are intensive courses just for plotting
# This lecture will introduce you to the basics

###########################################################
# A basic plot
###########################################################

# The default way to create a graph in R is to use the plot() function

# plot() behaves differently with different objects
# Let's look at its behaviour on two vectors

# The general format is plot(x, y), where x and y are vectors:
plot(c(1, 2, 4, 5), c(2, 4, 5, 7))

# This creates a very plain graph

# R pairs these up to make points (1, 2), (2, 4), (4, 5) and (5, 7)
# By default the plotting character is an empty circle

# A slightly more interesting graph:
plot(c(1, 2, 4, 5), c(2, 4, 5, 7),
     xlab = "x variable", ylab = "y variable",
     type = "l", main =  "My graph")

# This gives x- and y-axis labels, a title, and specifies the type
# to be a line (other types: p for point, b for both, n for none)

# Plot these two:
plot(c(1, 2, 4, 5), c(2, 4, 5, 7))
plot(c(5, 4, 2, 1), c(2, 4, 5, 7))

# RStudio seems to overwrite the first plot
# But arrows mean we can cycle between the plots we've made

# We can zoom in and export these plots too

# Add points and lines - creating a blank graph first
x <- c(1, 2, 4, 5)
y <- c(2, 4, 5, 7)
plot(x, y, type = "n")
lines(x, y, lty = 2) # lty specifies the line type
points(x, y, pch = 19) # pch specifies the plotting character

# If we want to add additional text, use the text() function:
# Use of the text function
plot(x, y, type = "b", pch = 19)
text(1.5, 5.5, "My text here")

# The first two arguments specify the locations,
# the third gives the text itself
# Use the argument pos to position it below/left/right/above the chosen location

# If you want to add text outside the margin:
mtext("My margin text", side = 4, line = 0.5)
# side specifies which side (!) and line specifies how far away from the margin

# R has a default list of colours:
colours()
# Google is better for this - you can see the colours too!

# Use them
par(bg = "yellowgreen") # par controls persistent graphical parameters
plot(x, y, type = "n")
lines(x, y, col = "blue", lwd = 2)
points(x, y, pch = 19, col = "red")

# Return to white background:
par(bg = "white")

# You can also create your own colours using the rgb() function

# Add a legend using the legend() function:
# The format is legend(x, y, legend, pch, lty, col)
plot(x, y, type = "b", pch = 19, col = "red", lty = 4)
legend(1, 7, legend = c("My points", "My lines"),
       pch = c(19, 1), lty = c(1, 4), col = "red")

# Maybe we should remove the line from the first part
# and the dot from the second:
plot(x, y, type = "b", pch = 19, col = "red", lty = 4)
legend(1, 7, legend = c("My points", "My lines"),
       pch = c(19, -1), lty = c(-1, 4), col = "red")

# Here, -1 produces a blank (no point or line)

# x, y can be replaced with "topleft", "bottomleft" etc.:
plot(x, y, type = "b", pch = 4, col = "red", lty = 2)
legend("topleft", legend = c("My points", "My lines"),
       pch = c(19, -1), lty = c(-1, 4), col = "red")

# Use bty = 'n' to get rid of the box around the legend

###########################################################
# Customisation
###########################################################

# Good link here: http://www.statmethods.net/advgraphs/parameters.html

# Many plotting functions have a cex (character expansion) argument,
# which is given relative to the standard size:
plot(x, y, type = "b", pch = 19, col = "red", lty = 4)
text(2, 5.5, "My text here", cex = 1.5) # 1.5 times the usual size
text(4, 3.5, "My text here", cex = 0.75) # 0.75 times the usual size

# cex also works in plot, points, main, mtext etc.

# font allows you use bold (2) or italic (3) or bold italic (4)
# family allows you to change the font
plot(x, y, type = "b", pch = 19, col = "red", lty = 4)
text(2, 5.5, "My text here", font = 2, family = "Courier New")
text(4, 3.5, "My text here", font = 3, family = "Arial Narrow")

###########################################################
# Maths symbols
###########################################################

# Sometimes we want to use Greek letters, equations etc. in the titles and legend:
# help(plotmath) gives more information on this

# A simple example - use of expression() and paste() functions
plot(x, y, xlab = expression(paste(z[tau], " = ", lambda)),
     main = expression(paste(plain(e)^y^2 - 6 %->% infinity)))

# A more complicated example
text(3, 5, expression(paste(frac(1,  sigma*sqrt(2*pi)),  " ",
                            plain(e)^{frac(-(x-mu)^2,  2*sigma^2)})),
     cex = 1.5)

###########################################################
# Axes
###########################################################

# xlim and ylim change the axes limits -
# use a vector of length 2 to specify the lower and upper limits

# Changing the axis limits
plot(x, y, type = "b", pch = 19, col = "red", lty = 4,
     xlim = c(0, 8), ylim = c(-2, 9))

# Create your own specialised axis using the axis() function:
plot(x, y, type = "b", pch = 19, col = "red", xaxt = "n")
axis(side = 1, at = seq(1, 5, by = 0.2), labels = TRUE)

# Turn the numbers on the y axis to be horizontal:
plot(x, y, type = "b", pch = 19, col = "red", xaxt = "n", las = 1)
axis(side = 1, at = seq(1, 5, by = 0.2), labels = TRUE)

###########################################################
# par()
###########################################################

# The par() function creates a default plotting environment
# Everything you set is persistent,
# so it will apply to all following graphs
# This can be annoying - if you want to reset it at any stage,
# start a new R session

# help(par) is very long... but some of the more common arguments are
# mar and mgp - which set default margins and plotting region
# usr - gets the current plot limits
# mfrow/mfcol - plots an array of graphs (see below)
# las - which rotates the axis labels
# bg - which sets the background colour

# Use of par: save current settings:
opar <- par()

# This is a good default to use (though you may prefer to adapt this):
par(mar = c(3.5, 3.5, 2.5, 1.5), mgp = c(2, 0.6, 0), las = 1)
# mgp sets the label positions relative to the axes

# Replot the plot above:
plot(x, y, type = "b", pch = 19, col = "red", xaxt = "n")
axis(side = 1, at = seq(1, 5, by = 0.2), labels = TRUE)

# See: http://rfunction.com/archives/1302

# Now set the parameters back:
par(opar)
# Often warning messages with this - usually can be ignored

###########################################################
# Saving graphs
###########################################################

# Save a graph - this will go into your working directory:
pdf("myfilename.pdf", width = 10, height = 8)

# Now type all plotting commands:
plot(x, y, type = "b", pch = 19, col = "red", xaxt = "n")
axis(side = 1, at = seq(1, 5, by = 0.2), labels = TRUE)

# Tell R the plot is finished, and send to the filename:
dev.off()

# Replace pdf() with postscript(), jpeg(), png() and tiff()
# Choose units carefully - this will need trial and error
# Default for pdf() is inches, for jpeg it's pixels
# Check the help files for more info

###########################################################
# Fancier graphics:
###########################################################

# Aside from plot() which we've seen above,
# R can create many standard graphical outputs:
# bar charts, histograms, density plots, boxplots, pie charts...

# Each of the above have their own function,
# though many of the above arguments (axis limits, titles etc.)
# all work for these too

####################
# Bar charts
####################

# These are used for factor-type data:
my.cars <- factor(c(rep("Toyota", 50),
                   rep("Volkswagen", 30),
                   rep("BMW", 15),
                   rep("Nissan", 35)))

# Look at the object:
my.cars

# Plot it:
barplot(height = table(my.cars))

# Make it look nicer:
barplot(height = table(my.cars),
        main = "Car Ownership",
        col = c(1, 2, 3, 4),
        horiz = FALSE, las = 1, ylab = "Number of cars")

# How would you get these as horizontal bars?

# The main argument above is height, which is taken from the
# table of my.cars

####################
# Histograms
####################

# These are like bar charts, but for numeric data

# They are created by putting the observations into bins (breaks),
# and then counting the observations in each bin

# Let's look at the airquality dataset again:
data("airquality")

# Simple histogram of the Temperature data:
hist(airquality$Temp)

# And now to use more options:
hist(airquality$Temp, breaks = 10,
     xlab = "Temperature (in Fahrenheit)",
     main = "Histogram of daily temperature",
     col = "palevioletred")

# 'breaks' allows you to specify the number of bins, or specify where they are
# This doesn't always do what you think it should

####################
# Density plot
####################

# A density plot is a continuous (smooth) version of a histogram
# Here, a window size is specified, which slides along the x-axis
# and counts the number of observations in the window

# density() is not a plotting function, but can be plotted by calling
# plot() on a density object:
obj1 <- density(airquality$Temp)
# class(obj1)
plot(obj1)

# Plot it:
plot(density(airquality$Temp))

# Taking more control to make it look nicer:
plot(density(airquality$Temp),
     xlab = "Temperature (in Fahrenheit)",
     main = "Histogram of daily temperature",
     col = "palevioletred", lwd = 3,
     ylab = "", las = 1)

####################
# Boxplots:
####################

# These are very useful for comparing numeric measurements
# across different categories

# A boxplot consists of whiskers (representing the maximum and minimum),
# a box representing the quartiles,
# and a central line representing the median

# Sometime outliers appear outside the whiskers,
# meaning the outer lines are not the min or max any more

# Have a look at the help file to see why
# R decides something is an outlier

# Of course, this default can be changed

# Plot temperature by month:
boxplot(airquality$Temp ~ airquality$Month)

# Let's make this look nicer:
boxplot(airquality$Temp ~ airquality$Month,
        xlab = "Month",
        xaxt = "n",
        col = 2:6,
        main = "New York Temperature by Month", ylab = "")
axis(1, at = 1:5,
     labels = c("May", "June", "July", "August", "September"))
mtext("Temperature (in Fahrenheit)", side = 2, line = 2.5, las = 0)

####################
# Pie charts:
####################

# Not a recommended way to visualise/communicate data

# From the help file:
# Pie charts are a very bad way of displaying information
# The eye is good at judging linear measures and bad at judging relative areas
# A bar chart or dot chart is a preferable way of displaying this type of data

# https://www.geckoboard.com/blog/pie-charts/#.WdeYDxNSygQ

pie(table(my.cars))

#####################
# Multiple panels
#####################

# Let's see how to create multiple panels:

par(mar = c(3.5, 3.5, 2.5, 1.5), mgp = c(2, 0.6, 0), las = 1)

# There are different ways to plot several plots on a single panel
# par() is the simplest of these:
par(mfrow = c(2, 2))

# This creates a 2 x 2 plotting matrix, which is then filled by row

# Plot 1:
hist(airquality$Temp, breaks = 10, xlab = "Temperature (in Fahrenheit)",
     main = "Histogram of daily temperature", col = "palevioletred")

# Plot 2:
plot(density(airquality$Temp), xlab = "Temperature (in Fahrenheit)",
     main = "Histogram of daily temperature", col = "palevioletred", lwd = 3,
     ylab = "")

# Plot 3:
boxplot(airquality$Temp ~ airquality$Month,
        xlab = "Month",
        xaxt = "n",
        col = 2:6,
        main = "New York Temperature by Month", ylab = "")
axis(1, at = 1:5,
     labels = c("May", "June", "July", "August", "September"))
mtext("Temperature (in Fahrenheit)", 2, line = 2, las = 0)

# Plot 4:
pie(table(my.cars))

# Restores the default:
par(mfrow = c(1, 1))

#####################
# Some 3D plots
#####################

# When data is available in 3 dimensions,
# we can create contour plots, image plots, or perspective plots (and many more)

# These usually require input as a matrix,
# or else as 3 vectors: x, y and z

# The volcano data:
str(volcano)
?volcano

# Some basic plots:
contour(volcano)
image(volcano)
persp(volcano)

# Nicer 2d versions:
filled.contour(volcano,
               main = "Maunga Whau volcano height profile")

# A 3d visualisation:
library(lattice)
library(reshape2)
df1 <- melt(volcano)
names(df1) <- c('x', 'y', 'z')
wireframe(z ~ x + y, df1)

# Another 3d visualisation:
persp(volcano,  theta  =  -20,  phi  =  20,
      col  =  "thistle",  main  =  "Maunga Whau",
      expand  =  0.25,  ltheta  =  150,  shade  =  0.8,
      border  =  NA,  box  =  FALSE)

# An interactive 3d visualisation:
library(rgl)
plot3d(df1$x, df1$y, df1$z)

# Use the demo function to see some perspective plots:
demo(persp)

#####################
# Maps
#####################

# R has the ability to read in Google Maps and OpenStreetMaps

# These load in the map as a background and allow you to plot on top of it

# This is quite advanced, so we won't be learning this

# But if you're interested in it, there's some reading here:
# http://blog.fellstat.com/?p=20
# http://blog.revolutionanalytics.com/2010/01/how-to-combine-google-maps-and-data-in-r.html

# Some general links on spatial data and mapping here:
# https://cran.r-project.org/doc/contrib/intro-spatial-rl.pdf
# https://www.r-bloggers.com/want-to-learn-how-to-make-maps-in-r/
# https://www.computerworld.com/article/3038270/data-analytics/create-maps-in-r-in-10-fairly-easy-steps.html


###########################################################
#---------------------------------------------------------#
##### Lecture 1 code: introduction to R and RStudio #######
#---------------------------------------------------------#
###########################################################

##################################
# First examples:
##################################

# This is a simple command: add 2 and 2
2 + 2

# Create 7 random numbers from the Uniform distribution (default is between 0 and 1):
runif(7)

# Use the concatenate function:
x <- c(1, 2, 4)

# Display the content of x:
x

##################################
# Assignment operator:
##################################

# Show that both <- and = are valid to assign a value to a name
z <- 2 + 2
z

z = 2 + 2
z

# Access parts of x with square brackets:
x[3]
x[2:3]

# Find the sum of x and store it:
sum(x)

# Create a new variable which stores the result instead:
y <- sum(x)
y

##################################
# Simple built-in functions:
##################################

# Use multiple functions together:
z <- log(sum(x))
z

##################################
# Built-in datasets:
##################################

# Look at some data sets:
data()

# Run some basic functions on the Nile dataset:
Nile
help(Nile)
mean(Nile)
plot(Nile)
hist(Nile)

##################################
# Getting help:
##################################

# Get help using the help() function:
help(sum)
help.search('standard deviation')
?mean
??"standard deviation"

# (Note that help() is a function which works on other functions)

##################################
# A first function:
##################################

# Oddcount function
oddcount <- function(x) {
  # Set k to be 0
  k <- 0
  for(n in x) {
    # %% finds remainder on division
    if(n %% 2 == 1) k <- k + 1
  }
  return(k)
}

# Run the function:
oddcount(Nile)
oddcount(c(1, 3, 5))
oddcount(c(1, 2, 3, 7, 9))

# The first result should be 3
# It's better to test using the second vector,
# just to make sure that we are not counting *every* number

# We can also save the vector first, and then
# use the function on this saved vector:
my.vec <- c(1, 2, 13, 12, -5, -3)
oddcount(my.vec)


# Evencount function
evencount <- function(values) {
  # Set count to be 0
  count <- 0
  for(n in values) {
    # %% finds remainder on division
    if(n %% 2 == 0) count <- count + 1
  }
  return(count)
}

# Run the function:
evencount(Nile)


# divisibleBy function
divisibleBy <- function(values, divider=2, reminder=0) {
  # Set count to be 0
  count <- 0
  for(n in values) {
    # %% finds remainder on division
    if(n %% divider == reminder) 
    { 
      count <- count + 1
      print(n)
    }
  }
  return(count)
}

# Run the function:
divisibleBy( c(5,9,10,20,35,50), 10)
divisibleBy( c(5,9,10,20,35,50), 5)
divisibleBy( c(5,9,10,20,35,50))  # even numbers
divisibleBy( c(5,9,10,20,35,50), 2, 1) # odd numbers
divisibleBy( c(5,9,10,20,35,50), 2, 0) # even numbers
divisibleBy(Nile,10)



# find the number of prime numbers in a vector received
primecount <- function(values) {
  count <- 0
  for(n in values) {
    # prime number are greater than 1
    if( n > 1) 
    {
      is_prime = 1
      for ( i in 2:sqrt(n) )
      {
        if ( ( n %% i) == 0 ) {
          is_prime = 0
          break
        }
      }
      if ( n == 2){
        is_prime = 1
      }
      if (is_prime ==1) {
        print(n)
        count <- count + 1
      }
    }
    
  }
  return( paste("number of prime numbers: ",count) )
}

primecount( c(1,2,4,7,9))


# Oddcount function
oddcount2 <- function( values) {
  # Set k to be 0
  codd <- values %% 2
  return( sum(codd))
}

# Run the function:
oddcount2(c(1, 3, 5))
oddcount2(c(1, 2, 3, 7, 9))
oddcount2(Nile)

###########################################################
#---------------------------------------------------------#
##### Lecture 2 code: vectors, matrices and arrays ########
#---------------------------------------------------------#
###########################################################

# Clear everything in the workspace:
rm(list=ls())

##################################
# Creating numeric and character vectors:
##################################

x <- c(1, 2, 4)
y <- c('Maths', 'History', 'Geography')

# Use the mode() function to find out what type they are:
mode(x)
mode(y)

# Add an element to an existing vector using c():
x <- c(88, 5, 12, 13)
x

x <- c(x, 168)
x

# Delete an element from a vector:
x <- x[-5]
x

# Declare a vector (not always necessary):
y <- vector(length = 2)
y[1] <- 5
y[2] <- 12
y

# Vectorised addition:
x <- c(1, 2, 4)
y <- x + c(5, 0, -1)

# Using indexing in order to subset vectors:
y <- c(1.2, 3.9, 0.4, 0.12)
y[c(1, 3)]

# or, in two steps:
v <- c(1, 3)
y[v]

# Generate sequences using:
6:11
seq(from = 9, to = 27, by = 3)

# A vector of repeated values can also be formed:
rep(7, 4)
rep(4, 7)

# Using the all() and any() functions:
x <- 1:12
any(x < 9)
all(x < 9)
x < 9

# Introducing NA and NULL values:
x <- c(88, NA, 12, 168, 13)
x
mean(x)

# Introducing default arguments:
mean(x, na.rm = TRUE)

x <- c(88, NULL, 12, 168, 13)
mean(x)
length(x)

# Why NULL can be helpful:
z <- NULL
for(i in 1:5) z <- c(z, i)
z

z <- NA
for(i in 1:5) z <- c(z, i)
z

# In addition to seeing how NULL can be helpful in a function at the
# bottom of this script, we'll see it several times through the course,
# e.g., as a very simple way to delete an element from a list (lecture 3)

##################################
# Vectorised operations:
##################################

# *Most* functions in R are vectorised, which can be really helpful 

# Some simple vectorised operations
u <- 1:5
my.function <- function(x) return(x + 2)
my.function(u)

sqrt(1:4)

(2:6)^2
2^(2:6)
(2:6)^(2:6)

# Vectorisation and recycling:
y <- c(12, 5, 13)
y + 3

# Watch out for the warning here:
c(1, 2, 4) + c(6, 0, 9, 3, 10)

##################################
# Filtering and subsets:
##################################

# Filtering:
x <- c(6, 1:3, 12)
x
x[x > 5]

z <- c(5, 2, -3, 8)
w <- z[z^2 > 8]
w
z^2 > 8

# Subset:
subset(x, x > 5)
subset(z, z^2 > 8)

# which() returns the indexes:
z <- c(5, 2, -3, 8)
which(z^2 > 8)

# Let's use this to filter z:
z[which(z^2 > 8)]

# Understanding commands for filtering is really important
# when creating fast R code
# It can reduce a dependence on loops, and take advantage of R's
# vectorised functions

##################################
# Matrices:
##################################

# A matrix is a rectangular arrangement of numbers. You can create one using
# the matrix() function:

# Creating and indexing:
mat <- matrix(1:6, nrow = 3, ncol = 2)
mat
# This creates a matrix of the numbers 1 to 6 with 3 rows and 2 columns
# Notice that by default the matrix is filled by column

# If we want to fill by rows:
mat2 <- matrix(1:6, nrow = 3, ncol = 2, byrow = TRUE)
mat2

# Matrices can be accessed in a similar way to vectors:
mat[1, ]     # This accesses the first row of mat
mat[, 2]     # This accesses the second column of mat

# More complicated subsetting:
mat2[c(1, 3), 1]
mat2

# R treats a matrix as though it’s really a vector, so that mat[3:5] is a
# valid command

# Run:
attributes(mat)
# to see what else is stored about mat

# There are commands similar to the function c to add columns or rows to a
# matrix, using the functions cbind and rbind
mat3 <- cbind(mat, c(12, 13, 14))
mat4 <- rbind(mat2, c(99, 100))

mat3
mat4

##############################################
# Matrix Operations:
##############################################

# We often need to perform linear algebra
# operations such as matrix multiplication and addition
# in order to perform statistical techniques such as linear regression

# Matrix addition:
mat3 <- matrix(7:12, 3, 2) # Note how the names of the arguments can be omitted
mat2 + mat3

# Matrix operations - matrix multiplication:
t(mat) %*% mat

# Matrix multiplication only works when the dimensions match (details on board)
# R will complain if this is not the case:
mat %*% mat2

# Other operations, e.g. 2 * mat or mat2 + 3 occur element-wise
2 * mat
mat2 + 3

# Other useful matrix functions for the future:
I <- diag(2)   #identity matrix
M <- matrix(1:4,2,2)
det(M)
solve(M)
solve(M) %*% M  # identity matrix
eigen(M)
# See also chol, svd, qr if you like linear algebra

##############################################
# Apply:
##############################################

# The R function apply() allows you to perform functions on the rows or columns
# of a matrix. It is a very useful function

# The general structure of an apply command is:
# apply(m, dimcode, f, function.args)
# where:
# m is a matrix,
# dimcode is 1 for rows and 2 for columns,
# f is a function and
# function.args is a set of optional arguments that may be required by f

# Use of apply
apply(mat, 2, sum)
# This applies the function sum() to the matrix mat and performs the operation on
# each column

# You can also give apply() your own created function:
f <- function(x) x / sum(x)
apply(mat2, 2, f)
# Here the matrix mat2 has the function x / sum(x) applied to each of its columns

# To apply to rows:
apply(mat2, 1, f)

# What's wrong with the above output?
# An easy fix:
t(apply(mat2, 1, f))

# If the function returns a *vector*, then this is filled
# into the output column-by-column
# So if you apply by rows, you will need to transpose the result

##############################################
# A note on some differences between vectors and matrices:
##############################################

# Many vector commands still work on matrices:
# Finding its size
length(mat)

# But as mat is a matrix it has other attributes, for example:
dim(mat)
# The dim function tells you the dimension, here mat has 3 rows and 2 columns
# Similarly nrow(mat) and ncol(mat) will tell you directly how many rows and how
# many columns mat has
nrow(mat3)
ncol(mat3)

# Common problems:
# We can extract a column (or a row) from a matrix via:
r <- mat[2, ]
r

# Unfortunately r is not a matrix, it's a vector.
# This can cause problems if we'd like to keep the matrix structure
# The class() and str() functions show:
class(mat)
class(r)

str(mat)
str(r)

# Two possible fixes:
r2 <- mat[2, , drop = FALSE]
str(r2)

r2 <- as.matrix(mat[2,])
str(r2)

# (Note the difference above)

##############################################
# Column and Row names:
##############################################

# It is often helpful to give the rows or columns of a matrix some names:
# Column and row names
mat <- matrix(1:6, nrow = 3, ncol = 2)
colnames(mat) <- c('a', 'b')
rownames(mat) = c('c', 'd', 'e')
mat

# The functions rownames() and colnames() are also used to extract the names
# from a matrix:
rownames(mat)
colnames(mat)

##############################################
# Arrays:
##############################################

# Almost all of the time, we will use vectors and matrices to analyse data
# However, sometimes we need to work in higher dimensions, called arrays:

# Suppose we take measurements on weight (in kg) and levels of iron
# (in g/dL) on 3 people before and after a new weight-loss drug
# The data might look as follows

before <- matrix(c(92, 112, 86, 13, 14.2, 15.3), nrow = 3, ncol = 2)
after <-  matrix(c(89, 110, 88, 13.4, 12.8, 15.2), nrow = 3, ncol = 2)

# We can put them together via an array:
A <- array(data = c(before, after), dim = c(3, 2, 2))

# The array will now have three dimensions:
dim(A)

# Printing the data (type A) will show it layer by layer (and can often take up
# lots of screen space as the dimensions sizes grow)

# We can access and manipulate it in exactly the same way as for matrices
# Indexing and finding shape:
A[3, 1, 2]   # The third person's (3) weight (1) after the trial (2)
dim(A)

##################################
# Example 1:
##################################

# Function to find the occurrences of a
# particular number k in a vector x:
find.k <- function(x, k) {
  n <- length(x)
  out <- NULL
  for(i in 1:n) {
    if(x[i] == k) out <- c(out, i)
  }
  return(out)
}

# Using the function
y <- sample(1:5, 20, replace = TRUE)
y
find.k(y, 1)
find.k(y, 2)
find.k(y, 3)
find.k(y, 7)

##################################
# Example 2 - ifelse()
##################################
# Like many programming languages, R has an if-then-else function called
# ifelse. The format is:
# ifelse(test, yes, no)
# Here test is a logical statement, yes are the values to be supplied if the
# statement is true and no the values to be supplied if the statement is false
# e.g.: Using 'ifelse'
##################################

x <- 1:10
y <- ifelse(x %% 2 == 0, "Even", "Odd")
y

##################################
# Example 3 - image manipulation
##################################

# A common use for matrices is to store images

# You can think of a black and white image as an n by m matrix where the
# numbers in the matrix represent how white that pixel should be

# The following code uses the package pixmap

# The first time we use a package we have to install it:
# Install the pixmap package:
install.packages('pixmap')

# Load the pixmap package
library(pixmap)

# Then we can use the function read.pnm included in the package pixmap to
# create an image with R (in colour first)
# (ppm is a file type, Portable PixMap)
x <- read.pnm("blackbuck_antelope.pbm")
plot(x)

# Turn it to greyscale:
y <- as(x, "pixmapGrey")
plot(y)

# Looking at the structure (str()) of y shows the matrix used to create the plot
# Note: this package uses something called the S4 class which requires @ rather
# than $ to access components
str(y)

# The grey component here stores the picture as numbers between 1 and 0.
# We can access them in exactly the same way as a standard matrix
# Look at the matrix:
y@grey
y@grey[1:10, 1:10]
y@grey[300:305, 400:405]

# By changing the elements of the matrix, it's possible to change the picture:
# First, let's manipulate it:
y2 <- y
y2@grey <- 1 - y2@grey # Creates a negative
plot(y2)

y3 <- y
y3@grey <- 0.8 * y3@grey # Makes it darker
plot(y3)

y4 <- y
y4@grey[y4@grey<0.8] <- 0 # Makes dark areas black
plot(y4)

# See if you can find other fun ways to play with the
# image by using apply or other functions we've met so far

# Finally:
# Combine all plots in a matrix with 2 rows and 3 columns
# par is used to set or query graphical parameters
# mfrow fills by row, a panel of images:
par(mfrow = c(2, 3))

plot(x, main = "x: Original")
plot(y, main = "y: Original, greyscale")
plot(y2, main = "y2: Negative")
plot(y3, main = "y3: Darker")
plot(y4, main = "y4: Dark areas black")

par(mfrow = c(1, 1)) # reset to default


##################################
# Summary
##################################

# We now know how to create and manipulate vectors, matrices and arrays

# We've met lots of new functions (e.g., apply, which, ifelse)

# R vectorises operations which makes code run faster

# We now how to install and load R packages

###########################################################
#---------------------------------------------------------#
######### Lecture 7 code: Maths and Stats in R ############
#---------------------------------------------------------#
###########################################################

# Clear everything in the workspace:
rm(list=ls())

##################################
# Task 1:

# Load the dataset:
data(swiss)

?swiss
head(swiss)
str(swiss)

# What were the three provinces with the
# highest values in the Examination variable?
swiss[order(swiss$Examination),]

# Either look at the tail:
tail(swiss[order(swiss$Examination),])
# The answer is: "V. De Geneve", "Neuchatel", "La Vallee"

# Or order by descending, and look at the head():
swiss[order(-swiss$Examination),]
head(swiss[order(-swiss$Examination),])
rownames(swiss[order(-swiss$Examination),])[1:3]

# Next, what is the value of agriculture for the
# province with the highest percentage of catholic people?
swiss[order(swiss$Catholic),]

# Better to use descending again:
swiss[order(-swiss$Catholic),]
swiss[order(-swiss$Catholic),][1, 'Agriculture']
# The value of agriculture for this province is 89.7

##################################
# Task 2:

# Use sweep to subtract the mean and divide
# by the sd for the swiss dataset:

# Find the means:
mean.swiss <- apply(swiss, 2, mean)
mean.swiss

# Find the standard deviations:
sd.swiss <- apply(swiss, 2, sd)
sd.swiss

# Use sweep to subtract the mean:
swiss2 <- sweep(swiss, 2, mean.swiss)

# Use sweep to divide the result by the sd:
swiss.standardised <- sweep(swiss2, 2, sd.swiss, "/")

# Now note how useful sweep has been here:
boxplot(swiss)
boxplot(swiss.standardised)

# All of the variables are now comparable,
# and the *shape* of them has been preserved

##################################
# Task 3:

urn <- c("red", "blue", "yellow", "green")

# Load the necessary library:
library(gtools)

# Pick 2 discs from the urn *without* replacement
# and get all possible permutations
permutations(n = length(urn), r = 2, v = urn, repeats.allowed = FALSE)

# There are:
nrow(permutations(n = length(urn), r = 2, v = urn, repeats.allowed = FALSE))
# such permutations

# Pick 2 discs from the urn *without* replacement
# and get all possible combinations
combinations(n = length(urn), r = 2, v = urn, repeats.allowed = FALSE)

# There are:
nrow(combinations(n = length(urn), r = 2, v = urn, repeats.allowed = FALSE))
# such combinations

##################################
# Task 4:

# Look at pairwise correlations:
round(cor(swiss), 3)

# The relationship between:
# Education and Fertility,
# Examination and Fertility,
# Examination and Agriculture,
# Education and Agriculture,
# Education and Examination,
# all have absolute values larger than 0.6

# Examination and Education are the most highly correlated
# (unsurprisingly, a positive correlation)

# Performing the hypothesis test:
cor.test(swiss$Catholic, swiss$Education)
# Fail to reject the null hypothesis

# Linear regression: response variable y
# and (possibly multiple) explanatory variables
# Note the . means all other variables
mod <- lm(Fertility ~ ., data=swiss)

# Give basic model details:
summary(mod)
# Examination is unimportant, and could be dropped
# All other variables are important

# (Next step would be to remove Examination, and run again)

# Plot the model diagnostics:
plot(mod)

# Some great resources on understanding this output here:
# https://data.library.virginia.edu/diagnostic-plots/
# https://stats.stackexchange.com/questions/58141/interpreting-plot-lm
# https://www.theanalysisfactor.com/linear-models-r-diagnosing-regression-model/

##################################
# Task 5:

# Solve the following set of simultaneous equations using solve
# 2x1 + x2 - x3 = 7
#       x2 - 2x3 = -9
# x1 + 3x2 + 2x3 = 11

A <- matrix(c(2, 0, 1, 1, 1, 3, -1, -2, 2), ncol = 3, nrow = 3)
b <- matrix(c(7, -9, 11), ncol = 1)
x <- solve(A, b)
x

# Check it:
A %*% x
all(A %*% x == b)

##################################
# Task 6:

# Use R to calculate the derivative of the following functions,
# with respect to x:

# x^2 sin(x)
D(expression(x^2 * sin(x)), 'x')

# 6a^x
D(expression(6*a^x), 'x')

# 2* x - log(x)*sin(x) + cos(x) - 4
D(expression(2* x - log(x)*sin(x) + cos(x) - 4), 'x')

##################################
# Task 7:

# Create some plots of the curves and their derivatives over the range x = 0 to 10
# Plot the derivatives on top of the curves:
curve(sin(x)*x^2, from=0, to=10)
curve(eval(D(expression(sin(x)*x^2), 'x')),
      from=0, to=10, add = TRUE, col = "red")

a <- 2
curve(a^x, from=0, to=10)
curve(eval(D(expression(a^x), 'x'), list(a=a)),
      from=0, to=10, add = TRUE, col = "red")

curve(2* x - log(x)*sin(x) + cos(x) - 4, from=0, to=10)
curve(eval(D(expression(2* x - log(x)*sin(x) + cos(x) - 4), 'x')),
      from=0, to=10, add = TRUE, col = "red")

##################################
# Task 8:

# Integrate dnorm to find P(X <= 1) when X ~ N(0,1)
integrate(function(x) dnorm(x, 0, 1), -Inf, 1) # 0.841

# Compare with:
pnorm(1)

# Integrate dt to find P(X > -2) when X ~ t_6
# Either:
1 - integrate(function(x) dt(x, df = 6), -Inf, -2)$value # 0.954
# or:
integrate(function(x) dt(x, df = 6), -2, Inf)$value # 0.954

# Compare with
1 - pt(-2, df = 6)
# or:
pt(-2, df = 6, lower.tail = FALSE)


###########################################################
#---------------------------------------------------------#
################## Tutorial 1 answers #####################
#---------------------------------------------------------#
###########################################################

###########################################################
# Qs 1, 2, 3 and 4 should be done first
###########################################################

###########################################################
# Q5:
###########################################################
# Some info about names of objects here:
# https://www.r-bloggers.com/rules-for-naming-objects-in-r/
# https://www.dummies.com/programming/r/how-to-successfully-follow-naming-conventions-in-r/

# Now, here's the old oddcount function
oddcount <- function(x) {
  # Set k to be 0
  k <- 0 
  for(n in x) {
    # %% finds remainder on division
    if(n %% 2 == 1) k <- k + 1 
  }
  return(k)
}

oddcount(c(1, 3, 5))
oddcount(c(1, 2, 3, 7, 9))

###########################################################
# First, change it to count the even integers, giving it the obvious name:
evencount <- function(x) {
  # Set k to be 0
  k <- 0 
  for(n in x) {
    # %% finds remainder on division
    if(n %% 2 == 0) k <- k + 1 
  }
  return(k)
}

evencount(c(1, 3, 5))
evencount(c(1, 2, 3, 7, 9))

###########################################################
# Q6:
###########################################################
# Now let's count the integers divisible by 10:
ten.count <- function(x) {
  # Set k to be 0
  k <- 0 
  for(n in x) {
    # %% finds remainder on division
    if(n %% 10 == 0) k <- k + 1 
  }
  return(k)
}

ten.count(c(1, 3, 5, 6, 10, 20, 50))
ten.count(c(1, 2, 10))

###########################################################
# Q7:
###########################################################
# Now let's write a function to find the number of prime numbers
# in a vector x
# (There are lots of different ways to do this)
primecount <- function(x) {
  # Set k to be 0
  k <- 0
  for(n in x) {
    # Deal with the special case of 2 first:
    if(n == 2) {
      k <- k + 1
    } else if(n > 2) {
      # Now deal with all integers bigger than 2:
      if(all(n %% 2:(n-1) != 0)) k <- k + 1
      # != means 'not equal to'
    }
  }
  return(k)
}

# Test it:
primecount(c(2, 3, 5, 6, 7, 8))
primecount(1:50)

# Does it work for this? (What is this type of prime called?)
primecount(2^13-1)

###########################################################
# Of course there is a shorter way to do this
# R has a package which tests for prime numbers

# Let's install it first (only needs to be done once):
install.packages('gmp')

# Now load it (which loads all functions and objects with it):
library(gmp)

# Read about the isprime function in the package:
?isprime

# Now run it:
isprime(c(2, 3, 5, 6, 7, 8))
isprime(1:50)

# What does the output mean?

# Does it work for this? (What is this type of prime called?)
isprime(2^13-1)

###########################################################
# Q8:
###########################################################
# Let's write oddcount2 which which doesn't use a for loop
oddcount2 <- function(x) {
  # Set y to be a vector of
  # TRUEs and FALSEs - TRUE when odd, FALSE when not odd
  y <- x %% 2 == 1
  
  # Add up all the TRUEs in y (this is a shortcut)
  k <- sum(y)
  
  # return the value of k
  return(k)
}

oddcount2(c(1, 3, 5))
oddcount2(c(1, 2, 3, 7, 9))

# Now let's write oddcount3, which doesn't use a for loop
# (as above), return the sub-vector of odd numbers, and which prints
# this sub-vector and the count:

# We'll copy the function above, and just change a little bit of
# what it outputs:
oddcount3 <- function(x) {
  # Set y to be a vector of
  # TRUEs and FALSEs - TRUE when odd, FALSE when not odd
  y <- x %% 2 == 1
  
  # Add up all the TRUEs in y (this is a shortcut)
  k <- sum(y)
  
  # Let's print these two things:
  cat('There are', k, 'odd numbers in x - these odd numbers are:', x[y], '\n')
  
  # return the values in x where y is true:
  return(x[y])
}

oddcount3(c(1, 3, 5))
oddcount3(c(1, 2, 3, 7, 9))

res1 <- oddcount3(c(1, 3, 5))
res2 <- oddcount3(c(1, 2, 3, 7, 9))

###########################################################
#---------------------------------------------------------#
######## Tutorial 2: vectors, matrices and arrays #########
#---------------------------------------------------------#
###########################################################

##################################
# Task 1 - create a vector x of odd numbers from 1 to 9,
# (i) using the concatenate function:
x <- c(1, 3, 5, 7, 9)
x

# (ii) using vector():
x <- vector(length = 5)
x[1] <- 1
x[2] <- 3
x[3] <- 5
x[4] <- 7
x[5] <- 9
x

# (iii) using seq():
x <- seq(1, 9, by = 2)
x

##################################
# Task 2 - append the four numbers 11, 12, 13 and 14:
x <- c(x, 11, 12, 13, 14)
x

# Lots of ways to do this next task. One suggestion:
x <- x[x%%3 != 0]

# Multiply your vector by 3, then add the vector z = 6:5
z <- 6:5
w <- 3*x + z
w
# z is recycled so no error here

##################################
# Task 3 - write some code to determine if any values in w are less than 30
any(w < 30)
# TRUE

# Write some code (using subset) to determine all
# the values in w that are divisible by 3
subset(w, w %% 3 == 0)

# Find which elements of w are greater than 20
which(w > 20)
# Ans: the third, fourth, fifth and sixth

##################################
# Task 4 - create a matrix from the following command:
M <- matrix(1:12, 4, 3)

# Access the first row of M:
M[1, ]

# Access the second column of M:
M[ ,2]
M[ ,2, drop = FALSE] # Remember that this keeps the row or column structure 

# Take the second and third row and the 2nd column
M[2:3, 2]
M[2:3, 2, drop = FALSE]

# Call it vec1:
vec1 <- M[2:3, 2]

# An easy part - calculate the mean of this:
mean(vec1)

##################################
# Task 5 - What does the following command do?
apply(M, 1, sum)

# Gives row sums
# How do you find column sums using apply()?
apply(M, 2, sum)

# What happens when you run this again, but after setting the bottom right value to be NA?
M[4, 3] <- NA
M
apply(M, 1, sum) 

# You get an NA in your answer
# Add an extra argument to the apply command:
apply(M, 1, sum, na.rm=TRUE)

# Now it works!

##################################
# Task 6 - Take the find.k function and change it to look for runs of length 2
# Try to comment this function too:
find.k.2 <- function(x, k) {
  n <- length(x)
  out <- NULL
  for(i in 1:(n-1)) { # Why do I need this here?
    if(x[i] == k && x[i+1] == k) out <- c(out, i)
  }
  return(out)
}

# Using the function
y <- sample(1:5, 20, replace = TRUE)
y
find.k.2(y, 1)
find.k.2(y, 2)
find.k.2(y, 3)
find.k.2(y, 7)

# Now to change it to work for runs of length n
# This one is tricky:
find.k.n <- function(x, k, n) {
  m <- length(x)
  runs <- NULL
  for(i in 1:(m - n + 1)) {
     if(all(x[i:(i + n -1)] == k)) {
      runs <- c(runs,i)
    }
  }
  return(runs)
}

y <- c(1, 1, 1, 2, 1, 2, 3, 2, 1, 2, 3, 4, 3, 2, 2, 2, 2, 1, 1)

# Test find.k.n:
find.k.n(y, k=1, n=1)
find.k.n(y, k=1, n=2)
find.k.n(y, k=1, n=3)
find.k.n(y, k=1, n=4)
find.k.n(y, k=2, n=4)

##################################
# Task 7 - Load in the pixmap package and have some more fun manipulating the picture
install.packages("pixmap") # Only need to run this once
library(pixmap)

# To read in your own pbm file, you'll need to change the address below
# to use your own file path and file name:
x1 <- read.pnm(file = "MyDocuments/image1.pbm")
plot(x1)

# Now try to change and manipulate it

###########################################################
#---------------------------------------------------------#
################# Tutorial 5: Plotting ####################
#---------------------------------------------------------#
###########################################################

# Clear everything in the workspace:
rm(list=ls())

##################################
# Task 1:

# Look at the demo:
demo(graphics)

##################################
# Task 2:

# Load the iris data, and see what it contains:
data(iris)
?iris
str(iris)
head(iris)

# A dataframe of 150 observations of 5 variables
# 4 are numeric, 1 is a factor

##################################
# Task 3:

# A plot of sepal length versus petal length:
plot(iris$Sepal.Length, iris$Petal.Length)

##################################
# Task 4:

# Make a better plot using type='n'
# and using different colours for each species
par(mar = c(3.5, 3.5, 2.5, 1.5), mgp = c(2, 0.6, 0), las = 1)
plot(iris$Sepal.Length, iris$Petal.Length, type = 'n',
     xlab = "Sepal Length", ylab = "Petal Length",
     las = 1, main = "Sepal vs. Petal Length by Species")
points(iris$Sepal.Length[iris$Species=='setosa'],
       iris$Petal.Length[iris$Species=='setosa'],
       col='red', pch=16)
points(iris$Sepal.Length[iris$Species=='versicolor'],
       iris$Petal.Length[iris$Species=='versicolor'],
       col='blue', pch=16)
points(iris$Sepal.Length[iris$Species=='virginica'],
       iris$Petal.Length[iris$Species=='virginica'],
       col='green4', pch=16)
legend("bottomright",
       legend = c("Setosa", "Versicolor", "Virginica"),
       pch = 16, col = c("red", "blue", "green4"))

# A shortcut here:
plot(iris$Sepal.Length, iris$Petal.Length,
     col=c("maroon", "dodgerblue2", "gold")[iris$Species], pch = 16,
     xlab = "Sepal Length", ylab = "Petal Length", 
     las = 1, main = "Sepal vs. Petal Length by Species")
legend("bottomright", legend = c("Setosa", "Versicolor", "Virginica"),
       pch = 16, col = c("maroon", "dodgerblue2", "gold"))

# And if the colours are not important:
plot(iris$Sepal.Length, iris$Petal.Length,
     col=iris$Species, pch=16,
     xlab="Sepal Length", ylab="Petal Length",
     las = 1, main = "Sepal vs. Petal Length by Species")
legend("bottomright", legend = c("Setosa", "Versicolor", "Virginica"),
       pch = 16, col = 1:3)

##################################
# Task 5:

# Create a factor from the petal width variable:
iris$Petal.Cat <- cut(iris$Petal.Width,
                      breaks = c(0, 1, 2, 3),
                      labels = c("small", "medium", "large"),
                      ordered_result = TRUE)

##################################
# Task 6:

# Create a barplot of Petal.Cat:
counts1 <- table(iris$Petal.Cat)
barplot(counts1, col = 1:3,
        names.arg = c("Small", "Medium", "Large"),
        ylim = c(0, 80),
        las = 1, ylab = "Frequency")
title("Frequency of petal width categories")

##################################
# Task 7:

# Create a clustered bar plot of Petal.Cat grouped by Species

# Get a table first:
counts2 <- table(iris$Species, iris$Petal.Cat)

# Plot this, using beside = TRUE:
barplot(counts2, beside = TRUE)

# Now to make it look nice:
rownames(counts2) <- c("Setosa", "Versicolor", "Virginica")
barplot(counts2, beside = TRUE,
        col = 1:3,
        names.arg = c("Small", "Medium", "Large"),
        ylim = c(0, 60),
        las = 1, ylab = "Frequency",
        legend = rownames(counts2))
title("Frequency of petal width categories \n by species")

##################################
# Task 8:

# Create a boxplot of sepal length by species:
boxplot(iris$Sepal.Length ~ iris$Species)

# Make it look nicer:
boxplot(iris$Sepal.Length ~ iris$Species,
        las = 1, main = 'Sepal length by species',
        col = c('red', 'darkblue',  'green3'),
        ylab = 'Sepal length (in cm)',
        names = c("Setosa",  "Versicolor",  "Virginica"), 
        xlab = "Species")
grid()

##################################
# Task 9:

# Up to you!
