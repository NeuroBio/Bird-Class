#Coding 104!
#####
rm(list = objects()) #this kills everything in your environment!!!!!
setwd("C:/Users/Kara/Documents/r/Birbclass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")
MetaData<-read.csv('TestMetaData Feb 19th-Mar19th.csv')

#install.packages("RCurl") #you only ever need to run this once!  It adds a set of functions (a package) to R
library(bitops)#load functions from that package
library(RCurl)#load functions from that package

#The next two lines load some code from my GitHub Repo, so you have access to some tools you need
script <- getURL("https://raw.githubusercontent.com/NeuroBio/BirbClass/master/TestCase%20SetUp.R?token=AITiySgV28NQJ0bp5IZePE_iPT-IGarrks5aezjtwA%3D%3D", ssl.verifypeer = FALSE)
eval(parse(text = script))

#####

#INSTRUCTIONS!
#The point of today is that sharing is caring,
#but sharing badly is almost as bad as not sharing.
#This will not be a "coding lesson" per se as much as a day
#to make useful code for the whole class and learning to do it well.

#There are three projects.  Two people will work separately and
#together on each one.  Each person will write their own code
#in an attempt to find the best solution.  You may talk and
#share ideas.  Your code should be well commented, so another
#member of the class knows what each segment of code does
#####

#Project 1:
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

Cleaner <- function(ParseData, MetaData, YearOnly = FALSE){
#this first segment only deals with  the Parser Data
###reformat the factor data and remove excess cols
  ParseData$FileName <- as.character(ParseData$FileName)
  remove <- which(colnames(ParseData) %in% c("syllable_stereotypy",
                                             "syllable_pattern",
                                             "syll_correlation_threshold",
                                             "note_size_threshold",
                                             "std_syllable_stereotypy",
                                             "sequential_repetition",
                                             "num_unique_syllables",
                                             "mean_syllable_stereotypy"))
  ParseData <- ParseData[-remove]
###remove excess from the FileNames
###I'm pulling the bout data location with the following pattern:
  loc <- regexpr("b[0123456789]{1,}of[0123456789]{1,}", ParseData$FileName)
###the match length attribute tells me how many chara are in the pattern
  stop <- attr(loc, "match.length")+as.vector(loc)
  
  ParseData$Bouts <- vector(mode="numeric", length(stop))
  for(i in seq_along(ParseData$FileName)){
    ParseData$Bouts[i] <- substring(ParseData$FileName[i], loc[i], stop[i]-1)
  }
###Same basic logic to truncate the XC IDs
  loc <- regexpr("_[0123456789]{1,}_", ParseData$FileName)
  stop <- attr(loc, "match.length")+as.vector(loc)
  for(i in seq_along(ParseData$FileName)){
    ParseData$FileName[i] <- substring(ParseData$FileName[i], loc[i]+1, stop[i]-2)
  }
###Fix the column Names
  FileNames <- colnames(ParseData)
  Splitter <- strsplit(FileNames, "_")
###Capitolizes the first letter
  for(i in seq_along(Splitter)){
#####The code takes the first letter of each word, converts it to its uppercase form
#####Then concatinates it to the second letter to the end of the rest of the word
    NewVal <- paste(toupper(substring(Splitter[[i]], 1,1)),
                    substring(Splitter[[i]], 2), sep="", collapse="")
    FileNames[i] <- NewVal
  }
###Removes "."
  FileNames <- gsub("[.]","",FileNames)
  colnames(ParseData) <- FileNames

  
  
  
#This second segment deals with the Meta Data
###split the time/data col into two cols
  TimeDate <- as.character(MetaData$RecordingDateTime)
  TimeDate <- unlist(strsplit(TimeDate, " "))
  Time <- TimeDate[seq(2, length(TimeDate), by=2)]
  Date <- TimeDate[seq(1, length(TimeDate), by=2)]
###allows you to have the full date or just the year
    if(YearOnly == TRUE){
      Date <- unlist(strsplit(Date, "/"))
      Date <- Date[seq(3, length(Date), by=3)]
  }
###Load into the Data.Frame
  MetaData$RecordingDate <- Date
  MetaData$RecordingTime <- Time
###Remove unwanted cols
  remove <- which(colnames(MetaData) %in% c("SongUnavailable",
                                            "SongDownloaded",
                                            "SongURL",
                                            "RecordingDateTime",
                                            "BirdSongID"))
  MetaData <- MetaData[-remove]
###Converts all factors into char
  for(i in seq_along(MetaData)){
    if(class(MetaData[,i]) == "factor"){
      MetaData[,i] <- as.character(MetaData[,i])
    }
  }
###combine the new dataframes in a list:
  AllData <- list(ParseData, MetaData)
  names(AllData) <- c("ParseData", "MetaData")
  return(AllData)
}
FinalRun <- Cleaner(TestData,MetaData)
Cleaner(P1_Ai, P1_Aii)
Cleaner(P1_Bi, P1_Bii)
Cleaner(P1_Ci, P1_Cii)
Cleaner(P1_Di, P1_Dii, YearOnly = TRUE)

