setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')

library('readxl')
library('ggplot2')

population <- read_excel('world-population.xlsm')

#Constructing the line chart
#I will plot the world population over time

ggplot(population, aes(Year, Population)) + geom_line(color = 'blue') + ylab('World Population ') + ggtitle('R - line chart: World population (1960-2010)')

#Constructing the step chart
#A step chart is similar to a line chart, but increases and decreases between points are represented in a step fashion
#I will plot the world population over time
ggplot(population, aes(Year, Population)) + geom_step(color = 'blue') + ylab('World Population ') + ggtitle('R - step chart: World population (1960-2010)')
