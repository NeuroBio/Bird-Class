#Coding 101!!!

###########Rule 1: Know where you are. Know where your files are.
getwd()
dir <- getwd()
print(dir)
setwd("C:/Users/Kara/Documents/R/BirbClass")
getwd()

#Let's load data.
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")



###########Rule 2: CaSe MaTtErS! NOSPACES!
print(TestData) #camelcase is standard
print(testdata)




############Rule 3: Indexing is POWER
#let's play with some data
#indexing data from a table
print(TestData[,]) #all rows and cols
colnames(TestData)

#three ways to pull the same data (col 1)
TestData[,2]
TestData[,"avg_note_duration.ms."]
TestData$avg_note_duration.ms.

#and a forth way
DataIWant <- "avg_note_duration.ms."
TestData[,DataIWant]
DataIWant2 <- 2
TestData[,DataIWant2]
#It may not seem like it now, but it is extremely powerful to know all the methods

#What about rows?  Same thing, new position.
TestData[1,] #all data for row1
# want a specific cell?
TestData[1,2]

#what if you only want a subset of TestData?
SubSet <- TestData[,2]
print(SubSet)




###########Rule 4: Know why Matrixes, Data.Frames, and Vectors are slightly different
#Vector= 1D
#Matrix= 2D
#Data.Frame= 2D

TestData[1,2]
SubSet[1,1] #this will NOT work, wrong dimentions
SubSet[1] #this WILL work

#Why?  Think of vectors as a single col of data.
#You do not need to specify the col, because there is only 1 col

#how do you know whether a variable is a vector or something else?
is.vector(SubSet) #TRUE
is.vector(TestData) #FALSE

#okay, so what is TestData? 
is.matrix(TestData)
is.data.frame(TestData)

#Why isn't TestData a matrix?

#let's back up
#Matricies and Vectors have something in common:
#They can only hold one class of data.
class(SubSet) #numeric
#make a matrix from subset
SubSetMat <- cbind(SubSet,SubSet) #short for "column bind"
print(SubSetMat)
class(SubSetMat) #Matrix
class(SubSetMat[,1]) #numeric
class(SubSetMat[,2]) #numeric

#So SubsetMat is a numeric matrix.  What about TestData?
class(TestData) #data.frame
class(TestData[,1]) #factor <- these are special, I will explain them next time
class(TestData[,2]) #numeric
#See how the columns in TestData are different classes?  Only data.frames can do that.
#Keep this straight or your code may not function as you intend




#############Rule 4: Functions are POWER
#Functions are the things that do things <- This is a useful explanation
#in brief, if it ends in "()" it's a function
#so yes!  We used a few already
getwd()
setwd()
read.table()
print()
is.vector()
is.matrix()
is.data.frame()
class()
cbind()
#however, be careful.  There are a few functions that do not use "()"
#E.G: <- (yes, the arrow is a function!), :, ?, ??
  
#Maybe this is obvious, but there is super secret code running when you use a function.
#let me show you:
lm()  #click your cursor between the "l" and "m" and hit F2 on your keyboard (or Fn+F2)
#See the scary thing?  All of that code is hiding within lm().

#What exactly is a function:
#1-a name to call it
#2-Arguments to pass it (optional)
#3-code that does things (optional)

FirstFunction <- function(){}
is.function(FirstFunction)
FirstFunction()
#First function is a useless function that does nothing
FirstFunction <- function(){
  print("This is a function!")
}
FirstFunction()
#now it does something meaningless
#Right now, our function will always do the same thing
#It needs arguments to make custom ouputs
FirstFunction <- function(x){
  print(x)
}
FirstFunction() #this no longer works
FirstFunction(3)
FirstFunction(20)
FirstFunction("ladidahdidah")
FirstFunction(TestData)

#what if we want Firstfunction to have a default behavior?
FirstFunction <- function(x="crawdad"){
  print(x)
}
FirstFunction()
FirstFunction("lobster")

