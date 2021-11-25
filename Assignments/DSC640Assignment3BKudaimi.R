setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')

#Importing the necessary libraries
library(treemap)
library(dplyr)
library(ggplot2)

#Importing the data
expenditure <- read.delim('expenditures.txt', header = TRUE, sep = "\t")
unemployment <-  read.csv('unemployement-rate-1948-2010.csv')

#Constructing the treemap
#I will plot the expenditure proportions spent on different items in 2008

#Filtering the entries for the year 2008
exp_2008 <- expenditure %>% filter(year == 2008)

#Generating the treemap
treemap(exp_2008, 
        index = c("category"),  
        vSize = "expenditure",
        palette = "Blues", 
        title = "R - treemap: Proportion of expenditures on different items in 2008", 
        fontsize.title = 14)

##Constructing the area chart
#I will plot the unemployment rate over time
#I will use January of each year as the x-axis tick mark, so each year will have one value on the area chart

#Filtering out January of each month
unemployment_jan <- unemployment %>% filter(Period == 'M01')

#Generating the area chart
ggplot(unemployment_jan, aes(Year, Value)) + geom_area(fill = 'blue') + ylab('Unemployment Rate (%)') + ggtitle('R - area chart: Unemployment Rate Percent (1948-2010)')


#Constructing the stacked area chart
#I will plot the expenses for each year split by category
ggplot(expenditure, aes(year, expenditure, fill = category)) + geom_area() + xlab('Year') + ylab('Expenditure ($)') + ggtitle('R - stacked area chart: Expenditures by category (1984-2008)')
        


