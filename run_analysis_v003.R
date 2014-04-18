## merge training and test data sets 

library(data.table)

fileName="./UCI HAR Dataset/test/X_test.txt"
con=file(fileName,open="r")
line=readLines(con) 



a <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)




testSub <- fread("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
testX <- fread("./UCI HAR Dataset/test/X_test.txt", sep="\n", header=FALSE)
testY <- fread("./UCI HAR Dataset/test/Y_test.txt", sep="\n", header=FALSE)

trainSub <- fread("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
trainX <- fread("./UCI HAR Dataset/train/X_train.txt", sep="\n", header=FALSE)
trainY <- fread("./UCI HAR Dataset/train/Y_train.txt", sep="\n", header=FALSE)

data.frame(testX)

dfTest <- data.frame(testSub)
names(dfTest)<-"Subject"

dfTest["X_test"] <- testX
dfTest["Y_test"] <- testY

