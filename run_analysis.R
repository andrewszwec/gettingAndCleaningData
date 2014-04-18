##    Author:     Andrew S.
##    Date:       2014-04-18
##
##    Program Description:
##    This program Merges the training and the test sets to create one data set. It re-labels 
##    all the columns to match the corresponding features and activities.
##
##    It extracts only the measurements on the mean and standard deviation for each measurement 
##    and then exports a tidy dataset to a file called "tidyData.csv"
##
##    A second, independent tidy data set with the average of each variable for each activity 
##    and each subject is created an exported as "averages.csv". 
##
##

## Load Libraries
library(sqldf)

################################################################################################
##    Read in reference data from files and add column names
################################################################################################
features <- data.frame(read.table("./UCI HAR Dataset/features.txt", header=FALSE))
activities <- data.frame(read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE))

names(features) <- c("id","name")
names(activities) <- c("id","activityDesc")

################################################################################################
##    Read in Test data from files and add column names
################################################################################################
ttS <- data.frame(read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE))
ttX <- data.frame(read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE))
ttY <- data.frame(read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE))

names(ttS) <- "Subjects"
names(ttX) <- features$name
names(ttY) <- "activityCodes"

## Join ttY to activity descriptions
actDesc <- sqldf('select b.activityDesc from ttY a left join activities b on a.activityCodes = b.id')

## Add an id column to ttX for joining
ttX["id"] <- 1:nrow(ttX)

################################################################################################
##    Make a huge flat data frame for Test Data called 'tt'
################################################################################################

tt <- data.frame(1:nrow(ttS))
names(tt) <- "id"
tt["Subjects"] <- ttS
tt["activityDesc"] <- actDesc
tt <- merge(tt, ttX, by.x="id", by.y="id")
tt["dataSetInd"] <- "TEST"
## remove any data frames you dont need to save memory
rm(ttS, ttX, ttY,actDesc)


################################################################################################
##    Read in Training data from files and add column names
################################################################################################
tnS <- data.frame(read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE))
tnX <- data.frame(read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE))
tnY <- data.frame(read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE))

names(tnS) <- "Subjects"
names(tnX) <- features$name
names(tnY) <- "activityCodes"

## Join tnY to activity descriptions
actDesc <- sqldf('select b.activityDesc from tnY a left join activities b on a.activityCodes = b.id')

## Add an id column to tnX for joining
tnX["id"] <- 1:nrow(tnX)

################################################################################################
##    Make a huge flat data frame for Training Data called 'tn'
################################################################################################

tn <- data.frame(1:nrow(tnS))
names(tn) <- "id"
tn["Subjects"] <- tnS
tn["activityDesc"] <- actDesc
tn <- merge(tn, tnX, by.x="id", by.y="id")
tn["dataSetInd"] <- "TRAINING"
## remove any data frames you dont need to save memory
rm(tnS, tnX, tnY,actDesc)

#########################################################################################################################
##    Merge training and test data sets (dataSetInd describes which dataset the record came from e.g. Training or Test)
#########################################################################################################################

data <- rbind(tn, tt)

#########################################################################################################################
##    Get only measurements on the mean and standard deviation for each measurement
#########################################################################################################################
## Use Grep to get only column names with std() and mean() in them and return the column numbers (or names?)
mypattern <- c("std","mean")
names <- names(data)

## Check each column name for std or mean
mycols <- character()
for (s in mypattern) {
      mycolmask <- lapply(names, grep, pattern=s, ignore.case = TRUE )
      mycols <- cbind(mycols, names[mycolmask == TRUE])
}

colStd <- data.frame(mycols[!is.na(mycols[,1]),1])
names(colStd) <- "columns"
colMean<- data.frame(mycols[!is.na(mycols[,2]),2])
names(colMean) <- "columns"

getCols <- rbind(colStd, colMean)

#########################################################################################################################
##    Create Tidy Dataset
#########################################################################################################################

tidyData <- subset(data, select=c("id","Subjects","activityDesc","tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-std()", "tGravityAccMag-std()", "tBodyAccJerkMag-std()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-std()", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-std()", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyAccMag-mean()", "tGravityAccMag-mean()", "tBodyAccJerkMag-mean()", "tBodyGyroMag-mean()", "tBodyGyroJerkMag-mean()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y", "fBodyAcc-meanFreq()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-meanFreq()-X", "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y", "fBodyGyro-meanFreq()-Z", "fBodyAccMag-mean()", "fBodyAccMag-meanFreq()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-meanFreq()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-meanFreq()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-meanFreq()", "angle(tBodyAccMean,gravity)", "angle(tBodyAccJerkMean),gravityMean)", "angle(tBodyGyroMean,gravityMean)", "angle(tBodyGyroJerkMean,gravityMean)", "angle(X,gravityMean)", "angle(Y,gravityMean)", "angle(Z,gravityMean)" ))

write.csv(tidyData, file="tidyData.csv", row.names=FALSE)

