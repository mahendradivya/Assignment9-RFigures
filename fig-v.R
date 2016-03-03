#Divya Mahendra - Code for Figure V
library(lattice)
library(ggplot2)
library(latticeExtra)
library(gridExtra)

#Diamonds DataSet
data(diamonds)

#Exercise 1
#Subset one - diamonds that only of 'ideal quality'
#Subset two - contains rest excluding color J - meaning everything except ideal quality and color J
diamonds.ideal <- subset(diamonds, cut=="Ideal")
diamonds.exJ <- subset(diamonds, cut!="Ideal" & color!="J")


#Excercise 2
#aggregate the first dataframe from exercise I as mean carat per clarity and second one as median carat per clarity
mean_clarity <- aggregate(diamonds.ideal$carat, by=list(diamonds.ideal$clarity), FUN=mean)
median_clarity <- aggregate(diamonds.ideal$carat, by=list(diamonds.ideal$clarity), FUN=median)
names(mean_clarity) <- c("clarity", "carat")
names(median_clarity) <- c("clarity", "carat")

#Excercise 3 - Sort the data frame according to carat
mean_clarity_sort <- mean_clarity[order(mean_clarity$carat),]

#Exercise 4 - Merge the two data frames from exercise II
clarity.mean.median <- merge(mean_clarity, median_clarity, by.x="clarity", by.y="clarity")
names(clarity.mean.median) <- c("Clarity", "Mean Carat", "Median Carat")

#Exercise 5 - create scatterplot of mean(y) vs. median(x) carat using merged data from exercise IV with standard confidence intervals
x=median_clarity$carat
y=mean_clarity$carat

pdf("fig_v.pdf", height = 7, width = 7) #name of the pdf file for output
#lattice plot
scatter.carat.lattice <- xyplot(y ~ x, 
                                data=clarity.mean.median,
                                panel = function(x, y, ...){
                                  panel.xyplot(x, y, ...)
                                  panel.smoother(x, y,
                                                 col = "blue",
                                                 col.se = "black",
                                                 alpha.se = 0.3
                                  )
                                })

#ggplot2 plot
scatter.carat.ggplot <- ggplot(clarity.mean.median, aes(x, y) ) + geom_point() + stat_smooth()

scatter.carat.lattice
scatter.carat.ggplot 
invisible(dev.off())
