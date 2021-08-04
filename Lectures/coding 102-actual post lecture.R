#Coding 102!!!
getwd()
setwd("C:/Users/Kara/Documents/R/BirbClass")
TestData<-read.table("abigailtestdata.txt", sep = '\t',header = TRUE, fileEncoding = "UTF-8")

#Bonus:
print(TestData$avg_note_duration.ms.[15])
TestData$avg_note_duration.ms.[15] == 29.57212
1.1 == 1.1
#First, is this entry equal to itself?
TestData$avg_note_duration.ms.[15] == TestData$avg_note_duration.ms.[15]
#Yes!  The computer is not broken.

class(save)
save <- TestData$avg_note_duration.ms.[15]
print(save)
as.character(save)
TestData$avg_note_duration.ms.[15] == 29.5721187025535
all.equal(save, 29.57212)
all.equal(save, 29.57212, tolerance = .01)
 #there is some rounding when the number gets printed
 #rounding the number in the code gets around this!
#Alternatively


#use a tolerance to account for this issue


#Is this an isolated incident?
third <- 1/10+2/10
third == .3
print(third)
as.character(third)
print(third, digits = 20)
all.equal(third, .3)


#Lets think about I've been doing with numbers and letters
#############Rule 5: Characters and numbers can be interconverted to a certain degree
vec <- 1:10
print(vec)
charvec <- as.character(vec)
print(charvec)
mean(vec)
mean(charvec)
mean(as.numeric(charvec))
#does not work
#does work

charvec2 <- c(charvec, "loserspace", "loserspace2")
print(charvec2)
Vec2NA <- as.numeric(charvec2)
print(Vec2NA)
mean(Vec2NA)
mean(Vec2NA[1:10])
testvec <- c(2:8, NA)
Diya <-c(2,6,3,8,9,0,3)
Diya[2]
which(Diya == 2)
##Side note: "as" versus "is" versus w/o either
is.numeric(Diya)
as.numeric(Diya)
numeric(length(Diya))
random = "lol"
random == "lol"
matrix(c(0,1,1,0,1,0,1),nrow=length(Diya), ncol=length(Diya))

vector(length=9)
#what if you ave mixed numbers and letters?







#lets think about 1s and 0s
#boolean is an ON/OFF or TRUE/FALSE way to perfrom logical steps








#############Rule 6: You can use TRUE/FALSE logic to perform conditional tasks
zeros <- c(1,0)
truth <- as.logical(c(3,.4,0,-9,1234567890))
as.numeric(truth)

3 == 3

if(truth[3] == TRUE){
  print("no sh*t sherlock")
}

vec2NA[11] <-NA
vec2NA <- Vec2NA
#What if we don't know which element is NA?
if(is.na(vec2NA[11]) == TRUE){
  vec2NA[11] <- 11
}else {
  print("you good bro")
}
vec2NA

Random <- 1:1000
set.seed(49)
NAindex <- sample(Random, 20, replace = FALSE)
Random[NAindex] <- NA
Random2 <- Random
Random3 <- Random


if(is.na(Random[2]) == TRUE){
  Random[2] <- 2
  print("happened")
}

for(i in somethign){
  do somethgin
}

for(i in Random){
  print(i)
}

for(i in seq_along(2:6)){
  print(i)
}

for(i in Random){
  if(is.na(Random[i]) == TRUE){
    Random[i] <- i
    print("happened")
    print(i)
  } 
}

for(i in 1:length(Random)){
  if(is.na(Random[i]) == TRUE){
    Random[i] <- i
    print(i)
    print("happened")
  } 
}

notInt <- which(is.na(Random3)==TRUE)
Random3[notInt] <- notInt
#Okay we have a problem.  Writing this if-statement 1000 times is stupid

################Rule 7: Repetative tasks can be automated in loops.











#problem, that didn't work. :<  Why?







#i = NA; that means I can't reset the values
#or can I








#However, was this the best way to solve this problem?
#1000 iterations of that loop is a lot for 20 NAs...

################Rule 8: Work smarter, not harder.







#This method reduced our loop to 20 iterations.  That means it runs faster.
#it make not make a big difference to you right now with simple code,
#but with more complex code this can be the difference between 10 minutes and 10 hours!

#Can we do better?
#Yes!  We can avoid the loop all together!



#this is the fastest solution.

#This may seem to be an arguement for not using if statements and loops.  It's not.
#This is an arguement that you should always think about the method you are using.


if(TRUE){}
if(FALSE){}

if(TRUE){
  code1
}else{code2}



if(1){
  code1
}else if(2){
    code2
}else{
    code 3
  }









#test 1000 and 999




#test 1000 and 999





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

#your text answer!!!

###b) Test which columns in TestData are numeric. Return results as a boolean Vector.
###Hint: It would be prudent to create a vector before you try to index it.
#You usually can't index a variable that doesn't exist




###c) Mutiply all numeric rows by 2.

###d) Make a new dataframe from columns 1 and 2.  Prove it is a dataframe.
#Coerce this Dataframe into being a new matrix.  Prove it is a matrix.
#Coerce this matrix into being a new vector.  Prove it is a vector.
#Coerce this vector back into being a dataframe.
#Brefily explain how your final dataframe is different from the original.
#There are two critical features.







#Your Text Answer!

###e) Write code that prints "even" if tested against an even number (x=4) and "odd"
#when tested against an odd number (x=7)
#Hint: google "modulus" if you don't know what that means.
x <- 4 #or 7





#hopefully, that was all fairly straight forward.  Let's combine a bit and then send
#you onto the bonus where you will spend most of your time struggling.


#Question 2: (medium)
###a) Using the final dataframe from 1d, coerce that dataframe into being
#identicle to the first dataframe from 1d.  Reassinging the final dataframe as the
#original one or the data from TestData is cheating. :)
#Hint: there is factor weirdness going on.  I will explain it next time
#For now, know that as.character() will serve you well here




###b) Using the boolean vector from 1b, write a piece of code that will print "numeric"
#if the vector is true.  Otherwise, print the class of the coorsponding column in TestData
###Hint: If you print data.frame, you haven't quite solved the problem









#"BONUS" <- actually you should work the on this, I just don't expect a
#correct answer.  You need to have some code here however, even if it fails!

#Pull up your notes from coding 101!  You will remember that I taught you about the
#components of functions and how to write them.  Let's do that!
#A)
###i) start by writing out the bare bones of your function called TestRun.
###ii) Create two arguments: data and something
###iii) Make the main code print something
###iv) Test your function with data = TestData and something = "Success!"





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
###HINT: RELOAD TESTDATA!  You changed it in the problems above!
















#C) Use TestData2, TestData3, and TestData4 in your code.
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

