#Coding 104!

#RUN THIS CODE FIRST
#####
rm(list = objects()) #this kills everything in your environment!!!!!
setwd("C:/Users/Kara/Documents/r/Birbclass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")
MetaData<-read.csv('TestMetaData Feb 19th-Mar19th.csv')

#install.packages("RCurl") #you only ever need to run this once!  It adds a set of functions (a package) to R
library(bitops)#load functions from that package
library(RCurl)#load functions from that package

#The next two lines load some code from my GitHub Repo, so you have access to some tools you need
script <- getURL("https://raw.githubusercontent.com/NeuroBio/BirbClass/master/TestCase%20SetUp.R?token=AITiydznUNU8gnZ3zP5QwbZub6tV5QSMks5aez1xwA%3D%3D", ssl.verifypeer = FALSE)
eval(parse(text = script))
rm(script)
#####



#INSTRUCTIONS!
#####
#The point of today is that sharing is caring,
#but sharing badly is almost as bad as not sharing.
#This will not be a "coding lesson" per se as much as a day
#to learn how to solve complex problems and to
#make useful code for the whole class.

#There are three projects.  Two people will work separately and
#together on each one.  Each person will write their own code
#in an attempt to find the best solution but you may talk and
#share ideas with yoru partner.  Your code should be well commented,
#so another member of the class would know what each segment of code does

#We will spent part of the class working on the projects, and
#another part testing whatever you got done.  DO NOT PANIC.
#These are complex problems and I don't expect you to to get
#them entirely done.
#####



#HOMEWORK:
#####
#Your homework will be to compare the code you wrote to
#an answer key for the project I will provide after class.
#Explain how my code is diferent and the same as yours
#and include an questions you have about what I did,
#why I did it, and why it works.
#####



#PROJECT 1:
#####
#The Cleaner:  This is a function that will convert the data from
#it's raw form into something useful.  The two data types are
#the ParserData (TestData) and the MetaData (MetaData)

#For ParserData:
#convert Filename from a factor type into a character type
#Remove Syllable_pattern, Syllable_sterotypy,
#syll_correlation_threshold, note_size_threshold,
#std_syllable_stereotypy, sequential_repetition,
#num_unique_syllables, and mean_syllable_stereotypy
#truncate the file names to only be the XC ID number
#Please note, however, that we also need the bxofy data
#That needs to be in a new Col "Bout"
#Set the colnames to stantdard CamelCase (no "." or "_")
#convert all remaining factors in characters
#Leave the "ms" lower case, since those units are lowercase

#For MetaData:
#remove the last three columns and the first col
#split the data and time into two separate columns
#create a mechinism whereby the user can decide if they want
#date to be the full date (month/day/year) or just the year
#load those cols into the data.frame and remove the original col

#combine the two data.frames as a named, 2-element list (AllData) and "return" it
#I completed this in 86 lines, including my comments.
#I did a number of google searches to figure out how to do some of the tasks

#TestCases:
###A original data
###B changed filenames
###C changed filenames
###D scrambled columns
#DO NOT FORGET TO TEST YOUR YEAR MECHNISM!


Cleaner(P1_Ai, P1_Aii)
Cleaner(P1_Bi, P1_Bii)
Cleaner(P1_Ci, P1_Cii)
Cleaner(P1_Di, P1_Dii, YearOnly = TRUE)
#####



#PROJECT 2:
#####
#The DuplicateFlagger: this name is self explanatory.
#There is a problem that we may or may not have, but we should try to check for:
#The data is uploaded by citizen scientists who may forget what they have uploaded
#and upload the same song multiple times.  Alternatively, they may record the same
#bird many times and upload all recordings of that same bird.  We want to work under the
#assumption that all songs were from unique birds.  Find a way to test whether the songs are too
#similar to be considered different birds.  Think about what data would give you a good reason to
#believe that two songs are from the same bird.
#Keep in mind that your data in the long run will include multiple species.
#Make the function test any number of bird species in the data.frame
#Remember that the date comes in two flavors: month/day/year and just year
#Also remember that some sougs are intentionally represented multiple times, because the
#we intentionally took multiple bouts form birds with complex repertoires.
#We do NOT want to flag those!
#I completed this in 57 lines, including my comments.
#I spent a lot of time confusing myself, so comment as you go, or you will get lost.

#TestCases:
###A) Original Data, full year
###B) 4-dig year
###C) Two Species
###D) Different number of rows w/ intentional duplicates
###E) Row Indicies Scrambled
###F) Col Indicies Scrambled

#ANSWERS:
#Correct Answer for A, B, D, and F. 
###[1] "Check Chipping Sparrow for indicies: 5 6 7 8 9 10"
###[1] "Check Chipping Sparrow for indicies: 11 12"
###[1] "Check Chipping Sparrow for indicies: 21 22"
###C is missing 11,12 because of where I put the RWBB, and 3 calls RWBB
###E has the order scrambled 2,1,3


DuplicateFlagger(P2_A$MetaData)
DuplicateFlagger(P2_B$MetaData)
DuplicateFlagger(P2_C$MetaData)
DuplicateFlagger(P2_D$MetaData)
DuplicateFlagger(P2_E$MetaData)
DuplicateFlagger(P2_F$MetaData)
#####



#PROJECT 3:
#####
#BoutCompiler: remember that some of the parsed bouts came from the same song recording.
#we want a function that will find these duplicate bouts and REPLACE them with a SINGLE average
#of the entries.  Return the edited results.
#I completed this in 54 lines, including my comments.
#This is a tricky logic puzzle. I spent WAY more time thinking than I did actually coding.


#TestCases:
###A original data
###B added one duplicate
###C added two duplicates
###D added two duplicates and a second species
###E added two duplicates across the two species
###F same as E with scrambled cols
###G everything duplicated


length(BoutCompiler(P3_A)$MetaData[,1]) #returns an Error and/or a warning and/or 25 depending on how you coded
length(BoutCompiler(P3_B)$MetaData[,1]) #24
length(BoutCompiler(P3_C)$MetaData[,1]) #23
length(BoutCompiler(P3_D)$MetaData[,1]) #23
length(BoutCompiler(P3_E)$MetaData[,1]) #21
length(BoutCompiler(P3_F)$MetaData[,1]) #21
length(BoutCompiler(P3_G)$MetaData[,1]) #21
