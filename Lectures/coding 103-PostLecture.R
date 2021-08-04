#Coding 103!
setwd("C:/Users/Kara/Documents/r/Birbclass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")
MetaData<-read.csv('TestMetaData.csv')
#Factors are excellent for categorical data.
BirdColor <- rep("Blue", 46)
BirdColor[c(2,7, 10:20, 35, 37)] <- "Red"
print(BirdColor)
BirdColor <- as.factor(BirdColor)
BirdColor
#organizing the data like this allows for extra power
BirdColor[1]
levels(BirdColor)[1]
BirdColor[1] <- "Yellow" #cannot add
BirdColor <- factor(BirdColor, levels = c(levels(BirdColor), "Yellow"))
BirdColor[1] <- "Yellow" #Can add
BirdColor
levels(BirdColor) <- c("Blue Jays","Robins","Finches")
BirdColor
table(BirdColor)
levels(BirdColor)[1] <- "Blue Birds"
BirdColor


#Lists are the most flexible data type in R
#Remember the old data types
VectorType <- 1:10
VectorType
MatrixType <- cbind(1:10, 1:10)
MatrixType
DataFrameType <- data.frame(1:10, letters[1:10])
DataFrameType
listtype <- list(VectorType, MatrixType, DataFrameType)
names(listtype) <- c("VectorType", "MatrixType", "DataFrameType")
listtype
listtype <- c(listtype, list(c("lol have some random text", "and some more")))
listtype
#lists can hold everything
#the tricky part is making your list the way you intend to.
list1 <- list(1:10)
list1
list2 <- as.list(1:10)
list2
list3 <- list(1:10, letters[1:10])
list3
list4 <- list(c(1:10, letters[1:10]))
list4
list5 <- as.list(1:10, letters[1:10])
list5 #did not work
list6 <- as.list(c(1:10, letters[1:10]))
list6 #works

#pulling data from a list is slightly different too
listtype$VectorType
listtype[[1]]
listtype[1] #this version is different!!!!
class(listtype[[1]])
class(listtype[1])
listtype[1]*2 #does not work
listtype[[1]]*2 #does work


#Regular Expressions
#Rule 9: Text is flexible
Express <- as.character(MetaData$RecordingDateTime)
Express
#which rows have a given "pattern"
grep("8", Express) #indicies
grepl("8", Express) #Boolean

#Splitting text data
Express2 <- strsplit(Express, " ")
Express2
time <- unlist(Express2)[seq(2,50,by=2)]
time

#changing one set of text for another
sub("00:00", "NULL", time) #first instance only!!!!
sub("0", "lul", time)
gsub("0", "lul", time)

#Special characters
#metacharacters: $ * + . ? [ ] ^ { } | ( ) \

#\ is the escape character.  Use it before all of the following
#'  #single quote
#"  #double quotes
#n  #newline
#t  #tab
#r  #carriage return

#Quantifiers
#*    #matches 0 times or more (everything)
#+    #matches at least 1 time (1 to infinity)
#?    #matches at most 1 time (0 or 1)
#{n}  #matches exactly n times (n)
#{n,}  #matches at least n times (n to infinity)
#{n,m}  #matches between n and m times (n to m)

#Positionals
#^   Match the start of a string
#$   Match the end of a string
#^ $ Matches the edges of STRINGS
#\b  Matches the edges of WORDS
#\B  Matches non-edges of WORDS
# the last two need an extra \


print("This is a starter sentence.")
paste("This is a starter sentence.")
cat("This is a starter sentence.")
writeLines("This is a starter sentence.")

print("This is a", "starter sentence.") #broken
paste("This is a", "starter sentence.")
cat("This is a", "starter sentence.")
writeLines("This is a", "starter sentence.") #broken

print(c("This is a", "starter sentence."))#two elements
paste(c("This is a", "starter sentence."))#two elements
cat(c("This is a", "starter sentence."))#as intended
writeLines(c("This is a", "starter sentence."))#two lines

sent <- print("This is a starter sentence.")
sent
sent <- paste("This is a starter sentence.")
sent
sent <- cat("This is a starter sentence.")
sent
sent <- writeLines("This is a starter sentence.")
sent

print("This is a starter \n sentence.")
paste("This is a starter \n sentence.")
cat("This is a starter \n sentence.")
writeLines("This is a starter \n sentence.")

store <- paste("extra text", text, "ender")
store2 <- unlist(strsplit(store, " "))

grep("text", store2, value = TRUE)
grep("*", store2, value = TRUE)
grep("e*", store2, value = TRUE)
grep("*e", store2, value = TRUE)
grep("$e", store2, value = TRUE)
grep("^e", store2, value = TRUE)

grep("n", store2, value = TRUE)
grep("\n", store2, value = TRUE)
grep("\\n", store2, value = TRUE)
grep("\\\n", store2, value = TRUE)
grep("\\\\n", store2, value = TRUE)

grep("t{1}", store2, value = TRUE)
grep("t{1,}", store2, value = TRUE)
grep("t{2}", store2, value = TRUE)

#Questions:

#Question 1:
###a) Create a list that contains the following as elements:
#i) a factor of recordingType from MetaData. (defaults as a factor)
#ii) a matrix of the species and genus from MetaData.
#iii) a vector of the average syllable duration from TestData.
#iV) a character string of every other letter in the alphebet in UPPERCASE


###b) Rename the list elements as Record, Bird, SylDur, and Nonsense

###c) How many levels are there in Record

###d) Convert Record into a character vector and use gsub to convert all "Song" entries into "song"


###e) Pull the Bird and SylDur data for any records labeled as atypical.
#Unlist the data.  What is the class and what do the numbers under BirdSpecies and Birdgenus mean?



#The Class is numeric, and the numbers are related to the fact that
#birdgenus and birdspecies were originally factors

#Question 2:
###a) Create a factor called TestFactor that is 40 elements long.  There are  2 levels:
#A and B the first 20 elements are A and the remainder are B. 

###b) Using TestFactor from 1d, create NewFactor that includes 3 more levels:
#C, D, and E.  Add two more elements: D, E, and change element 14 to D.
#How many elements fit into each group?
#####HINT: A variable has to exist to index it, but you can call non-existent
#indicies for a variabe to assign them




###c)The syllable_pattern column in TestData is a factor.  It should not be.
#This data needs to be converted into a list of 25 vectors we will call FacToList.
#####HINT: #You can test if you have done the right thing using the following:
class(FacToList) #list
class(FacToList[[1]]) #numeric










#BONUS:
#Is there a significant difference in the frequency between Chipping Sparrows in
#the US and those in Canada and Mexico?  Visualize the data as you see fit.
#HINT: YOU CAN DO IT!
#HINT: Extra bonus if you figure out what is fishy about the MetaData I gave you


