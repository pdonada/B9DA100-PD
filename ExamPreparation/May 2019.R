install.packages('carData')
library(carData)
data("Chile")

head(Chile)
?Chile

str(Chile)

# c. Find the mean income of all respondents for which data is available
inc_mean <- mean(Chile$income, na.rm = TRUE)
inc_mean

# Create a two-way table to examine the relationship between region and sex.  Describe the results. How many female respondents from the city of Santiago are there?   
reg_sex <- table(Chile$region, Chile$sex)
reg_sex
reg_sex['SA', 'F']

# Remove all rows with missing values to create a new dataset Chile2. What is the size of the dataset now? Work with this reduced dataset for the remainder of Question 1. 
Chile2 <- na.omit(Chile) 
nrow(Chile2)
nrow(Chile)

#Find the mean and standard deviation of the age of the respondents, grouped by the sex variable. Describe your findings
head(Chile2)
mean(Chile2$age)
sd(Chile2$age)



library(plyr)
cdata <- ddply(Chile2, c('sex'), summarise,
               mean = mean(age),
               sd   = sd(age))
cdata

#using aggregate
cmeans <- aggregate(Chile2[ c('age')],
                   by = Chile2[c('sex')],
                   FUN = mean)
names(cmeans)[names(cmeans)=="age"] <- "mean"

sdmeans <- aggregate(Chile2[ c('age')],
                     by = Chile2[c('sex')],
                     FUN = sd)
names(sdmeans)[names(sdmeans)=="age"] <- 'sd'

mean.sd.data <- merge(cmeans, sdmeans)

mean.sd.data

#The education variable is a factor, but it is not ordered. Convert it into a sensibly ordered factor (primary education is ‘less than’ secondary education which is ‘less than’ post-secondary education)
head(Chile2)
str(Chile2)
Chile2$education <- factor(Chile2$education, levels = c('P', 'S', 'PS'), ordered = TRUE)

# Use the aggregate function to aggregate the income and age variables by the factors of sex and vote, returning a single object

final_quest <- aggregate(Chile2[ c('income', 'age')],
                       by = Chile2[c('sex', 'vote')],
                       FUN = mean)
highst_mean <- final_quest[which.max(final_quest$income), c('sex','vote')]
highst_mean
mean_age <- final_quest[which.max(final_quest$income), 'age']
mean_age

install.packages('MASS')
library(MASS)
data('Cars93')

head(Cars93)
str(Cars93)
?Cars93
min(Cars93$Price)

#b. Produce a histogram of the Price variable, and make the graph look neat and presentable (paying particular attention to labels, colours, titles etc.). Comment on the resulting graph.
hist(Cars93$Price)
hist(Cars93$Price, 
     xlab = "Price",
     ylab = 'Number of Cars',
     main = "Data from 93 Cars on Sale in the USA in 1993",
     col = 'plum2',
     labels = TRUE)

#Use the type='n' argument (or otherwise) to help you to create a scatterplot of the Length variable against the Price variable where there are three distinct groups in the plot, depending on the DriveTrain type of the cars. 
install.packages('car')
library(car)
scatterplot( Length ~ Price | DriveTrain, data = Cars93,
             xlab='x label', ylab='y label',
             main='main label', las = 1,
             legend=c(title = 'qualquer coisa',
                    coords="bottomright") ) 

?legend

# The code below is used to take a matrix of numeric data, find the rows in this matrix which have at least one positive number, and then return the index of these rows. 
# 
# (To save you time, you can find the code in the file Q3.R contained in the Exam folder.) 
# 
fun1 <- function(mat) {
  #set a variable as null
  out <- NULL 
  #start a loop to check all lines until the number of lines of mat
  for(i in 1:nrow(mat)) {     
  #if any value in the line checked be greater than 0, add the line number to the variable as a list  
    if(any(mat[i,] > 0)) {       
      out <- c(out, i)     
    }   
  }
  return(out) 
}
set.seed(13) 
my.mat <- matrix(rnorm(20), 10, 2) 
my.mat 
res1 <- fun1(my.mat) 
res1


#Comment on the relative advantages and disadvantages of using the benchmark() function (from the rbenchmark library) vs. the Rprof() function
# A benchmark is something that measures the time for some whole operation. e.g. I/O operations per second under some workload. So the result is typically a single number, in either seconds or operations per second. Or a data set with results for different parameters, so you can graph it.
# You might use a benchmark to compare the same software on different hardware, or different versions of some other software that your benchmark interacts with. e.g. benchmark max connections per second with different apache settings.
# 
# Profiling is not aimed at comparing different things: it's about understanding the behaviour of a program. A profile result might be a table of time taken per function
# You use a profile to figure out where to optimize. A 10% speedup in a function where your program spends 99% of its time is more valuable than a 100% speedup in any other function. Even better is when you can improve your high-level design so the expensive function is called less, as well as just making it faster.

