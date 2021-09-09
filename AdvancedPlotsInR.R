#P3C11
#1. scatter plot
#scatter pots describe the relationship between two continuous variables

attach(mtcars)
plot(wt, mpg, 
     main="Basic Scatter plot of MPG vs. Weight",
     xlab="Car Weight (lbs/1000)",
     ylab="Miles Per Gallon ", pch=19)
abline(lm(mpg~wt), col="red", lwd=2, lty=1)
lines(lowess(wt, mpg), col="blue", lwd=2, lty=2)
#as car weight increases, miles per galon decreases
#lowess() function is used to add a smoothed line, this smoothed line is a nonparametric fit line based on locally weighted polynomial regression

#2. producing lowess fits: lowess() and loess()
loess() #is newer
lowess() #formula-based version of lowess() is more powerful

#3. scatterplot() in the car paclahe offers many enhanced features and convenience functions for producing scatter plots
#including fit lines, marginal box plots, confidence ellipses, plotting by subgroups, and interactive point identification

scatterplot()

install.packages("car")
library(car)
library(mtcars)
attach(mtcars)
scatterplot(mpg ~ wt|cyl, data=mtcars, lwd=2, span=.75,
            main="Scatter Plot of MPG vs. Weight by # Cylinders",
            xlab="Weight of Car(lbs/1000)",
            ylab="Miles Per Gallon",
            legend.plot=T,
            id.method="identify",
            boxplots="xy"
)

#mpg ~ wt|cyl indicates conditioning(separate plots between mpg and wt for each level of cyl)

#span parameter controls the amount of smoothing in the loess line
#legend.plot option adds a legend to the upper-left margin and marginal box plots for mpg and weight are requested with boxplots option
#scatterplot() function has many features worth incestigating, including robust options and data concentration ellipses 

help(scatterplot)

#scatter plots matrices: bivariate relationship among all the variables

pairs(~mpg+disp+drat+wt, data=mtcars,
      main="Basic Scatter Plot Matrix" ,upper.panel=NULL) 
#produce a scatter plot matrix for the variables mpg, disp, drat and wt
#note that the six scatter plots below the principal diagonal are the same as those above the diagonal
#upper.panel =NULL would produce a graph with just the lower traingle of plots

#scatterplotMatrix() function in the car package can produce scatter plot matrices and can optionally do 
#a. condition the scatter plot matrix on a factor
#include linear and loess fit lines
#place box plots, densities or histograms in the principal diagonal
#add rug plots in the margins of the cells

library(car)
scatterplotMatrix(~mpg+disp+drat+wt, data=mtcars,
                  spread=F, smoother.args=list(lty=2),
                  main="Scatter Plot Matrix via car Package")
#loess fit lines and kernal density and rug plots are added to the principal diagonal
#spread=F option suppresses lines showing spread and asymmetry
#smoother.args=list(lty=2)displays the loess fit lines using dashed rather than solid lines

#4. other plots to scatter plotting
#cpars() in the glus package
#pairs2() in the TeachingDemos package
#xysplom() in the HH package
#kepairs() in the ResourceSelection package
#pairs.mod() in the SMPracticals  package

#5. high-density scatter plots
#when there is significant overlap among data points, scatter plots become less useful for observing relationships

set.seed(1234)
n <-10000
c1 <-matrix(rnorm(n, mean=0, sd=.5), ncol=2)
c2 <-matrix(rnorm(n, mean=3, sd=2), ncol=2)
mydata <-rbind(c1,c2)
mydata <-as.data.frame(mydata)
names(mydata)<-c("x","y")
with(mydata, plot(x,y, pch=19, main='Scatter Plot with 10,000 Observations'))
#it makes difficult to discern the relationship between x and y
#several graphical approaches that can be used to discern relationship includes the use of binning, color, and transparency to indicate the number of overprinted data points at any point on the graph

#smoothScatter() function uses a kernel-density estimate to produce smoothed color density representations of the scatter plot
with(mydata, smoothScatter(x,y, main="Scatter Plot Colored by Smoothed Densities"))


#6. hexbin() function in the hexbin package provides bivariate binning into hexagonal cells
install.packages("hexbin")
library(hexbin)
with(mydata, {
  bin <-hexbin(x,y, xbins=50)
  plot(bin, main="Hexagonbal Bining with 10,000 Observations")
})
#its useful to note that the smoothScatter() function n the base package, along with the ipairs() function in the IDPmisc pakcgae
#can be used to create readable scatter plot matrices for large datasets as well

