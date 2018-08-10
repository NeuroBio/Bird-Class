###Hint: Look up 1) strsplit(), 2) unlist(), and 3) sub()

vec <- 1:10
mat <- matrix(0, nrow = 2, ncol=2)
data <- data.frame(thing = 1:10, thing2 =letters[1:10])
allthethigns <- list(vec, mat, data)
names(allthethigns) <- c("things","stuff", "uninformativenames")
allthethigns[3]
allthethigns$uninformativenames

unlist(allthethigns)

?strsplit()
sentence <- c("this is a sentence!!!!!", "this is a lie")
sen <- strsplit(sentence, "nte")
sen[[1]][3]
paste(sen[[1]], sen[[2]], collapse="", sep = "")

height <- c("6ft5","6ft5", "6ft5","6ft5","6ft5")
height <- strsplit(height, "ft")
height2 <- unlist(height)
height3 <- height2[seq(1,length(height2), 2)]
height3+3

fishy <- c("fish#red#hering", "fish#yellow#fintuna", "fish#blue#marlin")
sub("#", "$", fishy)
