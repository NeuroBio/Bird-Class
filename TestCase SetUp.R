#WARNING: You if you are in my class, you should NOT be here.
#The code below will bias you in your projects and you are not
#allowed to look at it.  If I catch you looking, I will end you. :)
#Behave pls.

#Make sure the kids did the thing they need to do. :/
if(exists("TestData") == FALSE | exists("MetaData") == FALSE){
  stop("You need load in TestData and Metadata from your main script first!--CR")
}


#Test Cases for Project 1
#Original Data
P1_Ai <- TestData
P1_Aii <- MetaData
#Program renamed
P1_Bi <- P1_Ai
P1_Bii <- P1_Aii
P1_Bi$FileName <- gsub("SegSyllsOutput", "Chipper_Alpha", P1_Bi$FileName)
#Program renamed again
P1_Ci <- P1_Ai
P1_Cii <- P1_Aii
P1_Ci$FileName <- gsub("SegSyllsOutput", "Lol, if this is still an issue, than you are treating a symptom and not the problem. <3", P1_Ci$FileName)
#Scrambled cols
P1_Di <- P1_Ai
P1_Dii <- P1_Aii
set.seed(49)
ScrambleInd <- sample(1:45, 45)
P1_Di <- P1_Di[,ScrambleInd]
ScrambleInd <- sample(1:15, 15)
P1_Dii <- P1_Dii[,ScrambleInd]

#Test Cases for Project 2
Initializer <- function(ParseData, MetaData, YearOnly = FALSE){
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
#original data, full year
P2_A <- Initializer(TestData,MetaData)
#original data, 4-dig year
P2_B <- Initializer(TestData,MetaData, YearOnly = TRUE)
#Renamed some birds as RWBB
P2_C <- P2_A
P2_C$MetaData$BirdCommonName[12:25] <- "Red-winged Black Bird"
P2_C$MetaData$BirdGenus[12:25] <- "Agelaius"
P2_C$MetaData$BirdSpecies[12:25] <- "phoeniceus"
#original data included intional, bout duplicates
P2_D <- P2_A
P2_D$MetaData <- rbind.data.frame(P2_D$MetaData,P2_D$MetaData)
#original data, row order scrambled
P2_E <- P2_A
set.seed(49)
ScrambleInd <- sample(1:25, 25)
P2_E$MetaData <- P2_E$MetaData[ScrambleInd,]

#original data, col order scrambled
P2_F <- P2_A
set.seed(49)
ScrambleInd <- sample(1:12, 12)
P2_E$MetaData <- P2_E$MetaData[,ScrambleInd]





#Test Cases for Project 3
#original Data
P3_A <- P2_A
#added one dup
P3_B <- P2_A
P3_B$MetaData$XenoCantoCatalogNumber[5] <- 6244
#added two dups
P3_C <- P3_B 
P3_C$MetaData$XenoCantoCatalogNumber[6] <- 12579
#two dups, two spec
P3_D <- P3_C
P3_D$MetaData$BirdCommonName[13:15] <- "Red-winged Black Bird"
P3_D$MetaData$BirdGenus[13:15] <- "Agelaius"
P3_D$MetaData$BirdSpecies[13:15] <- "phoeniceus"
#three dups across two species
P3_E <- P3_D
P3_E$MetaData$XenoCantoCatalogNumber[c(13:15)] <- 707
#test for scrambled cols
P3_F <- P3_E
set.seed(49)
ScrambleInd <- sample(1:38, 38)
P3_F$ParseData <- P2_E$ParseData[,ScrambleInd]
#test with extra rows
P3_G <- P3_E
P3_G$ParseData <- rbind.data.frame(P3_G$ParseData,P3_G$ParseData) 
P3_G$MetaData <- rbind.data.frame(P3_G$MetaData,P3_G$MetaData) 




#kill the excess to hide it form clever peeps
rm("Initializer")
rm(MetaData)
rm(TestData)

warning("I removed the original TestData and MetaData files!\r
        Use the test cases for your project in order. \r\n
        For P1: the 'i' files are TestData/ParseData. \r
        For P1: the 'ii' files are MetaData. --CR")