#7. 3D scatter plots 
#relationship between autombile, mileage, weight and displacement
#use the scatterplot3d() function in the scatterplot3d package
install.packages("scatterplot3d")
library(scatterplot3d)
attach(mtcars)


scatterplot3d(wt, disp, mpg, main="Basic 3D Scatter Plot")

#produce a sD scatter plot with highlighting to enhace the impression of depth and vertical lines connecting points to the horizontal plane
scatterplot3d(wt, disp, mpg, pch=16, highlight.3d=T,
              type="h",
              main="3D Scatter Plot with Vertical Lines")


#add a rgression plane in previous graph
s3d <-scatterplot3d(wt, disp, mpg, 
                    pch=16, highlight.3d  =T,
                    type="h",
                    main="3D Scatter Plot with Vertical Lines and Regression Plane")
fit <-lm(mpg ~wt+disp)
s3d$plane3d(fit)
#shows the prediction of miles per gallon from automobile weight and displacement using a multiple regression equation
#the plane represents the predicted value and the points are actual values
#the vertical distances from the plane to the points are the residuals
#points that lie above the plane are underpredicted whereas points that lie below the line are overpredicted

#8. spinning 3D scatter plots
#the spinning 3D scatter plots can be interacted

#plot3d() function in the rgl package
plot3d(x,y,z)#x,y and z are numeric vectors representing points, we can add options lilke col and size to control the color and size of the points
library(rgl)
attach(mtcars)
plot3d(wt, disp, mpg, col="red",size=5)
#we can use the mouse to rotate the axes

#similar function scatter3() in the car package
library(car)
with(mtcars, scatter3d(wt, disp, mpg))
#the scatter3d() function can include a variety of regression surfaces, such as linear, quadratic, smooth and addictive3
#the linear surface depicted is the default

help(scatter3d)#check other options

#9. Bubble plots
#create a 2D scatter pot and use the size of the plotted point to represent the value of the third variable

symbols(x,y, circle=radius)#this function can be used to draw circles, squares, stars, thermometers and box plots at a specified set of (x,y) coordinates
#where x,y, and radius are vectors specifying the x and y coordinates and circle radii, respectively

#if wanting the areas rather than the radii,of the circles to be proportional to the values of a third variable
#given the formula for the radius of a circle(r=sqrt(A/pi))
symbols(x,y,circle=sqrt(z/pi))#where z is the third variable to be plotted

attach(mtcars)
r<-sqrt(disp/pi)
symbols(wt, mpg, circle=r, inches=.30,
        fg="white",bg="lightblue",
        main="Bubble Plot with point size proportional to displacement",
        ylab="Miles Per Gallon",
        xlab="Weight of Car(lbs/1000)")
text(wt, mpg, rownames(mtcars),cex=.6)
detach(mtcars)

#the option inches is a scaling factor that can be used to control the size of the circles(default is to make the largest circle 1 inch)
#bubble plots sometime using to replace the pie charts


#10. line charts

opar<-par(no.readonly=T)
par(mfrow=c(1,2))
t1 <-subset(Orange, Tree==1)
plot(t1$age, t1$circumference,
     xlab="Age(days)",
     ylab="Circumference(mm)",
     main="Orange Tree 1 Growth")
plot(t1$age, t1$circumference, 
     xlab="Age(days)",
     ylab="Circumference(mm)",
     main="Orange Tree 1 Growth",
     type="b")
par(opar)
#the main difference between the two plots is produced by the option type="b"

#in general, line charts are created with one of the following two functions
plot(x,y,type=)
lines(x,y,type=)
#where x and y are numeric vectors of (x,y) points to connect
#option type= can take from the values:
#p: Points only
#l: Lines only
#o: Over-plotted points(that is, lines overlaid on top of points)
#b,c: pints(empty if c) joined by lines
#s,S: Stair steps
#h: histogram-line vertical lines
#n: doesn't produce any points or lines

#there is an important difference between the plot() and lines()
#pot() creates a new graph when invoked and lines() function adds information to an existing graph but cant produce a graph on its own

#lines() is typically used after a plot() has produced a graph
#you can use the type="n" option in the plot() function to set up the axes, titles and other graph features and then use the lines() function to add various lines to the plot


Orange$Tree <-as.numeric(Orange$Tree)
ntrees <-max(Orange$Tree)

xrange <-range(Orange$age)
yrange<-range(Orange$circumference)

plot(xrange, yrange,
     type="n",
     xlab="Age (days)",
     ylab="Circumference (mm)"
     )
colors <-rainbow(ntrees)
linetype <-c(1:ntrees)
plotchar <-seq(18, 18+ntrees, 1)

