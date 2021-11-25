setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')

#Importing the necessary libraries
library(ggplot2)
library(dplyr)

#Importing the data
birth <- read.csv('birth-rate.csv')
crime <- read.csv('crimerates-by-state-2005.csv')
TV <- read.csv('tv_sizes.txt', header = TRUE, sep = "\t")


#Constructing the scatter plot
#I will plot the annual birth rate in the United States 

#Separating out the annual birth rate into a new data frame
years <- colnames(birth)[2:length(colnames(birth))]
rates <- birth[birth['Country'] == 'United States']
rates <- rates[2:length(rates)]
df <- data.frame(years, rates)
df$years <- substring(df$years, 2)

#Generating the scatter plot using this data frame
ggplot(df, aes(years, rates)) + geom_point(color = 'blue') + theme(axis.text.x = element_text(angle = 90)) + xlab('Year') + ylab('Birth Rate (%)') + ggtitle('R - scatter plot: Annual US Birth Rate')



#Constructing the bubble chart
#I will plot how robbery changes with increasing aggravated assault for each US state, using population as the bubble size

#I will remove the national average and Washington DC since the US population is much 
#greater than its constituent states and Washington DC is not a state.
crime <- crime %>% filter(state != 'United States')
crime <- crime %>% filter(state != 'District of Columbia')

ggplot(crime, aes(aggravated_assault, murder, size = population)) + geom_point(color = 'blue', alpha = 0.5) + xlab('Aggravated Assault Rate') + ylab('Murder Rate') + ggtitle('R - bubble chart: How US state murder rates change with assault rates')

#Constructing the density plot
#I will show the probabiliy density of TV sizes from 2001 to 2009

ggplot(TV, aes(size)) + geom_density(fill = 'blue') + xlab('TV size (inches)') + ylab('Density') + ggtitle('R - density plot: Probability density of TV size distribution (2001-2009)')