#Key: Not all arguments are required!!!
FirstFunction <- function(x="crawdad", y){
  print(x)
  if(missing(y)==FALSE){
    print(y)
  }
}

FirstFunction()
FirstFunction("lobster", "lobster2!")

#The default behavior for functions is to take arguments in order
#argument 1 in Firstfunction is x, so it assumes x="lobster"
#however, you can define arguments in any order
FirstFunction(y="lobster2!")




#This has been great and all, but we've done NOTHING with the data.
#Let's remedy that.

#If you can't get a function to work, don't panic!
?lm()#Look in your plot/help box
#there is documentation to help you figure out how to use a function
#When in doubt GOOGLE (Stackexchange/overflow is your friend)



#***********************"HOMEWORK"***************************************************
#########THIS IS YOUR CHEATSHEET:
mean()
which()
length()
plot() #make sure your plot/help box is not tiny or you will get an error!


#Question 1: (easy)
###A) What is the AVERAGE average note duration across all songs?

###B) HOW MANY elements/cells/rows are in the first column in TestData?

###C) WHICH rows in TestData have a number of syllables equal to 39?
#HINT: the documentation is hard to read for this one.  Feel free to Google for examples!

###D) Make a GRAPH where the independant variable is number of syllables
#and the dependant variable is the bout duration.




#Once you get here:  Good job!  You are hopefully getting a bit of a feel
#for how to read the documentation on the functions and to Google for help
#when all else fails.  It's time to start thinking about combining functions.



#Question 2: (medium)
###A) In how many rows was there more than one unique syllable AND what is the
#average value of these rows?
#HINT: Remember the different ways to index.



###B) For rows with more than one unique syllable, what were the average
#note durations?  Yes or no, was any average note duration greater than 40ms?
#Hint: you can use the logic inside which() outside of which()
#to make a TRUE/FALSE query


###C) Recreate the graph you made for 1D EXCEPT:
#i. plot the dots in "red"
#ii. Make the x label "Number of Syllables"
#iii. Make the y label "Bout Durantion"
#iV. Make the title "[your name]'s Awesome Nonsense Graph!!!"
#v. fill the red dots ###Hint(pch and col are arguments for plot)
#vi. add lines (many, many lines #spiderweb)
#HINT: this is going to make a very long line of code.  Those are hard to read.
#you can start a new line in the middle of a function after any ","
#E.G.: plot(x,
#            y)





#When you get here: Hopefully that last excersize was more "Ah-ha!" moments
#and fewer moments spent slamming your skull on your laptop.  Frustration is the
#precursor to learning.  By now, you should start to get a feel for some of
#the power at your fingertips, but if not, hang on.  You'll see it soon.
#One quick question: Did you get FALSE for 2B?  If so, reread the question.
#If you are still confused call me over.  Asking questions is good.



#Moving forward, let's do something harder.
#You'll need a few new functions:
lm() #formula = y~x
rep()
abline()
legend() #optional
c() #optional


#Question 3: (hard)
#I want to see a graph that looks at how average syllable duration changes as the number
#of syllables increases.  Furthermore, I want to be able to tell rows that had one
#unique syllable apart from those with more than one unique syllable.  This can be
#done using color or shape changes or both.  I want to see what the linear regression is
#for all of the data, and the rows that only have one unique syllable.
#Please make the graph easy to read!!!  A legend would be a nice touch.
###Hint: Just do as much as you can with the plot.
#I will go over the problem in the next class!
###Hint: - is also useful in indexing.  Think of it as meaning "exclude";
#SubSetMat[-(2:24),] gives you only the 1st and 25th entry of SubSetMat









#That was fun right!  Well, maybe not, but you did get a pretty graph at the end,
#and that matters above all else.  This will become more intuitive with practice.
#Now that you are here, you want a Bonus question, right?  Yes, you do. :)

#Bonus:
print(TestData$avg_note_duration.ms.[15])
TestData$avg_note_duration.ms.[15] == 29.57212
#Why is this code spitting out FALSE instead of TRUE???
#How would you fix this problem?