for(i in 1:ntrees){
  tree <- subset(Orange, Tree==i)
  lines(tree$age, tree$circumference,
        type="b",
        lwd=2,
        lty=linetype[i],
        col=colors[i],
        pch=plotchar[i])
}
title("Tree Growth", "example of line plot")
legend(xrange[1], yrange[2],
       1:ntrees,
       cex=.8,
       col=colors,
       pch=plotchar,
       lty=linetype,
      title="Tree"
      )

#11. corrgrams
#correlation matrices  in corrrgram package
options(digits=2)
cor(mtcars)

install.packages("corrgram")
library(corrgram)
corrgram(mtcars, order=T, lower.panel=panel.shade,
         upper.panel=panel.pie,
         text.panel=panel.txt,
         main="Corrgram of mtcars intercorrelations")
#start with the lower triangle of cells(the cells below the principal diagonal)
#by defualt, a blue color and hashing that goes from lower left to upper right represent a positive correlation between the two variables 
#the red color and hashing that goes from upper left to lower right represent a negative correlation
#the darker and more saturated the color, the greater the magnitude of the correlation

#in the current graph the rows and columns have been reordered using principal components analysis to cluster variables together that have similar correlation patterns


#the upper triangle of cells displays that color plays the same role but the strength of the correlation is dispayed by the size of the filled pie slice
#positive correlations fill the pie starting at 12 o'clock and moving in a clockwise direction
##nagative correlations fill the pie by moving in a counterclockwise direction

corrgram(x, order=, panel=, text.panel=, diag.panel=)#where x is a data frame with one observation per row
#when order=T the variables are reorderd using a principal component analysis of the correlation matrix
#reordering can help make patterns of bivariate relationships more obvious

#the option panel specifies the type of off-diagonal panels to use
#we can use lower.panel and upper.panel to choose different options below and above the main diagonal
#text.panel and diag.panel options refer to the main diagonal 

#off diagonal:
#panel.pie: the filled portion of the pie indicates the magnitude of the correlation
#panel.shade: the depth of the shading indicates the magnitude of the correlation
#panel.ellipse: plots a confidence ellipse and smoothed line
#panel.pts: plots a scatter plot
#panel.conf: prints correlations and their confidence intervals



#Main diagonal
#panel.txt: prints the variable name
#panel.minmax: prints the minimum and maximum value and variable name
#panel.density: prints the kernel density plot and vairable name

library(corrgram)
corrgram(mtcars, order=T, lower.panel=panel.ellipse,
         upper.panel=panel.pts,
         text.panel=panel.txt,
         diag.panel=panel.minmax,
         main="Corrgram of mtcars data using scatter plots and ellipses")




library(corrgram)
corrgram(mtcars, lower.panel=panel.shade,
         upper.panel=NULL, text.panel=panel.txt,
         main="Car Mileage Data(unsorted)")
#here we are using shading in the lower triangle, keeping the original variable order and leaving the upper triangle blan

#controling the colors used y the corrgram() we can specify the colors in the colorRampPalette() function and include the results using the col.regions option


cols <- colorRampPalette(c("darkgoldenrod4","burlywood1",
                          "darkkhaki","darkgreen"))
corrgram(mtcars, oder=T, col.regions = cols,
         lower.panel=panel.shade,
         upper.panel=panel.conf, text.panel=panel.txt,
         main="A Corrgram (or Horse) of a Different Color")

#Michael Friendly's article "Corrgrams: Exploratory Displays for Correlation Matrices" at www.math.yorku.ca/SCS/Papers/corrgram.pdf


#Mosaic plots: categorical variables
#when we are looking at a single categorical variable, we can use a bar or pie chart
#if there are two categorical vairbales, we can look at a 3D bar chart
#but what we can do when there are more than two categorical variables
#in the mosaic plot, the frequencies in a multidimensional contingency table are represented by nested rectangular regions that are proportional to their cell frequency


mosaic(formula, data=)#from the vcs library use the vcs package 
#where formula is a standard R formula
#option shade=T colors the figure based on Pearson resuduals from a fitted model(independence by default)
#option legend =T displays a legend for these residuals


library(vcd)
ftable(Titanic)
mosaic(Titanic, shade=T, legend=T)

#a person moves form crew to first class, the survival rate increases precipitously
#most children were in the third and second class
#most females in first class suivived whereas only about half the females in third class suivived

#blue shading indicates cross-classifications that occur more often tha nexpected, assuming that survival is unrelated to class, gender and age
#red shading indicates cross-classifications that occur less often than expected under the independence model

example(mosaic)

