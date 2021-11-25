setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')

#Importing the necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(readxl)
library(plotly)

#Importing the data
crime <- read.csv('crimeratesbystate-formatted.csv')
education <- read.csv('education.csv')
emissions <- read.csv('CO2 Emissions_Canada.csv')
computer <- read_excel('Computer Hardware Sales.xlsx')

#Building the histogram
#I will plot the distribution of math scores across all US states
A <- ggplot(education, aes(x = math)) + geom_histogram(fill = 'blue', bins = 20) + xlab('Math test score') + ylab('Count') + ggtitle('R - histogram: Distribution of average math test scores per US state')



#Building the boxplot
#I will plot the distribution of motor vehicle theft rates across all US states
B <- boxplot(crime$motor_vehicle_theft, data = crime, main = "R - boxplot: Distribution of average motor vehicle theft rates per US state", ylab = "Motor vehicle theft rate")



#Building the bullet chart
#I will show whether an electronics store met its sales targets for each product  
G <- ggplot(computer, aes(Product, Excellent)) + 
  geom_bar(aes(Product, Excellent), fill = "darkgreen", stat = "identity", width = 0.5) + 
  geom_bar(aes(Product, Satisfactory), fill = "yellow", stat = "identity", width = 0.5) + 
  geom_bar(aes(Product, Poor), fill = "red", stat = "identity", width = 0.5) + 
  geom_bar(aes(Product, Actual), fill = "black", stat = "identity", width = 0.2) + 
  geom_point(aes(Product, Target), color = "blue", size = 5) + 
  ylab('Sales') + 
  ggtitle('R - bullet chart: Actual vs target sales of electronic products')
  


#Building the additional chart
#I will make a bar chart showing the number of vehicles using each of five fuel types in Canada
summary <- emissions %>% group_by(Fuel.Type) %>% summarize(number_rows = n())

#Generating the bar chart
C <- ggplot(summary, aes(Fuel.Type, number_rows)) + geom_bar(fill = 'blue', stat = "identity") + xlab('Fuel Type') + ylab('Count') + ggtitle('R - bar chart: Number of vehicles running each fuel type in Canada')
 
#Displaying the charts
A
B
G
C