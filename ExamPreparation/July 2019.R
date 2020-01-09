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