#########################################################################################################################
##    Create second, independant dataset with averages of each variable for each activity 
##    and each subject. Export as "averages.csv".
#########################################################################################################################

## Try colMeans and rowMeans etc...
## averages <- tapply(completeCases$count,completeCases$ID,sum)
## Data is in string not numeric() fix this!!

mean(as.numeric(tidyData['tBodyAcc-std()-X'])

## Good idea, but need to remove NA's
sqldf("select 'id',  'Subjects', 'activityDesc', avg('tBodyAcc-std()-X'), avg('tBodyAcc-std()-Y'), avg('tBodyAcc-std()-Z'), avg('tGravityAcc-std()-X'), avg('tGravityAcc-std()-Y'), avg('tGravityAcc-std()-Z'), avg('tBodyAccJerk-std()-X'), avg('tBodyAccJerk-std()-Y'), avg('tBodyAccJerk-std()-Z'), avg('tBodyGyro-std()-X'), avg('tBodyGyro-std()-Y'), avg('tBodyGyro-std()-Z'), avg('tBodyGyroJerk-std()-X'), avg('tBodyGyroJerk-std()-Y'), avg('tBodyGyroJerk-std()-Z'), avg('tBodyAccMag-std()'), avg('tGravityAccMag-std()'), avg('tBodyAccJerkMag-std()'), avg('tBodyGyroMag-std()'), avg('tBodyGyroJerkMag-std()'), avg('fBodyAcc-std()-X'), avg('fBodyAcc-std()-Y'), avg('fBodyAcc-std()-Z'), avg('fBodyAccJerk-std()-X'), avg('fBodyAccJerk-std()-Y'), avg('fBodyAccJerk-std()-Z'), avg('fBodyGyro-std()-X'), avg('fBodyGyro-std()-Y'), avg('fBodyGyro-std()-Z'), avg('fBodyAccMag-std()'), avg('fBodyBodyAccJerkMag-std()'), avg('fBodyBodyGyroMag-std()'), avg('fBodyBodyGyroJerkMag-std()'), avg('tBodyAcc-mean()-X'), avg('tBodyAcc-mean()-Y'), avg('tBodyAcc-mean()-Z'), avg('tGravityAcc-mean()-X'), avg('tGravityAcc-mean()-Y'), avg('tGravityAcc-mean()-Z'), avg('tBodyAccJerk-mean()-X'), avg('tBodyAccJerk-mean()-Y'), avg('tBodyAccJerk-mean()-Z'), avg('tBodyGyro-mean()-X'), avg('tBodyGyro-mean()-Y'), avg('tBodyGyro-mean()-Z'), avg('tBodyGyroJerk-mean()-X'), avg('tBodyGyroJerk-mean()-Y'), avg('tBodyGyroJerk-mean()-Z'), avg('tBodyAccMag-mean()'), avg('tGravityAccMag-mean()'), avg('tBodyAccJerkMag-mean()'), avg('tBodyGyroMag-mean()'), avg('tBodyGyroJerkMag-mean()'), avg('fBodyAcc-mean()-X'), avg('fBodyAcc-mean()-Y'), avg('fBodyAcc-mean()-Z'), avg('fBodyAcc-meanFreq()-X'), avg('fBodyAcc-meanFreq()-Y'), avg('fBodyAcc-meanFreq()-Z'), avg('fBodyAccJerk-mean()-X'), avg('fBodyAccJerk-mean()-Y'), avg('fBodyAccJerk-mean()-Z'), avg('fBodyAccJerk-meanFreq()-X'), avg('fBodyAccJerk-meanFreq()-Y'), avg('fBodyAccJerk-meanFreq()-Z'), avg('fBodyGyro-mean()-X'), avg('fBodyGyro-mean()-Y'), avg('fBodyGyro-mean()-Z'), avg('fBodyGyro-meanFreq()-X'), avg('fBodyGyro-meanFreq()-Y'), avg('fBodyGyro-meanFreq()-Z'), avg('fBodyAccMag-mean()'), avg('fBodyAccMag-meanFreq()'), avg('fBodyBodyAccJerkMag-mean()'), avg('fBodyBodyAccJerkMag-meanFreq()'), avg('fBodyBodyGyroMag-mean()'), avg('fBodyBodyGyroMag-meanFreq()'), avg('fBodyBodyGyroJerkMag-mean()'), avg('fBodyBodyGyroJerkMag-meanFreq()'), avg('angle(tBodyAccMeangravity)'), avg('angle(tBodyAccJerkMean)gravityMean)'), avg('angle(tBodyGyroMeangravityMean)'), avg('angle(tBodyGyroJerkMeangravityMean)'), avg('angle(XgravityMean)'), avg('angle(YgravityMean)'), avg('angle(ZgravityMean)') from tidyData group by 'Subjects', 'activityDesc'")

write.csv(  ,file="averages.csv", row.names=FALSE)
