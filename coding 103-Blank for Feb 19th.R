#Coding 103!
setwd("C:/Users/Kara/Documents/r/Birbclass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")
MetaData<-read.csv('TestMetaData.csv')
#Factors are excellent for categorical data.


#Lists are the most flexible data type in R
#Remember the old data types

#lists can hold everything
#the tricky part is making your list the way you intend to.

#did not work
#works

#pulling data from a list is slightly different too

#this version is different!!!!

#does not work
#does work


#Regular Expressions
#Rule 9: Text is flexible


#which rows have a given "pattern"
#indicies
#Boolean

#Splitting text data

#changing one set of text for another
 #first instance only!!!!

https://cran.r-project.org/web/packages/stringr/vignettes/regular-expressions.html

#Special characters
#metacharacters: $ * + . ? [ ] ^ { } | ( ) \

#\ is the escape character.  Use it before all of the following:
#'  #single quote
#"  #double quotes
#n  #newline
#t  #tab
#r  #carriage return

#Quantifiers
#*    #matches 0 times (everything)
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



 #broken
#broken


#Questions:

#Question 1:
###a) Create a list that contains the following as elements:
#i) a factor of recordingType from MetaData. (defaults as a factor)
#ii) a matrix of the species and genus from MetaData.
#iii) a vector of the average syllable duration from TestData.
#iV) a character string of every other letter in the alphebet in UPPERCASE


###b) Rename the list elements as Record, Bird, SylDur, and Nonsense

###c) Convert Record into a character vector and use gsub to convert all "Song" entries into "song"


###d) Pull the Bird and SylDur data for any records labeled as atypical.
#Unlist the data.  What is the class and what do the numbers under BirdSpecies and Birdgenus mean?



#The Class is numeric, and the numbers are related to the fact that
#birdgenus and birdspecies were originally factors

#Question 2:
### The syllable_pattern column in TestData is a factor.  It should not be.
#This data needs to be converted into a list of 25 vectors we will call FacToList.
#####HINT: #You can test if you have done the right thing using the following:
class(FacToList) #list
class(FacToList[[1]]) #numeric








#BONUS:
#Is there a significant difference in the frequency between Chipping Sparrows in
#the US and those in Canada and Mexico?  Visualize the data as you see fit.
#HINT: YOU CAN DO IT!
#HINT: Extra bonus if you figure out what is fishy about the MetaData I gave you
