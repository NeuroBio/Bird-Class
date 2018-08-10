#Assessment 2: Robinson - Birds v. Humans: Light and Noise

#The following is the first line I will run when testing your code.
rm(list = objects())
#It kills EVERYTHING in the environment. Use this to your
#advantage when making sure that your code works at the end.
#If you don't understand how/why this is useful, ask!
setwd("C:/Users/Kara/Documents/R/BirbClass")


#Getting started:
#1-load Abigail Test data.
#2-load Test Meta data.  This is a CSV file.
#3-for both files, change the stringsAsFactors argument to FALSE!!!

#You can assume that I will already be in the correct working directory
#which contains these files
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8", stringsAsFactors = FALSE)
MetaData<-read.csv('TestMetaData Feb 19th-Mar19th.csv', stringsAsFactors = FALSE)




#Housekeeping:
#The TestMetaData does not currently include the light data, so we will
#need some dummy data.
#1-Add the following vector to the TestMetaData:

set.seed(12)#makes random things not random
DummyData <- rnorm(25,mean=.5,sd=.2)# creates the vector

#2-Name the column holding DummyData "Brightness"
#3-Print the column names, so I can see that it was changed
#Additionally, the metadata you will recieve on Mar 26 will likely
#contain multiple species.  To mimic this eventuality:
#4-reassign the values of rows 1:5 for the BirdCommonName column to be Grasshopper Sparrow
MetaData <- cbind(MetaData, DummyData)
names(MetaData)[length(MetaData)] <- "Brightness"
print(names(MetaData))
MetaData[1:10,"BirdCommonName"] <- "Grasshopper Sparrow"

#Rural Urban Divide-Frequency:
#1-create a variable, Divide, and assign it to be .5
#2-Use some method to designate Chipping Sparrows recorded in an area with
#a Brightness of less than Divide as rural, and those recorded in an area with
#a Brightness of Divide or greater to be urban.
#3-Perform a T-Test to examine whether Chipping sparrows in urban locations
#have significantly higher maximum syllable frequencies than those
#in rural locations.  make sure the T-Test results print to the consol
#so that I can see them!
#4-repeat 2-3 for grasshopper sparrow

Divide <- .5
TTestFreq <- function(CommonName, Divide){
  #get birds of a species, create a vector to hold rural (False) and urban (True)
  CH <- which(TestMetaData$BirdCommonName == CommonName)
  CHRuralUrban <- vector("logical",length(CH))
  CHRuralUrban[which(TestMetaData$Brightness[CH] >= Divide)] <- TRUE
  #Run T.test
  print(TestData$max_sylls_freq.Hz.[CH[CHRuralUrban]])
  return(t.test(TestData$max_sylls_freq.Hz.[CH[CHRuralUrban]],TestData$max_sylls_freq.Hz.[CH[!CHRuralUrban]]))  
}
TTestFreq("Chipping Sparrow", Divide)
TTestFreq("Grasshopper Sparrow", Divide)



#Rural Urban Divide-Timing:
#Using the groups you made above, perform another T-Test that examines whether
#birds in urban areas where recorded significantly earlier in the day. Make
#sure the results of the T-Test print to the consol, so I can see them!
###Hint: Look up 1) strsplit(), 2) unlist(), and 3) sub()

TTestTime <- function(CommonName, Divide){
  #get birds of a species, create a vector to hold rural (False) and urban (True)
  CH <- which(MetaData$BirdCommonName == CommonName)
  CHRuralUrban <- vector("logical",length(CH))
  CHRuralUrban[which(MetaData$Brightness[CH] >= Divide)] <- TRUE
  print(which(MetaData$Brightness[CH] >= Divide))
  #get the time into a usable format
  DateTime <- MetaData$RecordingDateTime
  Date_Time <- unlist(strsplit(DateTime, " "))
  Time <- Date_Time[seq(2,length(Date_Time),by=2)]
  Time <- sub(":",".",Time)
  Time <- as.numeric(Time)
  #Run T.test
  return(t.test(Time[CH[CHRuralUrban]],Time[CH[!CHRuralUrban]]))
}
TTestTime("Chipping Sparrow", Divide)
TTestTime("Grasshopper Sparrow", Divide)

#Correct for Multiple Testing:
#1-Calculate a Bonferroni-correct significnace threshold (alpha)
#2-Test whether any significant results from above are still significant;
#this test should print a TRUE or FALSE to the consol

#I already know what you are thinking: Am I correcting for testing two
#bird species or for testing two variables (time and frequency) in each
#species?  Do I do one correction for 4 tests, or two separate 
#corrections for 2 tests?  Do I really need to correct for anything?
#I found the following article helpful; just read around the jargon and don't
#get discouraged by the first paragraph before you get to the main point:
#http://daniellakens.blogspot.com/2016/02/why-you-dont-need-to-adjust-you-alpha.html

BonAlpha <- .05/2
TTestFreq("Grasshopper Sparrow", Divide)$p.val < BonAlpha


#Plotting
#Make four plots related to the variables we performed T-Tests on above:
#1) Changes in Chipping Sparrow Frequency as Brightness increases.
#2) Changes in Grasshopper Sparrow Frequency as Brightness increases
#3) Changes in Chipping Sparrow singing time as Brightness increases.
#4) Changes in Grasshopper Sparrow singing time as Brightness increases.
par(mfrow=c(2,2))#so I can see all four plots at once
#Each plot should have:
#1) appropriate X and Y lables
#2) a title that states the species being plotted
#3) a vertical line located at x=Divide

BirdPlotting <- function(CommonName, Divide, Var){
  #get birds of a species, create a vector to hold rural (False) and urban (True)
  CH <- which(MetaData$BirdCommonName == CommonName)
  if(Var == "Time"){
    #get the time into a usable format
    DateTime <- MetaData$RecordingDateTime
    Date_Time <- unlist(strsplit(DateTime, " "))
    Time <- Date_Time[seq(2,length(Date_Time),by=2)]
    Time <- sub(":",".",Time)
    Time <- as.numeric(Time)
    plot(MetaData$Brightness[CH],Time[CH],
         xlab = "Brightness", ylab="Time of Day",
         main=CommonName)
    abline(v=Divide)
  }else{
    plot(MetaData$Brightness[CH],TestData$max_sylls_freq.Hz.[CH],
         xlab = "Brightness", ylab="Max Syllable Frequency",
         main=CommonName)
    abline(v=Divide)
  }
}

BirdPlotting("Chipping Sparrow", Divide, "Freq")
BirdPlotting("Chipping Sparrow", Divide, "Time")
BirdPlotting("Grasshopper Sparrow", Divide, "Freq")
BirdPlotting("Grasshopper Sparrow", Divide, "Time")
