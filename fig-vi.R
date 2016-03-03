#Divya Mahendra - Code for Figure 6
library(lattice)
library(ggplot2)
library(latticeExtra)
library(gridExtra)

#Exercise 6
diamonds.exJ <- subset(diamonds, cut!="Ideal" & color!="J")

pdf("fig_vi.pdf", height = 7, width = 7)

#price is conditioned(dependent) on cut and color
hist.lattice <- histogram(~price|cut + color, data=diamonds.exJ)
hist.ggplot <- ggplot(diamonds.exJ, aes(price)) + geom_histogram(aes(y=..ncount..)) + facet_grid(cut ~ color)
l.hist.lattice <- useOuterStrips(hist.lattice) # put the labels for lattice plot on the outside
grid.arrange(hist.ggplot, l.hist.lattice, ncol=2) #arrange both plots side by side on same pdf

invisible(dev.off())