#this is an extra case to prove that my different functions work together!

#Project 2:
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

#ANSWERS
#Correct Answer for A, B, D, and F. 
###[1] "Check Chipping Sparrow for indicies: 5 6 7 8 9 10"
###[1] "Check Chipping Sparrow for indicies: 11 12"
###[1] "Check Chipping Sparrow for indicies: 21 22"
###C is missing 11,12 because of where I put the RWBB, and 3 calls RWBB
###E has the order scrambled 2,1,3
DuplicateFlagger <- function(MetaData){
#Reduce the dataset by removing intentional duplicates via checking the XCID
  BoutsFromSameXCID <- which(duplicated(MetaData$XenoCantoCatalogNumber) == TRUE)
  if(length(BoutsFromSameXCID) != 0){
    MetaData <- MetaData[-BoutsFromSameXCID,]
    #Doing this changed the indexing!!!  It no longer matches the input data.
    #We will fix this below using the rownames, which kept the Original number system intact.
  }

#set up the top level variables:
#picking organisms via common name, and convert the date into the year only format if needed
  CommonName <- unique(MetaData$BirdCommonName)
  YearsMod <- MetaData$RecordingDate
#this converts the date into the year only format if it is not in year only format
  if(nchar(YearsMod[1]) > 4){
    Broken <- unlist(strsplit(YearsMod, "/"))
    YearsMod <- Broken[seq(3, length(Broken), by=3)]
  }

#Begin checking: The logic is 1) find all ind for a species.
#2) find all the recordists.  3)for each recordist see if they made more than one record
#3) If so, look where they recorded.  4) If mutiple songs were recorded in the same place,
#see if they were also recorded in the same year.  5) if so, warn the user to check those bouts.
  for(i in seq_along(CommonName)){ #run for each species
###Get the unique recordists for a species
    SpeciesInd <- which(MetaData$BirdCommonName == CommonName[i])
    Recordists <- unique(MetaData$Recordist[SpeciesInd])
    for(j in seq_along(Recordists)){ #run for each recordist for a species
###Get the record indicies for a single recordist
      RecordsInd <- which(MetaData$Recordist[SpeciesInd] == Recordists[j])
      if(length(RecordsInd) > 1){ #because if only 1, then assume no dups
###Get the unique places a recordist recorded
         Places <- unique(MetaData$RecordingLocation[SpeciesInd[RecordsInd]])
        if(length(Places) != length(RecordsInd)){ #because if all records from dif location, no dups
          for(k in seq_along(Places)){
###Get the record indicies for each place
            PlaceInd <- which(MetaData$RecordingLocation[SpeciesInd[RecordsInd]] == Places[k])
            if(length(PlaceInd) > 1){ #because if only 1, then assume no dups
###Get the years wherein a recording happened at a specific place
              Years <- unique(YearsMod[SpeciesInd[RecordsInd[PlaceInd]]])
              if(length(Years) != length(PlaceInd)){ #because if all records from dif year, no dups
                for(l in seq_along(Years)){
                  YearsInd <- which(YearsMod[SpeciesInd[RecordsInd[PlaceInd]]] == Years[l])
                  if(length(YearsInd) > 1){ #because if only 1, then assume no dups
                    print(paste0("Check ", CommonName[i], " for indicies: ",
                                ###note how I used rownames to account for how we changed the size of the data.frame earlier
                                 paste(rownames(MetaData)[SpeciesInd[RecordsInd[PlaceInd[YearsInd]]]], collapse=" ")))
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

DuplicateFlagger(FinalRun$MetaData)
DuplicateFlagger(P2_A$MetaData)
DuplicateFlagger(P2_B$MetaData)
DuplicateFlagger(P2_C$MetaData)
DuplicateFlagger(P2_D$MetaData)
DuplicateFlagger(P2_E$MetaData)
DuplicateFlagger(P2_F$MetaData)


#Project 3:
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

BoutCompiler <- function(Results){
#Set up top level variables:
  CommonName <- unique(Results$MetaData$BirdCommonName) #breaking the data by species, so the code will run faster
  XCIDs <- Results$MetaData$XenoCantoCatalogNumber
  
#Figure out which cols are numeric; character cols cannot be averaged
  Classes <- character(length(Results$ParseData))
  for(i in seq_along(Classes)){
    Classes[i] <- class(Results$ParseData[,i])
  }
  ColInd <- which(Classes == "numeric")

#Make a set of lists to hold data in the loops below
  CombinedData <- as.list(rep(NA, length(CommonName)))
  CutInd <- as.list(rep(NA, length(CommonName)))
  LoadInd <-  as.list(rep(NA, length(CommonName)))
#The next 3 lines are 100% unnecessary, but may help you follow the logic
  names(CombinedData) <- CommonName
  names(CutInd) <- CommonName
  names(LoadInd) <- CommonName

#Fill the three variables from above (The bulk of the code)
  for(i in seq_along(CommonName)){#Find the duplicates for a species
    SpecInd <- which(Results$MetaData$BirdCommonName == CommonName[i])
    DupedInd <- SpecInd[duplicated(XCIDs[SpecInd])]
    SpecDups <- unique(XCIDs[DupedInd])
    if(length(SpecDups) > 0){#if dups exist, extend the data holders to contain every set of dups 
      CombinedData[[i]] <- as.list(rep(NA, length(SpecDups)))
      CutInd[[i]] <- as.list(rep(NA, length(SpecDups)))
      LoadInd[[i]] <- as.list(rep(NA, length(SpecDups)))
      for(j in seq_along(SpecDups)){#for each dup set, get the indicies and then combine them
        CombineInd <- SpecInd[which(XCIDs[SpecInd] == SpecDups[j])]
        CombinedData[[i]][[j]] <- colMeans(Results$ParseData[CombineInd,ColInd])
    ###spliting the indicies into save (where the average data will be loaded) and Cut (rows to remove)
        CutInd[[i]][[j]] <- CombineInd[-1]
        LoadInd[[i]][[j]] <- CombineInd[1]
      }
    }
  }

#Converting the averaged data form list form into a dataframe;
#t() flips the cols and rows so they match the original data
#na.omit is selfexplanatory
  Add <- na.omit(t(as.data.frame(CombinedData)))
  RemoveInd <- na.omit(unlist(CutInd))
  LoadInd <- na.omit(unlist(LoadInd))
  if(length(LoadInd) > 0){
    Results$MetaData <- Results$MetaData[-RemoveInd,]
    Results$ParseData[LoadInd,ColInd] <- Add
    Results$ParseData <- Results$ParseData[-RemoveInd,]
    return(Results)
  }else{warning("No duplicates in dataset; Nothing changed.--CR")}
}

BoutCompiler(FinalRun) #returns a warning I coded in
length(BoutCompiler(P3_A)$MetaData[,1]) #returns a warning I coded in + an error
length(BoutCompiler(P3_B)$MetaData[,1]) #24
length(BoutCompiler(P3_C)$MetaData[,1]) #23
length(BoutCompiler(P3_D)$MetaData[,1]) #23
length(BoutCompiler(P3_E)$MetaData[,1]) #21
length(BoutCompiler(P3_F)$MetaData[,1]) #21
length(BoutCompiler(P3_G)$MetaData[,1]) #21
