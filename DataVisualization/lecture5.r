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
        horiz = FALSE, las = 1, ylab = "Number of cars", xlab = "cazzo")

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
install.packages("rgl")
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
