## init
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



