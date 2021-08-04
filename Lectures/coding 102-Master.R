#Coding 102!!!
setwd("C:/Users/Kara/Documents/R/BirbClass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")

#Bonus:
print(TestData$avg_note_duration.ms.[15])
TestData$avg_note_duration.ms.[15] == 29.57212

#First, is this entry equal to itself?
TestData$avg_note_duration.ms.[15] == TestData$avg_note_duration.ms.[15]
#Yes!  The computer is not broken.

save <- TestData$avg_note_duration.ms.[15]
print(save)
as.character(save) #there is some rounding when the number gets printed
round(save, digits=5) == 29.57212 #rounding the number in the code gets around this!
#Alternatively
all.equal(save, 29.57212)
all.equal(save, 29.57212, tolerance = .000001)
#use a tolerance to account for this issue


#Is this an isolated incident?
third <- 1/10+2/10
third == .3
print(third)
as.character(third)
print(third, digits = 20)



#Lets think about I've been doing with numbers and letters
#############Rule 5: Characters and numbers can be interconverted to a certain degree
vec <- 1:10
print(vec)
charvec <- as.character(vec)
print(charvec)
mean(vec)
mean(charvec)#does not work
mean(as.numeric(charvec))#does work
##Side note: "as" versus "is" versus w/o either
is.numeric(vec)
as.numeric(vec)
numeric(10)
#what if you ave mixed numbers and letters?
charvec2 <- c(charvec, "loserspace")
print(charvec2)
vec2NA <- as.numeric(charvec2)
print(vec2NA)
mean(vec2NA)
mean(vec2NA[1:10])

#lets think about 1s and 0s
#boolean is an ON/OFF or TRUE/FALSE way to perfrom logical steps
3 == 3
3 == 2

index <- which(is.na(vec2NA)==TRUE)
vec2clean <- vec2NA[-index] 
print(vec2clean)
mean(vec2clean)

#############Rule 6: You can use TRUE/FALSE logic to perform conditional tasks

if(is.na(vec2NA[11])==TRUE){
  vec2NA[11] <- 11
}
print(vec2NA)

#What if we don't know which element is NA?
Random <- 1:1000
set.seed(49)
NAindex <- sample(Random, 20, replace = FALSE)
Random[NAindex] <- NA
Random2 <- Random
Random3 <- Random

if(is.na(Random[1])==TRUE){
  Random[1] <- 1
  print("happened")
}
#Okay we have a problem.  Writing this if-statement 1000 times is stupid

################Rule 7: Repetative tasks can be automated in loops.

for(i in Random){
  print(i)
}


for(i in Random){
  if(is.na(Random[i])==TRUE){
    Random[i] <- i
  }
}
print(Random)
#problem, that didn't work. :<  Why?
for(i in Random){
  if(is.na(Random[i])==TRUE){
    Random[i] <- i
    print(i)
  }
}

#i = NA; that means I can't reset the values
#or can I
for(i in seq_along(Random)){
  if(is.na(Random[i])==TRUE){
    Random[i] <- i
    print(i)
  }
}
print(Random)

#However, was this the best way to solve this problem?
#1000 iterations of that loop is a lot for 20 NAs...

################Rule 8: Work smarter, not harder.
NAindex <- which(is.na(Random2)==TRUE)
for(i in NAindex){
  print(i)
  Random2[i] <- i
}
print(Random2)

#This method reduced our loop to 20 iterations.  That means it runs faster.
#it make not make a big difference to you right now with simple code,
#but with more complex code this can be the difference between 10 minutes and 10 hours!

#Can we do better?
#Yes!  We can avoid the loop all together!
NAindex <- which(is.na(Random2)==TRUE)
Random3[NAindex] <- NAindex
print(Random3)
#this is the fastest solution.

#This may seem to be an arguement for not using if statements and loops.  It's not.
#This is an arguement that you should always think about the method you are using.


if(TRUE){code}
if(FALSE){code}

if(TRUE){
  code1
}else{code2}

if(TRUE){
  code1
}else if(FALSE){code2
}else{code3}

#test 1000 and 999
if(1000/3 == 333){
  print("lolwut")
}else{print("lolno")}

#test 1000 and 999
ifelse(1000/3==333, print("yes"), print("no")) 
ifelse(Random/3==333, print("yes"), print("no"))
output <- ifelse(Random/3==333, print("yes"), print("no"))
output

#Let's do some problems.:)
#########THIS IS YOUR CHEATSHEET:
class()
is.numeric()
length()
names()
#for()
#%%
seq_along()
#if(){
#}else{
#}      #Watch your spaces and ()/{} with if/else statements.  It's easy to mess them up.
print()
rep()
c()


#Question 1: (easy)
###A) Multiply column 2 and 41 in TestData by 2.  What happens to the NAs?
TestData[c(2, 41)] <- TestData[c(2, 41)]*2
#NAs are uneffected

