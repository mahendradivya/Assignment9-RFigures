#Divya Mahendra - Code for Figure 6
library(lattice)
library(ggplot2)
library(latticeExtra)
library(gridExtra)

#Exercise 6
diamonds.exJ <- subset(diamonds, cut!="Ideal" & color!="J")

pdf("fig_vi.pdf")
hist.lattice <- histogram(~price|cut + color, data=diamonds.exJ)
hist.ggplot <- ggplot(diamonds.exJ, aes(price)) + geom_histogram(aes(y=..ncount..)) + facet_grid(cut ~ color)
hist.lattice
hist.ggplot
invisible(dev.off())