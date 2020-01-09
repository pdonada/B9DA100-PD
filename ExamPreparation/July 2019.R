# The dataset tips is located in the reshape2 package in R. It contains information on the tips received by a waiter while working in a restaurant for several months. Each row/record in the dataset corresponds to a different table of customers. 
# 
# a. Install the reshape2 package, load the library, and access the dataset tips. Include the commands needed to look at both the structure of the dataset and its help file. Summarise the dataset

install.packages('reshape2')
library(reshape2)
data("tips")
?tips
str(tips)
summary(tips)

# b. The smoke variable records if there were any smokers at the table. How many tables had smokers present? 
head(tips)
#table(tips$smoker)
table(tips$smoker, exclude='No')

# c. What is the size of the largest group of diners? How many groups of this size dined at the restaurant? What was the largest bill amongst these groups?   
#aggregate(tips[ , c(7)], list(tips$total_bill, tips$size), max)
larg_size <- tips[which.max(tips$size), 'size']
nro_group <- nrow(subset(tips, size == larg_size))
group_siz <- subset(tips, size==6)
larg_bill <- group_siz[which.max(group_siz$total_bill), 'total_bill']
cat('Largest group:',larg_size,', Number of groups:', nro_group,', Largest bill:', larg_bill)

# It’s difficult to analyse the amount left as a tip, without taking the size of the corresponding bill into consideration. In order to do this, form a new column called percentage.tip which contains the percentage of the bill which the tip constitutes (e.g., if a bill is €50 and the tip is €5, then this new column would record that the percentage.tip is 10 - i.e., 10%). What is the average percentage tip?
tips$percentage.tip <- round(100 * (tips$tip / tips$total_bill), 2)
avrg_tips <- round(mean(tips$percentage.tip), 2)

# e. Which sex/day combination left the smallest mean percentage.tip?
aggregate(tips[ , c(1, 2, 4, 6, 7, 8)],
          list(tips$sex, tips$day),
          mean)
cazzo <- aggregate(tips[ , c(1, 2, 4, 6, 7, 8)],
                   list(tips$sex, tips$day),
                   mean)
smal_mean <- cazzo[ which.min(cazzo$percentage.tip), ]

# Create a new column called rating which converts percentage.tip to an ordered factor using the cut() function. Use bins of 0 - 10% (“Normal”), 10 - 20% (“Generous”), and 20 - 50% (“Very generous”).
tips$rating <- cut(tips$percentage.tip, breaks = c(0, 10, 20, 50), 
                   labels = c('Normal', 'Generous', 'Very generous'),
                   ordered_result = TRUE)

# g. The time variable records whether a table of diners sat at Dinner or Lunch. Make a two-way table of time vs. rating. How many tables at lunch are considered generous? 

time_ratn <- table(tips$time, tips$rating)
time_ratn['Lunch', 'Very generous']

####################################33

# Let's look at the airquality dataset again:
data("airquality")

# Simple histogram of the Temperature data:
hist(airquality$Temp)

# And now to use more options:
hist(airquality$Temp, breaks = 10,
     xlab = "Temperature (in Fahrenheit)",
     main = "Histogram of daily temperature",
     col = 'plum2',
     labels = TRUE)

# Plot temperature by month:
boxplot(airquality$Temp ~ airquality$Month)

boxplot(airquality$Temp ~ airquality$Month,
        xlab = "Month",
        xaxt = "n",
        col = 2:6,
        main = "New York Temperature by Month", ylab = "")
axis(1, at = 1:5,
     labels = c("May", "June", "July", "August", "September"))
mtext("Temperature (in Fahrenheit)", side = 2, line = 2.5, las = 0)

weather <- density(airquality$Temp)
head(airquality)

my_summary <- function(dataset) {
  years_beg <- min(dataset$Month, na.rm = TRUE)
  years_end <- max(dataset$Month, na.rm = TRUE)
  cat('Begin and End something:', years_beg, 'and',years_end)
  
  wind_min <- min(dataset$Temp, na.rm = TRUE)
  cat('\nMinimum something:', wind_min)
  
  oz_mean <- mean(dataset$Ozone, na.rm = TRUE)
  cat('\nMaximum something', oz_mean)

  tot_month = max(dataset$Month, na.rm = TRUE)
  cat('\nAnother Max something', tot_month)
    }
my_summary(airquality)
