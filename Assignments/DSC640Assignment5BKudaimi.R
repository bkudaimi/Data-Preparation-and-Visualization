setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')

#Importing the necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(pheatmap)
library(RColorBrewer)
library(ggmap)

costcos <- read.csv('costcos-geocoded.csv')
ppg <- read.csv('ppg2008.csv')

#Building the heatmap
#I will visualize the number of different types of special shots 
#(field goals, free throws, and 3-pointers) made by each player

#The dataset contains many numbers, so only the columns of special shots will be subset
newdf <- ppg %>% select(FGM, FTM, X3PM)
rownames(newdf) <- ppg$Name

#Renaming the columns to make them easier to understand
colnames(newdf) <-  c('Field goals', 'Free throws', '3-pointers')

#Generating the heatmap
data <- as.matrix(newdf)
pheatmap(data, color = brewer.pal(9,"Reds"), treeheight_row = 0, treeheight_col = 0, fontsize = 7,  main = 'R - heatmap: Number of different types of shots per NBA player')



#Building the spatial chart
#I will view the spatial locations of each US Costco
qmplot(Longitude, Latitude, data = costcos, zoom = 5) + ggtitle('R - spatial chart: US Costco locations')



#Building the contour plot
#I will generate artificial elevations to plot along the latitudes and longitudes of the Costco dataset

#Setting the x and y values and making the contour grid
x <- costcos$Latitude
y <- costcos$Longitude
dat <- expand_grid(x = x, y = y)

#Generating the artificial elevations using the following equation 
dat <- mutate(dat, z = x ^ 2 + y ^ 2)

#Generating the contour chart
ggplot(dat, aes(y, x)) + geom_contour(aes(z = z, color = ..level..)) + scale_color_continuous("Elevation (ft)") + xlab('Longitude') + ylab('Latitude') +ggtitle('R - contour plot: Generated elevations for certain latitudes and longitudes')