###b) Test which columns in TestData are numeric. Return results as a boolean Vector.
###Hint: It would be prudent to create a vector before you try to index it.
#You usually can't index a variable that doesn't exist
TF <- rep(NA, length(TestData))
for(i in seq_along(TestData)){
  TF[i] <- is.numeric(TestData[,i])
}
print(TF)
###c) Mutiply all numeric rows by 2.
TestData[,TF] <- TestData[,TF]*2
###d) Make a new dataframe from columns 1 and 2.  Prove it is a dataframe.
#Coerce this Dataframe into being a new matrix.  Prove it is a matrix.
#Coerce this matrix into being a new vector.  Prove it is a vector.
#Coerce this vector back into being a dataframe.
#Brefily explain how your final dataframe is different from the original.
#There are two critical features.
NewDataFrame <- TestData[,1:2]
class(NewDataFrame)
NewMatrix <- as.matrix(NewDataFrame)
class(NewMatrix)
NewVector <- as.vector(NewMatrix)
class(NewVector)
DataFrameFinal <- as.data.frame(NewVector)
#The final only has one column and the data is all of type factor

###e) Write code that prints "even" if tested against an even number (x=4) and "odd"
#when tested against an odd number (x=7)
#Hint: google "modulus" if you don't know what that means.
x <- 4 #or 7
if(x%%2 == 1){
  print("odd")
}else{print("even")}


#hopefully, that was all fairly straight forward.  Let's combine a bit and then send
#you onto the bonus where you will spend most of your time struggling.


#Question 2: (medium)
###a) Using the final dataframe from 1d, coerce that dataframe into being
#identicle to the first dataframe from 1d.  Reassinging the final dataframe as the
#original one or the data from TestData is cheating. :)
#Hint: there is factor weirdness going on.  I will explain it next time
#For now, know that as.character() will serve you well here
DataFrameFinal[,2] <- DataFrameFinal[26:50,1]
DataFrameFinal <- DataFrameFinal[1:25,]
DataFrameFinal[,2] <- as.numeric(as.character(DataFrameFinal[,2]))
names(DataFrameFinal) <- c("FileName", "avg_note_duration.ms.")
DataFrameFinal
###b) Using the boolean vector from 1b, write a piece of code that will print "numeric"
#if the vector is true.  Otherwise, print the class of the coorsponding column in TestData
###Hint: If you print data.frame, you haven't quite solved the problem
for(i in seq_along(TestData[,])){
  if(TF[i] == TRUE){
    print("numeric")
  }else{
    print(class(TestData[,i]))
  }
}



#"BONUS" <- actually you should work the on this, I just don't expect a
#correct answer.  You need to have some code here however, even if it fails!

#Pull up your notes from coding 101!  You will remember that I taught you about the
#components of functions and how to write them.  Let's do that!
#A)
###i) start by writing out the bare bones of your function called TestRun.
###ii) Create two arguments: data and something
###iii) Make the main code print something
###iv) Test your function with data = TestData and something = "Success!"
TestRun <- function(data, something){
  print(something)
}
TestRun(data = TestData, something = "Success!")
#B)
###i) Copy the function from above.  We're going to modify it.
###ii) We want our function to examine whether the number of notes
#data in TestData changes based on the sequential repetition.
#break the data into two groups, based on whether they have perfect
# repetition (1) or imperfect repetition (<1)
###iii) Use t.test() to compare the groups and store the output
###iv) If there was a significant difference between the two groups,
#print something.  Otherwise, plot the data with perfect repetition
#in blue and imperfect repetition in black.
###HINT: RELOAD TESTDATA!  You changed it in the problems above!!
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")
data <- TestData
TestRun <- function(data, something){
  perfect <- which(data$sequential_repetition == 1)
  PerfectSeq <- data.frame(data$sequential_repetition[perfect],
                             data$num_notes[perfect])
  ImPerfectSeq <- data.frame(data$sequential_repetition[-perfect],
                            data$num_notes[-perfect])
  output <- t.test(PerfectSeq, ImPerfectSeq)
  
  if(output$p.value < .05){
    print(something)
  }else{
    colors <- rep("black", length(data$sequential_repetition))
    colors[perfect] <- "blue"
    plot(data$sequential_repetition,data$num_notes, col=colors)
  }
}

TestRun(TestData, "significant!")
#C) Test TestData2, TestData3, and TestData4 against your code.
#If any of them fail, go back and modify your function.  Full
#Success means that all of the TestDatas work!
TestData2 <- data.frame(c(rep(1, 13), rep(.5, 12)), c(rep(50, 13), rep(100, 12)))
names(TestData2) <- c("sequential_repetition", "num_notes")
TestData3 <- data.frame(c(rep(1, 12), rep(.5, 12)), c(rep(50, 12), rep(50, 12)))
names(TestData3) <- c("sequential_repetition", "num_notes")
TestData4 <- data.frame(c(rep(75, 12), rep(74, 12)),c(rep(1, 12), rep(.5, 12)))
names(TestData4) <- c( "num_notes", "sequential_repetition")

TestRun(TestData, "significant!")
TestRun(TestData2, "significant!")
TestRun(TestData3, "significant!")
TestRun(TestData4, "significant!")
