#Setting the working directory, importing the libraries and importing the data
setwd('C:/Users/PS3ma/Documents/Bellevue University/DSC 640')
library(readxl)
library(ggplot2)
library(stringr)
library(dplyr)
library(reshape2)

hotdog <- read_excel('hotdog-places.xlsm')
hotdog_winners <- read_excel('hotdog-contest-winners.xlsm')
obama <- read_excel('obama-approval-ratings.xls')

#Replacing one instance of Takeru Kobayashi's name as it uses an extra word in it
hotdog_winners$Winner <- str_replace(hotdog_winners$Winner, 'Takeru "Tsunami" Kobayashi', 'Takeru Kobayashi')

#Ordering the political issues by Obama's approval rating
ordered_obama <- obama[order(obama$Approve), ]
ordered_obama_new <- subset(ordered_obama, select = -c(Issue))





#Constructing the bar chart with ggplot2
#For each champion in the dataset, I will show the number of wins to their name from 1980-2010.
df <- as.data.frame(table(hotdog_winners$Winner))
g <- ggplot(df, aes(reorder(Var1, -Freq), Freq, color = 'blue')) + geom_bar(stat = 'identity', color = 'blue', fill = 'blue') + xlab('Champion name') + ylab('Number of wins') + ggtitle('R - bar chart: Number of hotdog contest wins per champion (1980-2010)') + theme(axis.text.x = element_text(angle = 90))





#Constructing the stacked bar chart
#For each political issue, I will show the approval, disapproval, and non-answer percentages.

#I will use the barplot function to construct the stacked bar chart as it is easier than ggplot2 for stacked bar charts.
b <- barplot(as.matrix(t(ordered_obama_new)), xlab = 'Issue', ylab = 'Rating (%)', main = "R - stacked bar chart: Obama's approval and disapproval ratings for different issues", names = ordered_obama$Issue, col = c('darkgreen', 'orange', 'black'), cex.names = 0.75, las=2)
legend("bottomright", legend = c("Approval", "Disapproval", "None"), fill = c("darkgreen", "orange", "black"))





#Constructing the pie chart
#The pie function will be used as it is easier to use than ggplot2 for pie charts.

#I will show Obama's approval ratings for one issue, the situation in Afghanistan.
#Since pie charts should not use more than 5 variables, I will label the chart with a vector.

#Obtaining the vector of values for the pie chart
ind <- which(obama$Issue == "Situation in Afghanistan")
afghan <- obama[which(obama$Issue == "Situation in Afghanistan"), ]
pielist <- c(afghan$Approve, afghan$Disapprove, afghan$None)

#Making a vector for the labels
labels <- c('Approve', 'Disapprove', 'None')

#Adding percents to the labels
pct <- round(pielist/sum(pielist)*100)
lbls <- paste0(labels, ": ", pct, "%") 

#Building the pie chart
p <- pie(pielist, labels = lbls, main = "R - pie chart: Obama's approval ratings for the situation in Afghanistan", col = c('cyan', 'purple', 'blue'), init.angle = 115.5)





#Constructing the donut chart using the same data as the pie chart
#Donut charts in R need a very special method of construction. 
#I will make a bar chart then circularize the lengths of each bar into angular values and add a center circle to make a donut.

#Building a data frame of the data to make donut chart generation easier
df <- data.frame(rating = labels, percent = pielist)

#Defining the minimum and maximum length of each bar
df$per <- df$percent / sum(df$percent)
df$maxlen <- cumsum(df$per)
df$minlen <- c(0, head(df$maxlen, n = -1))

#Defining the label positions for each label. 
#I want each label to go along the center of each bar, so I will find the midpoint of each bar length
#The average of the minimum and maximum bar lengths will define the midpoint to place each label
#Donut charts also should not use more than 5 variables, so these positions should work for all such charts
df$labelpos <- (df$maxlen + df$minlen) / 2

#Defining the label titles as category name with percent of total pie circumference
df$label <- paste0(df$rating, ": \n", df$percent, "%")

#Building the donut chart
#First, the minimum and maximum length of each bar will be used to define the size of the bars.
#Then, the bars are generated and circularized with coord_polar(), defining the angle as the bar length. Thus, our label position will be used as an angular midpoint.
#Then, the labels are added with the defined names and positions added to geom_label().
#Finally, the middle circle is added to make a donut chart.
d <- ggplot(df, aes(ymax = maxlen, ymin = minlen, xmax = 4, xmin = 3, fill = rating)) + geom_rect() + coord_polar(theta = "y") + geom_label(x = 2.7, aes(y = labelpos, label = label), size = 6) + xlim(c(1, 4)) + theme_void() + theme(legend.position = "none") + ggtitle("R - donut chart: Obama's approval ratings for the situation in Afghanistan") + xlab('') + ylab('')

#Displaying all the charts
g
b
p
d
