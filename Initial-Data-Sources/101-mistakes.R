#Things to keep in mind

#1A
mean(AverageNoteDuration) #the declaration of that variable got deleted, so I can't run it
#1B
TestData[,1] #25 outputs  #this required YOU as a person to manually look at the answer

#1D
plot((TestData[,"num_syllables"]), (TestData[,"bout_duration.ms."]))
#not really a mistake, but the parens are unnecessary; commas tell you that an argument has ended

#2A
index <- which(TestData[,"num_unique_syllables"] > 1)
mean(index)#this is the average of the indicies, not the average of the num sylls

#2B
TestData[1,"avg_note_duration.ms."] > 40
TestData[3,"avg_note_duration.ms."] > 40
TestData[4,"avg_note_duration.ms."] > 40
TestData[5,"avg_note_duration.ms."] > 40
TestData[12,"avg_note_duration.ms."] > 40
TestData[23,"avg_note_duration.ms."] > 40


#you can test all of the values at once!
TestData[c(1,3,4,5,12,23),"avg_note_duration.ms."] > 40

is.vector(TestData[c(1,3,4,5,12,23),"avg_note_duration.ms."] > 40)
#doesn't really answer the question