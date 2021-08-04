#Assessment 2: Robinson - Birds v. Humans: Light and Noise

#YES, YOU MAY USE MY CODE!!!!!!

rm(list = objects())
setwd("C:/Users/Kara/Documents/R/BirbClass")

#Getting started:
#You may have to rename these files
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8", stringsAsFactors = FALSE)
MetaData<-read.csv('TestMetaData Feb 19th-Mar19th.csv', stringsAsFactors = FALSE)


#Housekeeping:
set.seed(12)#makes random things not random
DummyData <- rnorm(25,mean=.5,sd=.2)# creates the vector
MetaData["Brightness"] <- DummyData
print(names(MetaData))
MetaData[1:10,"BirdCommonName"] <- "Grasshopper Sparrow"

#Rural Urban Divide-Frequency:
Divide <- .5

#you did NOT need to make a function.  I hate typing the same code multiple times though,
#so I tend to make a ton of functions.  To run just the code in the function,
#uncomment the next three lines:
# <- MetaData
#CommonName <- "Chipping Sparrow"
#TestParameter <- TestData$max_sylls_freq.Hz.

UrbanRuralTTest <- function(X, CommonName, Divide, TestParameter){
  #get birds of a given species and test whether urban or rural
  RuralIndex <- which(X$BirdCommonName == CommonName & X$Brightness <= Divide)
  UrbanIndex <- which(X$BirdCommonName == CommonName & X$Brightness >= Divide)
  #output for your own knowledge
  print(paste("Urban indices for", CommonName, "are:", paste(UrbanIndex, collapse=" "), sep=" "))
  #Run T.test
  Results <- t.test(TestParameter[RuralIndex],TestParameter[UrbanIndex])
  #allows me to save the results instead of just printing them to the console if I want
  #the return function only works within function space
  return(Results)  
}
SyllableMaxFrequency <- TestData$max_sylls_freq.Hz
test1 <- UrbanRuralTTest(MetaData, "Chipping Sparrow", Divide, SyllableMaxFrequency)
test2 <- UrbanRuralTTest(MetaData,"Grasshopper Sparrow", Divide, SyllableMaxFrequency)
print(test1)
print(test2)


#Rural Urban Divide-Timing:

#uncomment the following line to run the code within the function
#X <- MetaData$RecordingDateTime
FixTime <- function(X){
  #this did not need to be a function, but agan, I like functions.
  #split the datetime into separate date and time elements
  X <- unlist(strsplit(X, " "))
  #I know that every second element is time, so use seq to grab them
  X <- X[seq(2,length(X),by=2)]
  #next step, get the hour:min format into just hours
  X <- unlist(strsplit(X,":"))
  #same logic as above, only I want both the hours and the minutes
  #I also need the data to stop being a character type, so I'm converting
  #it to numeric
  Hour <- as.numeric(X[seq(1,length(X),by=2)])
  Min <- as.numeric(X[seq(2,length(X),by=2)])
  #convert teh minutes to fraction hours and add to hours
  Min <- Min/60
  X <- Hour+Min
  return(X)
  #other methods:
  ###Convert the hours into minutes
  ###don't do the second strplit; instead use sub to change the ":" to "." (technically a number that way if a weird one, and prolly not the best route)
}
Time <- FixTime(MetaData$RecordingDateTime)  
#note how this is the same code as above; I'll use it again below.  Hense why I make functions
test3 <- UrbanRuralTTest(MetaData, "Chipping Sparrow", Divide, Time)
test4 <- UrbanRuralTTest(MetaData,"Grasshopper Sparrow", Divide, Time)

print(test3)
print(test4)

#Correct for Multiple Testing:
#I chose to correct for two tests, because I used the data for chipping sparrows to test two hypotheses
#(about frequency and singing time).  I did the same with the grasshopper sparrow data.
#note that test1-4 are the results from the ttests stored as a List
#we didn't get too much into lists, but if you type a list's name and then "$" it will
#tell you what the elements in the list are
BonAlpha <- .05/2
test1$p.value < BonAlpha
test2$p.value < BonAlpha
test3$p.value < BonAlpha
test4$p.value < BonAlpha


#Plotting
#yes, another function. :)
#X <- MetaData
BirdPlotting <- function(X, CommonName, Divide, TestParameter){
  #get birds of a given species
  SpeciesIndex <- which(X$BirdCommonName == CommonName)
  #make plot, notice how I made the axis change via the input
  #variables instead of having to manually input it!
  plot(X$Brightness[SpeciesIndex],TestParameter[SpeciesIndex],
       #don't worry abotu what exactly substitue() does.
       #in brief, it's converting the variable name into a string
       #you'll see what that results in when you run the code
         xlab = "Brightness", ylab=substitute(TestParameter),
         main=CommonName)
  abline(v=Divide, lty=3, lwd=2)
}

par(mfrow=c(2,2))

#remember that I assigned Time and SyllableMaxFrequency above!
BirdPlotting(MetaData, "Chipping Sparrow", Divide, SyllableMaxFrequency)
BirdPlotting(MetaData, "Chipping Sparrow", Divide, Time)
BirdPlotting(MetaData, "Grasshopper Sparrow", Divide, SyllableMaxFrequency)
BirdPlotting(MetaData, "Grasshopper Sparrow", Divide, Time)
