###PRETTY PLOTTING!

#critical!  When looking at the plot in r, make sure the plot window
#is large enough to show the plot or you will get an error!

#basic
par(mfrow=c(1,2))#ignore this for now
x <- 1:10
y <- 1:10
z <- rnorm(20)
plot(x,y)
hist(z)
boxplot(z)
pairs(cbind(x,y,z))

#extreme addition of things
plot(x,y)
plot(x,y,
     #labels for x and y axis
     xlab="Quantity of Tandori Chicken", ylab="Incidents of Piracy",
     #range for the x and y axis
     xlim = c(0,10), ylim=c(1,10),
     #whether to even plot an axis or not
     xaxt='n',
     #whether the axis should be on log or linear scale
     log='y',
     #what kind of plot?
     type='b',
     #add a main title
     main = "Role of Chicken \n in Pirate Hostility",
     #add a subtitle
     sub="This is hardcore research",
     #change the line style
     lty=3,
     #change the dot/point style
     pch=1:10,
     #change the width of the lines
     lwd=3,
     #change the size for the dots/points
     cex=3,
     #change font sizes
     cex.main=3, cex.lab=.8, cex.sub=1, cex.axis=2,
     #change pch and line color
     col=c('chocolate', 'seagreen', 'plum'),
     #color most everything else
     col.main='red', col.lab='purple',col.sub='green', col.axis='blue',
     #color the figure outline
     fg='salmon',
     #change the font style (1=plain, 2=bold, 3=itals, 4=bolditals)
     font=2, #axis
     font.lab=3, font.main=2, font.sub=4)

#What about that pesky background color?
#It's time for a new function
dev.off() #I'll explain this in a moment
par(bg='goldenrod')
plot(x,y)

#add multiple plots (2 cols)
par(mfrow=c(1,2))
plot(x,y)
plot(x,y)

#add multiple plots (2 rows)
par(mfrow=c(2,1))
plot(x,y)
plot(x,y)

#add multiple plots (3x3)
par(mfrow=c(3,3))
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)


#you may be thinking this makes no sense to do,
#because the plots are squished.  We can fix this!
par(mfrow=c(2,2), mar=c(5.1, 4.1, 4.1, 2.1))#defaults
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)
#mar stands for margin; the white space around the plot.
#lets remove a bunch of it.
#The four numbers are bottom, left, top, right
par(mar=c(3.5, 3.5, 2, .1))
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)

#much better, right?

#change the spacing on axis
par(mar=c(5.1, 4.1, 4.1, 2.1))
par(mfrow=c(1,1), mgp=c(3,1,0)) #defaults
plot(x,y)

par(mgp=c(0,1,0)) #first number is the label
plot(x,y)

par(mgp=c(3,0,0)) #second number is the tic labels
plot(x,y)

par(bg='goldenrod', mfrow=c(1,1), mgp=c(3,1,3)) #third number is the axis itself
plot(x,y)

#why tweak this?  pls compair:
par(mar=c(3.5, 3.5, 2, .1))
par(bg='goldenrod', mfrow=c(1,2), mgp=c(3,1,0)) #defaults
plot(x,y, main="default")
par(mgp=c(2,.5,0))
plot(x,y, main="squished")


#Next problem: what if you wnat something that does not exist on
#the default plot to be added to the plot? D:>
#use more functions

dev.off() #I'll explain this in a moment
plot(x,y)
legend(x="bottomright", legend="dots")
legend(x="topleft", legend="dots", col="green",
       border="purple", lty=3, lwd=.5,pch=17,
       adj=.5, text.col='purple')
#"bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center". 

plot(x,y, xlim=c(0,10))
abline(2,4, col='red', lty=5, lwd=3)
abline(4,2, col='green', lty=4, lwd=3)
abline(10,-2, col='blue', lty=6, lwd=3)
abline(v=0, col='black')
abline(h=10, col='purple')

#first number is the intercept, second is the slope

plot(x,y)
segments(c(1,3), c(2,4), c(2,4), c(3,5), col=c('purple', 'green'), lwd=4)

#thus you can draw any configuration you need
plot(x,y)
segments(1,1,2,4,col="red", lwd=3)
segments(2,4,3,1, col="orange", lwd=3)
segments(3,1,1,2.75, col='yellow', lwd=3)
segments(1,2.75,3,2.75, col='green', lwd=3)
segments(1,1,3,2.75, col="blue", lwd=3)

#there is also rect() and polygon(); look them up on your own time

#The last thing you might wnat to do is add text to your plot
plot(x,y)
mtext("sweet graph bro", side=1,line=0)
mtext("sweet graph bro2", side=2,line=0)
mtext("sweet graph bro3", side=3,line=0)
mtext("sweet graph bro4", side=4,line=0)


mtext("above sweet graph bro4", side=4,line=1)

#and for text within the plot...
text(3,4, "bodacious graph1", adj=0)
text(3,5, "bodacious graph2", adj=.5)
text(3,6, "bodacious graph3", adj=1)

dev.off()
#last part: how do I save my graph?
pdf("title.pdf") #creates a new .pdf
plot(x,y) #add whatever graphs you want
dev.off() #stop writting to the .pdf

#other functions to look into for extreme formating:
layout()

