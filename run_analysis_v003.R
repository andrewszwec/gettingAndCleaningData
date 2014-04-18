## init
library(sqldf)


################################################################################################
##    Read in Data from files and add column names
################################################################################################
features <- data.frame(read.table("./UCI HAR Dataset/features.txt", header=FALSE))
activities <- data.frame(read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE))

names(features) <- c("id","name")
names(activities) <- c("id","activityDesc")



ttS <- data.frame(read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE))
ttX <- data.frame(read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE))
ttY <- data.frame(read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE))

names(ttS) <- "Subjects"
names(ttX) <- features$name
names(ttY) <- "activityCodes"

## Join ttY to activity descriptions
actDesc <- sqldf('select b.activityDesc from ttY a left join activities b on a.activityCodes = b.id')

ttX["id"] <- 1:nrow(ttX)

tt <- data.frame(1:nrow(ttS))
names(tt) <- "id"
tt["Subjects"] <- ttS
tt["activityDesc"] <- actDesc
tt <- merge(tt, ttX, by.x="id", by.y="id")

rm(ttS, ttX, ttY,actDesc)


tnS <- data.frame(read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE))
tnX <- data.frame(read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE))
tnY <- data.frame(read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE))

names(tnS) <- "Subjects"
names(tnX) <- features$name
names(tnY) <- "activityCodes"




################################################################################################
##    Merge training and test data sets 
################################################################################################





